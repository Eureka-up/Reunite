from __future__ import annotations

import os, re, secrets, uuid, json
import logging
from pathlib import Path
from datetime import datetime, timedelta, timezone
from typing import Any

import jwt
import psycopg
import httpx
import bcrypt
import numpy as np
from dotenv import load_dotenv
from psycopg.rows import dict_row
from psycopg_pool import ConnectionPool
from fastapi import Depends, FastAPI, File, Form, HTTPException, Query, Request, Response, UploadFile
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field

load_dotenv(Path(__file__).with_name('.env'))
import core
DB_URL = os.getenv("DATABASE_URL") or f"host={os.getenv('DB_HOST')} port={os.getenv('DB_PORT','5432')} dbname={os.getenv('DB_NAME','postgres')} user={os.getenv('DB_USER')} password={os.getenv('DB_PASSWORD')} sslmode=require"
SUPABASE_URL = os.getenv("SUPABASE_URL", "").rstrip("/")
SUPABASE_SERVICE_ROLE_KEY = os.getenv("SUPABASE_SERVICE_ROLE_KEY", "")
STORAGE_BUCKET = "Photos"
JWT_SECRET = os.getenv("JWT_SECRET", "change-me")
JWT_ALGORITHM = "HS256"
AUTH_COOKIE_NAME = os.getenv("AUTH_COOKIE_NAME", "reunite_session")
AUTH_SESSION_DAYS = int(os.getenv("AUTH_SESSION_DAYS", "7"))
AUTH_COOKIE_SECURE = os.getenv("AUTH_COOKIE_SECURE", "true" if os.getenv("ENVIRONMENT", "development").lower() == "production" else "false").lower() == "true"
AUTH_COOKIE_SAMESITE = os.getenv("AUTH_COOKIE_SAMESITE", "none" if os.getenv("ENVIRONMENT", "development").lower() == "production" else "lax").lower()
if AUTH_COOKIE_SAMESITE not in {"lax", "strict", "none"}: AUTH_COOKIE_SAMESITE = "lax"
pool = ConnectionPool(DB_URL, min_size=1, max_size=int(os.getenv("DB_POOL_MAX", "10")), kwargs={"row_factory": dict_row}, open=False)
app = FastAPI(title="Reunite API", version="1.0.0")
logger = logging.getLogger("reunite")
origins = [x.strip() for x in os.getenv("FRONTEND_URL", "http://localhost:5173").split(",")]
app.add_middleware(CORSMiddleware, allow_origins=origins, allow_credentials=True, allow_methods=["*"], allow_headers=["*"])

if os.getenv("ENVIRONMENT", "development").lower() == "production" and JWT_SECRET == "change-me":
    raise RuntimeError("JWT_SECRET must be set in production.")

class PgVectorRepository:
    def __init__(self, database_url: str) -> None:
        self.database_url = database_url

    def upsert_embedding(self, record_id: str, embedding: list[float]) -> None:
        vector = core.serialize_embedding(embedding)
        with psycopg.connect(self.database_url) as connection:
            connection.execute("INSERT INTO embedding (photo_id, vector) VALUES (%s, %s)", (record_id, vector))

    def search_by_embedding(self, embedding: list[float], *, limit: int, threshold: float):
        vector = np.asarray(embedding, dtype=np.float32)
        with psycopg.connect(self.database_url) as connection:
            rows = connection.execute("SELECT e.photo_id, r.report_id, r.kind, e.vector FROM embedding e JOIN photo p ON p.photo_id=e.photo_id JOIN report r ON r.report_id=p.report_id WHERE r.status='OPEN'").fetchall()
        matches = []
        for photo_id, report_id, kind, raw in rows:
            candidate = core.deserialize_embedding(raw)
            if candidate.shape != vector.shape:
                continue
            denominator = np.linalg.norm(vector) * np.linalg.norm(candidate)
            if denominator == 0:
                continue
            similarity = float(np.dot(vector, candidate) / denominator)
            if similarity >= threshold:
                matches.append(core.SearchMatch(record_id=str(photo_id), similarity=similarity, metadata={"report_id": str(report_id), "kind": kind}))
        return sorted(matches, key=lambda item: item.similarity, reverse=True)[:limit]

