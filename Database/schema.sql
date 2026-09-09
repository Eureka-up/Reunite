-- Reunite PostgreSQL schema. Run this against the Supabase SQL editor once.
CREATE TABLE IF NOT EXISTS governorate (
  governorate_id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS city (
  city_id BIGSERIAL PRIMARY KEY,
  governorate_id BIGINT NOT NULL REFERENCES governorate(governorate_id) ON DELETE RESTRICT,
  name TEXT NOT NULL,
  UNIQUE (governorate_id, name)
);

CREATE TABLE IF NOT EXISTS "User" (
  user_id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  phone TEXT NOT NULL UNIQUE,
  password_hash TEXT NOT NULL,
  city_id BIGINT REFERENCES city(city_id) ON DELETE SET NULL,
  joined_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  role BOOLEAN NOT NULL DEFAULT false
);

CREATE TABLE IF NOT EXISTS report (
  report_id BIGSERIAL PRIMARY KEY,
  user_id BIGINT NOT NULL REFERENCES "User"(user_id) ON DELETE CASCADE,
  kind TEXT NOT NULL CHECK (kind IN ('MISSING', 'FOUND')),
  name TEXT NOT NULL,
  age INTEGER CHECK (age >= 0 AND age <= 130),
  gender TEXT,
  occurrence_date DATE,
  latitude DOUBLE PRECISION,
  longitude DOUBLE PRECISION,
  description TEXT,
  status TEXT NOT NULL DEFAULT 'OPEN' CHECK (status IN ('OPEN', 'RESOLVED', 'CANCELLED')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  closed_at TIMESTAMPTZ,
  CHECK ((latitude IS NULL AND longitude IS NULL) OR (latitude BETWEEN -90 AND 90 AND longitude BETWEEN -180 AND 180))
);

CREATE TABLE IF NOT EXISTS photo (
  photo_id BIGSERIAL PRIMARY KEY,
  report_id BIGINT NOT NULL REFERENCES report(report_id) ON DELETE CASCADE,
  path TEXT NOT NULL UNIQUE,
  uploaded_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS embedding (
  photo_id BIGINT PRIMARY KEY REFERENCES photo(photo_id) ON DELETE CASCADE,
  vector BYTEA NOT NULL
);

CREATE TABLE IF NOT EXISTS comment (
  comment_id BIGSERIAL PRIMARY KEY,
  report_id BIGINT NOT NULL REFERENCES report(report_id) ON DELETE CASCADE,
  user_id BIGINT NOT NULL REFERENCES "User"(user_id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  added_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS report_status_created_idx ON report(status, created_at DESC);
CREATE INDEX IF NOT EXISTS report_user_idx ON report(user_id);
CREATE INDEX IF NOT EXISTS photo_report_idx ON photo(report_id);
CREATE INDEX IF NOT EXISTS comment_report_idx ON comment(report_id, added_at);
