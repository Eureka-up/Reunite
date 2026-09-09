import type { Report, ReportKind } from "@/types";

const API_URL =
  (import.meta.env.VITE_API_URL as string | undefined) ||
  (import.meta.env.VITE_BASE_URL as string | undefined) ||
  "http://localhost:8080/api";

// Authentication is intentionally cookie-only. Remove the legacy token once for
// users upgrading from the previous localStorage-based implementation.
try { localStorage.removeItem("reunite_token"); } catch { /* storage may be unavailable */ }
let sessionKnown = false;
export function getToken() { return sessionKnown ? "cookie-session" : null; }
export function setToken(_token: string | null) {
  sessionKnown = Boolean(_token);
  if (!_token) void logout().catch(() => undefined);
}
export function markSessionKnown(value: boolean) { sessionKnown = value; }

export class ApiError extends Error {
  constructor(message: string, public readonly status: number) {
    super(message);
    this.name = "ApiError";
  }
}

function readableError(value: unknown): string {
  if (typeof value === "string" && value.trim()) return value;
  if (Array.isArray(value)) {
    const messages = value
      .map(item => readableError(typeof item === "object" && item !== null && "msg" in item ? item.msg : item))
      .filter(Boolean);
    return messages.join(" ");
  }
  if (typeof value === "object" && value !== null) {
    const record = value as Record<string, unknown>;
    for (const key of ["message", "msg", "detail", "error"]) {
      const message = readableError(record[key]);
      if (message) return message;
    }
  }
  return "";
}

export async function apiRequest<T>(
  path: string,
  init: RequestInit = {},
): Promise<T> {
  const headers = new Headers(init.headers);
  if (!(init.body instanceof FormData))
    headers.set("Content-Type", "application/json");
  let response: Response;
  try {
    response = await fetch(`${API_URL}${path}`, { ...init, headers, credentials: "include" });
  } catch {
    throw new Error("We couldn't reach Reunite right now. Please check your connection and try again.");
  }
  const payload = await response.json().catch(() => null);
  if (!response.ok) {
    if (response.status === 401 && !path.startsWith("/auth/") && path !== "/me") window.dispatchEvent(new Event("reunite-session-expired"));
    const message = readableError(payload?.error) || readableError(payload?.detail) || readableError(payload);
    const fallback = response.status === 401
      ? "Your phone number or password is incorrect."
      : response.status === 403
        ? "You don't have permission to do that."
        : response.status === 404
          ? "We couldn't find what you requested."
          : response.status >= 500
            ? "Reunite is having trouble right now. Please try again shortly."
            : "Please check the form and try again.";
    throw new ApiError(message || fallback, response.status);
  }
  return (payload?.data ?? payload) as T;
}
export type AuthResponse = { user: Record<string, unknown> };
export const login = (phone: string, password: string) =>
  apiRequest<AuthResponse>("/auth/login", {
    method: "POST",
    body: JSON.stringify({ phone, password }),
  });
export const signup = (body: {
  name: string;
  phone: string;
  password: string;
  city_id: number;
  governorate_id: number;
}) =>
  apiRequest<AuthResponse>("/auth/signup", {
    method: "POST",
    body: JSON.stringify(body),
  });