def embedding_repository() -> PgVectorRepository:
    return PgVectorRepository(DB_URL)

class AuthBody(BaseModel):
    name: str | None = Field(None, min_length=2, max_length=120)
    phone: str = Field(min_length=7, max_length=30)
    password: str = Field(min_length=8, max_length=128)
    city_id: int | None = None
    governorate_id: int | None = None

class PasswordChangeBody(BaseModel):
    current_password: str = Field(min_length=8, max_length=128)
    new_password: str = Field(min_length=8, max_length=128)

class ReportBody(BaseModel):
    kind: str
    name: str = Field(min_length=1, max_length=160)
    age: int | None = Field(None, ge=0, le=130)
    gender: str | None = Field(None, max_length=30)
    occurrence_date: str | None = None
    occurrence_location: Any | None = None
    latitude: float | None = Field(None, ge=-90, le=90)
    longitude: float | None = Field(None, ge=-180, le=180)
    description: str | None = Field(None, max_length=5000)

class CommentBody(BaseModel):
    content: str = Field(min_length=1, max_length=2000)

class AdminUserBody(BaseModel):
    name: str | None = Field(None, min_length=2, max_length=120)
    phone: str | None = Field(None, min_length=7, max_length=30)
    city_id: int | None = None
    role: bool | None = None
    password: str | None = Field(None, min_length=8, max_length=128)

class AdminCreateUserBody(BaseModel):
    name: str = Field(min_length=2, max_length=120)
    phone: str = Field(min_length=7, max_length=30)
    password: str = Field(min_length=8, max_length=128)
    city_id: int
    role: bool = False

def report_coordinates(body: ReportBody) -> tuple[float | None, float | None]:
    if body.latitude is not None or body.longitude is not None:
        if body.latitude is None or body.longitude is None:
            raise HTTPException(422, "Both latitude and longitude are required.")
        return body.latitude, body.longitude
    if body.occurrence_location is None:
        return None, None
    value = str(body.occurrence_location).strip()
    match = re.fullmatch(r"\(\s*(-?\d+(?:\.\d+)?)\s*,\s*(-?\d+(?:\.\d+)?)\s*\)", value)
    if not match:
        raise HTTPException(422, "Select a valid location on the map.")
    longitude, latitude = float(match.group(1)), float(match.group(2))
    if not -180 <= longitude <= 180 or not -90 <= latitude <= 90:
        raise HTTPException(422, "The selected location is outside valid coordinates.")
    return latitude, longitude

def token(user: dict) -> str:
    return jwt.encode({"sub": str(user["user_id"]), "exp": datetime.now(timezone.utc) + timedelta(days=AUTH_SESSION_DAYS)}, JWT_SECRET, algorithm=JWT_ALGORITHM)

def set_auth_cookie(response: Response, value: str):
    response.set_cookie(AUTH_COOKIE_NAME, value, max_age=AUTH_SESSION_DAYS * 24 * 60 * 60, httponly=True, secure=AUTH_COOKIE_SECURE, samesite=AUTH_COOKIE_SAMESITE, path="/")

def clear_auth_cookie(response: Response):
    response.delete_cookie(AUTH_COOKIE_NAME, httponly=True, secure=AUTH_COOKIE_SECURE, samesite=AUTH_COOKIE_SAMESITE, path="/")

def current_user(request: Request):
    session = request.cookies.get(AUTH_COOKIE_NAME)
    if not session: raise HTTPException(401, "Authentication required.")
    try: uid = jwt.decode(session, JWT_SECRET, algorithms=[JWT_ALGORITHM])["sub"]
    except Exception as e: raise HTTPException(401, "Invalid or expired session.") from e
    with pool.connection() as c:
        row = c.execute('SELECT user_id, name, phone, city_id, joined_at, role FROM "User" WHERE user_id=%s', (uid,)).fetchone()
    if not row: raise HTTPException(401, "User not found.")
    return row

def admin_user(user=Depends(current_user)):
    if not user.get("role", False):
        raise HTTPException(403, "Administrator access is required.")
    return user

@app.on_event("startup")
def startup():
    pool.open(wait=True)
    with pool.connection() as c: c.execute("SELECT 1")
    try: core.embedding_service.warm_up()
    except Exception as error: logger.error("Embedding model initialization failed: %s", error)

@app.on_event("shutdown")
def shutdown(): pool.close()

def signed_image_url(path: str, expires_in: int = 3600) -> str | None:
    if not SUPABASE_URL or not SUPABASE_SERVICE_ROLE_KEY: return None
    response = httpx.post(f"{SUPABASE_URL}/storage/v1/object/sign/{STORAGE_BUCKET}", json={"paths": [path], "expiresIn": expires_in}, headers={"Authorization": f"Bearer {SUPABASE_SERVICE_ROLE_KEY}", "apikey": SUPABASE_SERVICE_ROLE_KEY}, timeout=30)
    if response.status_code >= 300: return None
    payload = response.json(); payload = payload[0] if isinstance(payload, list) and payload else payload
    signed = payload.get("signedURL") or payload.get("signedUrl")
    return f"{SUPABASE_URL}/storage/v1{signed}" if signed and signed.startswith("/") else signed

def delete_storage_object(path: str) -> None:
    if not SUPABASE_URL or not SUPABASE_SERVICE_ROLE_KEY or not path:
        return
    try:
        httpx.delete(
            f"{SUPABASE_URL}/storage/v1/object/{STORAGE_BUCKET}/{path}",
            headers={"Authorization": f"Bearer {SUPABASE_SERVICE_ROLE_KEY}", "apikey": SUPABASE_SERVICE_ROLE_KEY},
            timeout=30,
        )
    except httpx.HTTPError:
        pass

def attach_photo_urls(row: dict) -> dict:
    photos = row.get("photos") or []
    row["photos"] = [{**photo, "url": signed_image_url(photo.get("path", ""))} for photo in photos]
    return row

def normalize_report(row: dict) -> dict:
    row = dict(row)
    if not row.get("occurrence_location") and row.get("latitude") is not None and row.get("longitude") is not None:
        row["occurrence_location"] = f"({row['longitude']},{row['latitude']})"
    if row.get("kind") in ("MISSING", "FOUND"): row["kind"] = row["kind"].title()
    if row.get("status") == "OPEN": row["status"] = "Open"
    if row.get("status") in ("RESOLVED", "CANCELLED"): row["status"] = "Closed"
    return attach_photo_urls(row) if "photos" in row else row

@app.get("/api/health")
def health(): return {"success": True, "data": {"status": "ok", "service": "reunite"}}

@app.get("/api/ready")
def readiness():
    database_ready = False
    model_ready = False
    try:
        with pool.connection() as connection: connection.execute("SELECT 1")
        database_ready = True
    except Exception: pass
    try:
        core.embedding_service.warm_up()
        model_ready = True
    except Exception: pass
    if not database_ready or not model_ready:
        raise HTTPException(503, {"database": database_ready, "model": model_ready})
    return {"success": True, "data": {"status": "ready", "database": True, "model": True}}

@app.post("/api/embeddings")
async def create_embedding(image: UploadFile = File(...)):
    try:
        embedding = core.embed_image(await image.read())
        return {"success": True, "data": {"dimension": len(embedding), "embedding": embedding}}
    except core.EmbeddingError as error:
        raise HTTPException(422, str(error)) from error
    except FileNotFoundError as error:
        raise HTTPException(503, str(error)) from error

@app.post("/api/embeddings/store")
async def store_embedding(record_id: str = Form(...), image: UploadFile = File(...), metadata_json: str = Form("{}")):
    try:
        metadata = json.loads(metadata_json)
        if not isinstance(metadata, dict): raise ValueError("metadata_json must be a JSON object.")
        embedding = core.embed_image(await image.read())
        embedding_repository().upsert_embedding(record_id, embedding)
        return {"success": True, "data": {"record_id": record_id, "dimension": len(embedding), "stored": True}}
    except json.JSONDecodeError as error:
        raise HTTPException(422, "metadata_json must be valid JSON.") from error
    except core.EmbeddingError as error:
        raise HTTPException(422, str(error)) from error
    except FileNotFoundError as error:
        raise HTTPException(503, str(error)) from error