export const logout = () => apiRequest<{ message: string }>("/auth/logout", { method: "POST" });
export const me = () => apiRequest<Record<string, unknown>>("/me");
export const myReports = () => apiRequest<Report[]>("/me/reports").then((items) => items.map(normalizeReport));
export function locationLabel(value: string | null): string {
  if (!value) return "Location not specified";
  const match = value.match(/^\(([-\d.]+),([-\d.]+)\)$/);
  return match
    ? `${Number(match[2]).toFixed(4)}, ${Number(match[1]).toFixed(4)}`
    : value;
}
export function normalizeReport(value: unknown): Report {
  const raw = value as Record<string, unknown>;
  const photos = Array.isArray(raw.photos) ? raw.photos : [];
  const rawLocation = typeof raw.occurrence_location === "string" && raw.occurrence_location.trim() ? raw.occurrence_location : null;
  const latitude = raw.latitude ?? raw.lat;
  const longitude = raw.longitude ?? raw.lng;
  return {
    ...raw,
    id: String(raw.id ?? raw.report_id),
    kind: String(raw.kind).toLowerCase() === "found" ? "Found" : "Missing",
    status: ["resolved", "cancelled", "closed"].includes(String(raw.status).toLowerCase()) ? "Closed" : "Open",
    name: String(raw.name ?? "Unknown person"),
    age: typeof raw.age === "number" ? raw.age : null,
    gender: typeof raw.gender === "string" ? ({ MALE: "Male", FEMALE: "Female", male: "Male", female: "Female" }[raw.gender] || raw.gender) : null,
    occurrence_date: typeof raw.occurrence_date === "string" ? raw.occurrence_date : null,
    occurrence_location: rawLocation || (latitude != null && longitude != null ? `(${String(longitude)},${String(latitude)})` : null),
    description: typeof raw.description === "string" ? raw.description : null,
    created_at: typeof raw.created_at === "string" ? raw.created_at : new Date().toISOString(),
    photos: photos.filter((photo): photo is Record<string, unknown> => typeof photo === "object" && photo !== null).map(photo => ({ id: String(photo.id ?? photo.photo_id), path: String(photo.url ?? photo.path ?? ""), url: typeof photo.url === "string" ? photo.url : undefined })),
  };
}
export const reports = (
  params: Record<string, string | number | undefined> = {},
) => {
  const query = new URLSearchParams(
    Object.entries(params)
      .filter(([, v]) => v !== undefined)
      .map(([k, v]) => [k, String(v)]),
  );
  return apiRequest<{
    items: Report[];
    page: number;
    limit: number;
    total: number;
  }>(`/reports?${query}`).then((result) => ({ ...result, items: result.items.map(normalizeReport) }));
};
export const report = (id: string) => apiRequest<Report>(`/reports/${id}`).then(normalizeReport);
export async function createReport(input: {
  kind: ReportKind;
  name: string;
  age?: number | null;
  gender?: string;
  occurrenceDate?: string;
  occurrenceLocation?: string;
  description?: string;
  photo?: File | File[] | null;
  onUploadProgress?: (percent: number) => void;
}) {
  const createdResponse = await apiRequest<Report>("/reports", {
    method: "POST",
    body: JSON.stringify({
      kind: input.kind,
      name: input.name,
      age: input.age ?? null,
      gender: input.gender || null,
      occurrence_date: input.occurrenceDate || null,
      occurrence_location: input.occurrenceLocation || null,
      description: input.description || null,
    }),
  });
  const created = normalizeReport(createdResponse);
  const photos = input.photo ? (Array.isArray(input.photo) ? input.photo : [input.photo]) : [];
  if (photos.length && created.id) {
    for (const [index, photo] of photos.entries()) {
      await uploadPhoto(created.id, photo, percent => input.onUploadProgress?.(Math.round(((index * 100) + percent) / photos.length)));
    }
    return report(created.id);
  }
  return created;
}
export function uploadPhoto(reportId: string, photo: File, onProgress?: (percent: number) => void) {
  const form = new FormData();
  form.append("file", photo);
  return new Promise<unknown>((resolve, reject) => {
    const xhr = new XMLHttpRequest();
    xhr.open("POST", `${API_URL}/reports/${reportId}/photos`);
    xhr.withCredentials = true;
    xhr.upload.onprogress = event => {
      if (event.lengthComputable) onProgress?.(Math.round((event.loaded / event.total) * 100));
    };
    xhr.onerror = () => reject(new Error("The photo could not be uploaded. Check your connection and try again."));
    xhr.onload = () => {
      let payload: unknown = null;
      try { payload = JSON.parse(xhr.responseText); } catch { /* handled by fallback below */ }
      if (xhr.status < 200 || xhr.status >= 300) {
        const message = readableError((payload as { error?: unknown } | null)?.error) || readableError((payload as { detail?: unknown } | null)?.detail);
        reject(new Error(message || "The photo could not be uploaded."));
        return;
      }
      onProgress?.(100);
      resolve((payload as { data?: unknown } | null)?.data ?? payload);
    };
    xhr.send(form);
  });
}
export const closeReport = (id: string) =>
  apiRequest(`/reports/${id}/close`, { method: "POST" });
export const deleteReport = (id: string) =>
  apiRequest<{ deleted: boolean }>(`/reports/${id}`, { method: "DELETE" });
export const updateReport = (id: string, input: {
  kind: ReportKind;
  name: string;
  age?: number | null;
  gender?: string;
  occurrenceDate?: string;
  occurrenceLocation?: string;
  description?: string;
}) => apiRequest<Report>(`/reports/${id}`, {
  method: "PATCH",
  body: JSON.stringify({
    kind: input.kind,
    name: input.name,
    age: input.age ?? null,
    gender: input.gender || null,
    occurrence_date: input.occurrenceDate || null,
    occurrence_location: input.occurrenceLocation || null,
    description: input.description || null,
  }),
}).then(normalizeReport);
export const updateProfile = (body: { name: string }) =>
  apiRequest<Record<string, unknown>>("/me", {
    method: "PATCH",
    body: JSON.stringify(body),
  });
export const changePassword = (currentPassword: string, newPassword: string) =>
  apiRequest<{ message: string }>("/me/password", {
    method: "PATCH",
    body: JSON.stringify({ current_password: currentPassword, new_password: newPassword }),
  });
export const comments = (id: string) => apiRequest(`/reports/${id}/comments`);
export const addComment = (id: string, content: string) =>
  apiRequest(`/reports/${id}/comments`, {
    method: "POST",
    body: JSON.stringify({ content }),
  });
export const governorates = () =>
  apiRequest<{ id: number; name: string }[]>("/governorates");
export const cities = (govId: number) =>
  apiRequest<{ id: number; gov_id: number; name: string }[]>(
    `/governorates/${govId}/cities`,
  );
export type AdminUser = {
  user_id: number;
  name: string;
  phone: string;
  city_id: number | null;
  governorate_id?: number | null;
  joined_at: string;
  role: boolean;
  report_count: number;
};
export const adminUsers = () => apiRequest<AdminUser[]>("/admin/users");
export const adminCreateUser = (body: { name: string; phone: string; password: string; city_id: number; role?: boolean }) =>
  apiRequest<AdminUser>("/admin/users", { method: "POST", body: JSON.stringify(body) });
export const adminUpdateUser = (id: number, body: { name?: string; phone?: string; city_id?: number | null; role?: boolean; password?: string }) =>
  apiRequest<AdminUser>(`/admin/users/${id}`, { method: "PATCH", body: JSON.stringify(body) });
export const adminDeleteUser = (id: number) =>
  apiRequest<{ deleted: boolean }>(`/admin/users/${id}`, { method: "DELETE" });
export const searchByPhoto = (image: File) => {
  const form = new FormData();
  form.append("file", image);
  return apiRequest<{ report: Report; similarity: number }[]>("/search/photo", {
    method: "POST",
    body: form,
  }).then((matches) => matches.map((match) => ({ ...match, report: normalizeReport(match.report) })));
};