@app.post("/api/embeddings/search")
async def search_embeddings(image: UploadFile = File(...), limit: int = Form(5), threshold: float = Form(0.38)):
    try:
        matches = core.embedding_service.search(await image.read(), embedding_repository(), limit=limit, threshold=threshold)
        return {"success": True, "data": {"matches": [match.__dict__ for match in matches]}}
    except core.EmbeddingError as error:
        raise HTTPException(422, str(error)) from error
    except FileNotFoundError as error:
        raise HTTPException(503, str(error)) from error

@app.post("/api/auth/signup")
def signup(body: AuthBody, response: Response):
    if not body.name or body.city_id is None or body.governorate_id is None: raise HTTPException(422, "Name, governorate, and city are required.")
    with pool.connection() as c:
        if c.execute('SELECT 1 FROM "User" WHERE phone=%s', (body.phone,)).fetchone(): raise HTTPException(409, "Phone number is already registered.")
        if not c.execute('SELECT 1 FROM city WHERE city_id=%s AND governorate_id=%s', (body.city_id, body.governorate_id)).fetchone(): raise HTTPException(422, "City does not belong to the selected governorate.")
        password_hash = bcrypt.hashpw(body.password.encode("utf-8"), bcrypt.gensalt()).decode("utf-8")
        row = c.execute('INSERT INTO "User" (name, phone, password_hash, city_id, joined_at) VALUES (%s,%s,%s,%s,now()) RETURNING user_id,name,phone,city_id,joined_at,role', (body.name.strip(), body.phone.strip(), password_hash, body.city_id)).fetchone()
    set_auth_cookie(response, token(row))
    return {"success": True, "data": {"user": row}}

@app.post("/api/auth/forgot-password", status_code=202)
def forgot_password(body: dict):
    return {"success": True, "data": {"message": "If that phone number exists, follow-up instructions will be provided securely."}}

@app.post("/api/auth/login")
def login(body: AuthBody, response: Response):
    with pool.connection() as c: row = c.execute('SELECT * FROM "User" WHERE phone=%s', (body.phone,)).fetchone()
    if not row or not bcrypt.checkpw(body.password.encode("utf-8"), row["password_hash"].encode("utf-8")): raise HTTPException(401, "Invalid phone or password.")
    safe = {k: row[k] for k in ("user_id","name","phone","city_id","joined_at","role")}
    set_auth_cookie(response, token(safe))
    return {"success": True, "data": {"user": safe}}

@app.post("/api/auth/logout")
def logout(response: Response):
    clear_auth_cookie(response)
    return {"success": True, "data": {"message": "Signed out successfully."}}

@app.get("/api/governorates")
def governorates():
    with pool.connection() as c: rows = c.execute('SELECT governorate_id AS id,name FROM governorate ORDER BY name').fetchall()
    return {"success": True, "data": rows}

@app.get("/api/governorates/{gov_id}/cities")
def cities(gov_id: int):
    with pool.connection() as c: rows = c.execute('SELECT city_id AS id,governorate_id AS gov_id,name FROM city WHERE governorate_id=%s ORDER BY name', (gov_id,)).fetchall()
    return {"success": True, "data": rows}

@app.get("/api/reports")
def reports(page: int=Query(1, ge=1), limit: int=Query(20, ge=1, le=100), kind: str|None=None, status: str|None=None, search: str|None=None):
    where, args = [], []
    if kind in ("Found","Missing"): where.append("r.kind=%s"); args.append(kind.upper())
    if status in ("Open","Closed"): where.append("r.status=%s"); args.append("OPEN" if status == "Open" else "RESOLVED")
    if search: where.append("(r.name ILIKE %s OR r.latitude::text ILIKE %s OR r.longitude::text ILIKE %s)"); args += [f"%{search}%", f"%{search}%", f"%{search}%"]
    clause = " WHERE " + " AND ".join(where) if where else ""
    with pool.connection() as c:
        total = c.execute(f'SELECT COUNT(*) AS total FROM report r{clause}', args).fetchone()["total"]
        rows = c.execute(f'SELECT r.*, COALESCE(json_agg(json_build_object(\'id\',p.photo_id,\'path\',p.path)) FILTER (WHERE p.photo_id IS NOT NULL), \'[]\') AS photos FROM report r LEFT JOIN photo p ON p.report_id=r.report_id{clause} GROUP BY r.report_id ORDER BY r.created_at DESC LIMIT %s OFFSET %s', [*args, limit, (page-1)*limit]).fetchall()
    return {"success": True, "data": {"items": [normalize_report(row) for row in rows], "page": page, "limit": limit, "total": total}}

@app.get("/api/me")
def me(user=Depends(current_user)): return {"success": True, "data": user}

@app.patch("/api/me")
def update_me(body: dict, user=Depends(current_user)):
    name = body.get("name"); city_id = body.get("city_id")
    if not name and city_id is None: raise HTTPException(422, "Nothing to update.")
    with pool.connection() as c:
        row = c.execute('UPDATE "User" SET name=COALESCE(%s,name), city_id=COALESCE(%s,city_id) WHERE user_id=%s RETURNING user_id,name,phone,city_id,joined_at', (name,city_id,user["user_id"])).fetchone()
    return {"success": True, "data": row}

@app.patch("/api/me/password")
def change_password(body: PasswordChangeBody, user=Depends(current_user)):
    with pool.connection() as c:
        row = c.execute('SELECT password_hash FROM "User" WHERE user_id=%s', (user["user_id"],)).fetchone()
        if not row or not bcrypt.checkpw(body.current_password.encode("utf-8"), row["password_hash"].encode("utf-8")):
            raise HTTPException(400, "Current password is incorrect.")
        password_hash = bcrypt.hashpw(body.new_password.encode("utf-8"), bcrypt.gensalt()).decode("utf-8")
        c.execute('UPDATE "User" SET password_hash=%s WHERE user_id=%s', (password_hash, user["user_id"]))
    return {"success": True, "data": {"message": "Password updated successfully."}}

@app.get("/api/me/reports")
def my_reports(user=Depends(current_user)):
    with pool.connection() as c:
        rows = c.execute('SELECT r.*, COALESCE(json_agg(json_build_object(\'id\',p.photo_id,\'path\',p.path)) FILTER (WHERE p.photo_id IS NOT NULL), \'[]\') AS photos FROM report r LEFT JOIN photo p ON p.report_id=r.report_id WHERE r.user_id=%s GROUP BY r.report_id ORDER BY r.created_at DESC', (user["user_id"],)).fetchall()
    return {"success": True, "data": [normalize_report(row) for row in rows]}

@app.get("/api/admin/users")
def admin_users(user=Depends(admin_user)):
    with pool.connection() as c:
        rows = c.execute('''SELECT u.user_id,u.name,u.phone,u.city_id,c.governorate_id,u.joined_at,u.role,
            COUNT(DISTINCT r.report_id) AS report_count
            FROM "User" u LEFT JOIN city c ON c.city_id=u.city_id LEFT JOIN report r ON r.user_id=u.user_id
            GROUP BY u.user_id,c.governorate_id ORDER BY u.joined_at DESC''').fetchall()
    return {"success": True, "data": rows}

@app.post("/api/admin/users")
def admin_create_user(body: AdminCreateUserBody, user=Depends(admin_user)):
    password_hash = bcrypt.hashpw(body.password.encode("utf-8"), bcrypt.gensalt()).decode("utf-8")
    try:
        with pool.connection() as c:
            if not c.execute('SELECT 1 FROM city WHERE city_id=%s', (body.city_id,)).fetchone():
                raise HTTPException(422, "City does not exist.")
            row = c.execute('''INSERT INTO "User" (name,phone,password_hash,city_id,joined_at,role)
                VALUES (%s,%s,%s,%s,now(),%s)
                RETURNING user_id,name,phone,city_id,joined_at,role''', (body.name.strip(), body.phone.strip(), password_hash, body.city_id, body.role)).fetchone()
    except psycopg.errors.UniqueViolation as error:
        raise HTTPException(409, "Phone number is already registered.") from error
    return {"success": True, "data": row}

@app.patch("/api/admin/users/{user_id}")
def admin_update_user(user_id: int, body: AdminUserBody, user=Depends(admin_user)):
    if user_id == user["user_id"] and body.role is False:
        raise HTTPException(422, "You cannot remove administrator access from your own account.")
    values = []
    assignments = []
    if body.name is not None: assignments.append("name=%s"); values.append(body.name.strip())
    if body.phone is not None: assignments.append("phone=%s"); values.append(body.phone.strip())
    if body.city_id is not None: assignments.append("city_id=%s"); values.append(body.city_id)
    if body.role is not None: assignments.append("role=%s"); values.append(body.role)
    if body.password is not None:
        assignments.append("password_hash=%s")
        values.append(bcrypt.hashpw(body.password.encode("utf-8"), bcrypt.gensalt()).decode("utf-8"))
    if not assignments: raise HTTPException(422, "Nothing to update.")
    values.append(user_id)
    try:
        with pool.connection() as c:
            row = c.execute(f'UPDATE "User" SET {",".join(assignments)} WHERE user_id=%s RETURNING user_id,name,phone,city_id,joined_at,role', values).fetchone()
    except psycopg.errors.UniqueViolation as error:
        raise HTTPException(409, "Phone number is already registered.") from error
    if not row: raise HTTPException(404, "User not found.")
    return {"success": True, "data": row}

@app.delete("/api/admin/users/{user_id}")
def admin_delete_user(user_id: int, user=Depends(admin_user)):
    if user_id == user["user_id"]:
        raise HTTPException(422, "You cannot delete your own administrator account.")
    with pool.connection() as c:
        target = c.execute('SELECT user_id FROM "User" WHERE user_id=%s', (user_id,)).fetchone()
        if not target: raise HTTPException(404, "User not found.")
        paths = c.execute('SELECT p.path FROM photo p JOIN report r ON r.report_id=p.report_id WHERE r.user_id=%s', (user_id,)).fetchall()
        c.execute('DELETE FROM comment WHERE user_id=%s', (user_id,))
        c.execute('DELETE FROM comment WHERE report_id IN (SELECT report_id FROM report WHERE user_id=%s)', (user_id,))
        c.execute('DELETE FROM embedding WHERE photo_id IN (SELECT p.photo_id FROM photo p JOIN report r ON r.report_id=p.report_id WHERE r.user_id=%s)', (user_id,))
        c.execute('DELETE FROM photo WHERE report_id IN (SELECT report_id FROM report WHERE user_id=%s)', (user_id,))
        c.execute('DELETE FROM report WHERE user_id=%s', (user_id,))
        c.execute('DELETE FROM "User" WHERE user_id=%s', (user_id,))
    for path in paths: delete_storage_object(path["path"])
    return {"success": True, "data": {"deleted": True}}

@app.get("/api/reports/{report_id}")
def report(report_id: int, user=Depends(current_user)):
    with pool.connection() as c: row = c.execute('SELECT r.*, u.name AS reporter_name, u.phone AS reporter_phone, COALESCE(json_agg(json_build_object(\'id\',p.photo_id,\'path\',p.path)) FILTER (WHERE p.photo_id IS NOT NULL), \'[]\') AS photos FROM report r JOIN "User" u ON u.user_id=r.user_id LEFT JOIN photo p ON p.report_id=r.report_id WHERE r.report_id=%s GROUP BY r.report_id,u.name,u.phone', (report_id,)).fetchone()
    if not row: raise HTTPException(404, "Report not found.")
    return {"success": True, "data": normalize_report(row)}

@app.post("/api/reports")
def create_report(body: ReportBody, user=Depends(current_user)):
    if body.kind not in ("Found","Missing"): raise HTTPException(422, "Invalid report kind.")
    if body.gender and body.gender not in ("Male", "Female"): raise HTTPException(422, "Gender must be Male or Female.")
    latitude, longitude = report_coordinates(body)
    with pool.connection() as c: row = c.execute('INSERT INTO report (user_id,kind,name,age,gender,occurrence_date,latitude,longitude,description,status,created_at) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,\'OPEN\',now()) RETURNING *', (user["user_id"],body.kind.upper(),body.name,body.age,body.gender.upper() if body.gender else None,body.occurrence_date,latitude,longitude,body.description)).fetchone()
    return {"success": True, "data": normalize_report(row)}

@app.post("/api/reports/{report_id}/comments")
def comment(report_id: int, body: CommentBody, user=Depends(current_user)):
    with pool.connection() as c:
        row = c.execute('INSERT INTO comment (user_id,report_id,content,added_at) VALUES (%s,%s,%s,now()) RETURNING comment_id,report_id,user_id,content,added_at', (user["user_id"],report_id,body.content.strip())).fetchone()
    return {"success": True, "data": {**row, "author_name": user["name"], "author_phone": user["phone"]}}

@app.patch("/api/reports/{report_id}")
def update_report(report_id: int, body: ReportBody, user=Depends(current_user)):
    if body.kind not in ("Found", "Missing"): raise HTTPException(422, "Invalid report kind.")
    if body.gender and body.gender not in ("Male", "Female"): raise HTTPException(422, "Gender must be Male or Female.")
    with pool.connection() as c:
        owner = c.execute('SELECT user_id FROM report WHERE report_id=%s', (report_id,)).fetchone()
        if not owner: raise HTTPException(404, "Report not found.")
        if str(owner["user_id"]) != str(user["user_id"]) and not user.get("role", False): raise HTTPException(403, "You cannot modify this report.")
        latitude, longitude = report_coordinates(body)
        row = c.execute('UPDATE report SET kind=%s,name=%s,age=%s,gender=%s,occurrence_date=%s,latitude=%s,longitude=%s,description=%s WHERE report_id=%s RETURNING *', (body.kind.upper(),body.name,body.age,body.gender.upper() if body.gender else None,body.occurrence_date,latitude,longitude,body.description,report_id)).fetchone()
    return {"success": True, "data": row}

@app.post("/api/reports/{report_id}/close")
def close_report(report_id: int, user=Depends(current_user)):
    with pool.connection() as c:
        owner = c.execute('SELECT user_id FROM report WHERE report_id=%s', (report_id,)).fetchone()
        if not owner: raise HTTPException(404, "Report not found.")
        if str(owner["user_id"]) != str(user["user_id"]) and not user.get("role", False): raise HTTPException(403, "You cannot close this report.")
        row = c.execute('UPDATE report SET status=\'RESOLVED\',closed_at=now() WHERE report_id=%s RETURNING *', (report_id,)).fetchone()
    return {"success": True, "data": row}

@app.delete("/api/reports/{report_id}")
def delete_report(report_id: int, user=Depends(admin_user)):
    with pool.connection() as c:
        paths = c.execute('SELECT path FROM photo WHERE report_id=%s', (report_id,)).fetchall()
        if not c.execute('SELECT 1 FROM report WHERE report_id=%s', (report_id,)).fetchone():
            raise HTTPException(404, "Report not found.")
        c.execute('DELETE FROM comment WHERE report_id=%s', (report_id,))
        c.execute('DELETE FROM embedding WHERE photo_id IN (SELECT photo_id FROM photo WHERE report_id=%s)', (report_id,))
        c.execute('DELETE FROM photo WHERE report_id=%s', (report_id,))
        c.execute('DELETE FROM report WHERE report_id=%s', (report_id,))
    for path in paths: delete_storage_object(path["path"])
    return {"success": True, "data": {"deleted": True}}

@app.post("/api/reports/{report_id}/photos")
async def upload_photo(report_id: int, file: UploadFile = File(...), user=Depends(current_user)):
    if file.content_type not in ("image/jpeg", "image/png", "image/webp"): raise HTTPException(422, "Only JPEG, PNG, or WebP images are allowed.")
    data = await file.read()
    if len(data) > 10 * 1024 * 1024: raise HTTPException(413, "Image is too large.")
    with pool.connection() as c:
        owner = c.execute('SELECT user_id FROM report WHERE report_id=%s', (report_id,)).fetchone()
        if not owner: raise HTTPException(404, "Report not found.")
        if str(owner["user_id"]) != str(user["user_id"]) and not user.get("role", False): raise HTTPException(403, "You cannot add photos to this report.")
        name = f"reports/{report_id}/{uuid.uuid4().hex}{Path(file.filename or 'image.jpg').suffix.lower()}"
        if not SUPABASE_URL or not SUPABASE_SERVICE_ROLE_KEY: raise HTTPException(503, "Image storage is not configured.")
        storage_url = f"{SUPABASE_URL}/storage/v1/object/{STORAGE_BUCKET}/{name}"
        storage_headers = {"Authorization": f"Bearer {SUPABASE_SERVICE_ROLE_KEY}", "apikey": SUPABASE_SERVICE_ROLE_KEY, "Content-Type": file.content_type}
        storage = httpx.put(storage_url, content=data, headers=storage_headers, timeout=60)
        if storage.status_code >= 300: raise HTTPException(503, "Image storage is unavailable.")
        row = c.execute('INSERT INTO photo (report_id,path,uploaded_at) VALUES (%s,%s,now()) RETURNING photo_id,report_id,path,uploaded_at', (report_id, name)).fetchone()
    embedding_status = "not_generated"
    try:
        embedding_repository().upsert_embedding(str(row["photo_id"]), core.embed_image(data))
        embedding_status = "stored"
    except Exception:
        embedding_status = "failed"
    return {"success": True, "data": {**row, "url": signed_image_url(row["path"]), "embedding_status": embedding_status}}

@app.delete("/api/photos/{photo_id}")
def delete_photo(photo_id: int, user=Depends(current_user)):
    with pool.connection() as c:
        row = c.execute('SELECT p.photo_id,p.path,r.user_id FROM photo p JOIN report r ON r.report_id=p.report_id WHERE p.photo_id=%s', (photo_id,)).fetchone()
        if not row: raise HTTPException(404, "Photo not found.")
        if str(row["user_id"]) != str(user["user_id"]) and not user.get("role", False): raise HTTPException(403, "You cannot delete this photo.")
        c.execute('DELETE FROM photo WHERE photo_id=%s', (photo_id,))
    return {"success": True, "data": {"deleted": True}}

@app.post("/api/search/photo")
async def search_photo(file: UploadFile = File(...)):
    if file.content_type not in ("image/jpeg", "image/png", "image/webp"): raise HTTPException(422, "Only image files are allowed.")
    try:
        matches = [match.__dict__ for match in core.embedding_service.search(await file.read(), embedding_repository())]
    except FileNotFoundError as error:
        raise HTTPException(503, "Embedding model is not configured.") from error
    except core.EmbeddingError as error:
        raise HTTPException(422, str(error)) from error
    result = []
    with pool.connection() as c:
        for match in matches:
            row = c.execute('SELECT r.*, json_build_array(json_build_object(\'id\',p.photo_id,\'path\',p.path)) AS photos FROM photo p JOIN report r ON r.report_id=p.report_id WHERE p.photo_id=%s AND r.status=\'OPEN\'', (match.get("record_id"),)).fetchone()
            if row: result.append({"report": normalize_report(row), "similarity": match.get("similarity")})
    return {"success": True, "data": result}

@app.get("/api/search/reports")
def search_reports(search: str = "", kind: str | None = None):
    return reports(search=search, kind=kind, status="Open")

@app.get("/api/reports/{report_id}/comments")
def comments(report_id: int, user=Depends(current_user)):
    with pool.connection() as c: rows = c.execute('SELECT c.comment_id,c.report_id,c.user_id,c.content,c.added_at,u.name AS author_name,u.phone AS author_phone FROM comment c JOIN "User" u ON u.user_id=c.user_id WHERE c.report_id=%s ORDER BY c.added_at', (report_id,)).fetchall()
    return {"success": True, "data": rows}
