# Reunitee — رجّع طفل لأهله ❤️

**Reunitee** is a community Flutter app that helps reunite missing children with
their families. Users can report a missing child, report a found child, submit
sightings, browse/search cases, view them on a map, and receive nearby-alert
notifications.

- Arabic-first (RTL) with English support (`easy_localization`, `assets/translations/`)
- Light + dark themes (`core/theme`)
- Offline-first demo mode with mock repositories; flip one flag to use the real REST API
- Clean architecture per feature: `data / domain / presentation`
- Every screen file ≤ **150 lines**: each screen lives in its own folder with
  `*_screen.dart` (thin composition) + `widgets/` + `sections/` + `*_controller.dart`

---

## 1. Project structure

```
lib/
├── main.dart                      # bootstrap: Hive, DI, EasyLocalization, router
├── core/
│   ├── constants/                 # app_constants.dart, egypt_locations.dart (offline bundle)
│   │                              # NB: UI never reads the bundle directly — see locations/
│   ├── locations/                 # LocationsRepository: GET /locations/governorates
│   │                              # (mock = bundled list, remote = API + offline fallback)
│   ├── di/                        # app_di.dart (core), feature_di.dart (mock ↔ remote switch)
│   ├── errors/                    # failures.dart (typed AppFailure)
│   ├── network/                   # api_client.dart (Dio), api_config.dart, api_endpoints.dart
│   ├── router/                    # app_router.dart + app_router.gr.dart (auto_route)
│   ├── services/                  # location, connectivity, push (mock)
│   ├── settings/                  # AppSettingsCubit (theme/locale/radius)
│   ├── storage/                   # Hive boxes: auth / prefs / cache
│   ├── theme/                     # palette, color-scheme, components, extras (all ≤150 lines)
│   ├── utils/                     # date/distance/image/debouncer/extensions
│   └── widgets/                   # shared UI (buttons, inputs, dropdowns, cards, states…)
└── features/
    ├── auth/                      # login / register / otp / onboarding / splash
    │   ├── data/                  # auth_repository.dart (abstract+mock), remote_auth_repository.dart
    │   ├── domain/                # user.dart
    │   └── presentation/          # auth_cubit/state/events + screens/<name>/
    ├── home/                      # home + app_shell (bottom nav)
    ├── missing_children/          # explore/discover + filters
    ├── reports/                   # child_details, report_missing, report_found,
    │                              # report_confirmation + forms/ + cubits
    │   └── data/repositories/     # child_case_repository.dart (abstracts),
    │                              # mock_*, remote_*, inputs.dart, models.dart,
    │                              # case_json_mapper.dart, remote_payloads.dart
    ├── map/                       # flutter_map cases view
    ├── search/                    # search + recent searches (cached)
    ├── notifications/             # list + filter + mark-all-read
    ├── profile/                   # profile / settings / edit_profile / my_reports
    └── shared/domain/             # app_enums.dart (Gender, CaseStatus, …)

assets/
├── images/logo.jpg                # app + launcher icon source
├── translations/ar.json, en.json
└── fonts/Tajawal-*.ttf
```

### Screen-folder convention

```
features/<feature>/presentation/screens/<name>/
├── <name>_screen.dart      # ≤150 lines: providers + thin composition only
├── <name>_controller.dart  # form state, controllers, submit logic
├── sections/               # large screen sections (hero, form card…)
└── widgets/                # one public widget per file (≤150 lines each)
```

The router (`core/router/app_router.dart`) imports the real screen paths
directly (e.g. `screens/login/login_screen.dart`) — there are no
re-export shim files. **Rule: no hand-written `.dart` file exceeds 150 lines**
(except generated `app_router.gr.dart`).

---

## 2. Run the project

Prerequisites: Flutter **3.47+** (Dart 3.13+), Android SDK / Xcode for devices.

```bash
# 1. Install dependencies
flutter pub get

# 2. (Only after editing @RoutePage routes) regenerate navigation
dart run build_runner build --delete-conflicting-outputs

# 3. Run with MOCK data (default, works offline)
flutter run

# 4. Run against the REAL backend
flutter run --dart-define=USE_MOCK=false \
            --dart-define=API_BASE_URL=https://api.myserver.com/v1

# 5. Static analysis (must show 0 errors)
flutter analyze --no-pub
```

Useful flags: `--dart-define=USE_MOCK=false` flips every repository
(auth / cases / notifications) from in-memory mocks to the Dio REST
implementations — no UI changes needed.

### Regenerate launcher icons

Logo source: `assets/images/logo.jpg`, config: `flutter_launcher_icons.yaml`.

```bash
dart run flutter_launcher_icons
```

---

## 3. Extract APK / release builds

```bash
# Debug APK (quick test on device)
flutter build apk --debug

# Release APK, one file per ABI (smallest downloads) → build/app/outputs/flutter-apk/
flutter build apk --release --split-per-abi

# Single universal release APK
flutter build apk --release --target-platform android-arm64 --analyze-size

# Play Store bundle (preferred for publishing)
flutter build appbundle --release

# iOS (on macOS)
flutter build ipa --release
```

Version in `pubspec.yaml` (`version: 1.0.0+1` → name+build-number).
Signing: configure `android/app/build.gradle` + `key.properties` before a
store release.

---

## 4. Backend API contract (for backend developers)

- Base URL default: `https://api.reunitee.app/v1`
  (override at build time: `--dart-define=API_BASE_URL=...`).
- Headers: `Accept: application/json`, `Content-Type: application/json`,
  authenticated calls: `Authorization: Bearer <accessToken>`.
- Response envelope accepted flexibly: raw object **or** `{ "data": … }`
  (and `{ "data": { "user": … } }`, `{ "cases": […] }`, `{ "matches": […] }`).
- Client error mapping: `401 → Unauthorized`, `404 → NotFound`,
  `422/400 with { errors: {field: msg} } → Validation`,
  `{ message } → Server(message)`, timeouts → Timeout, no route → Network.

### 4.1 Auth

| Method | Path | Body | Returns |
|---|---|---|---|
| POST | `/auth/login` | `{ identifier, password }` | `{ token, refreshToken?, user }` |
| POST | `/auth/register` | `{ fullName, name, phone, password, city? }` ⚠️ **city only — never governorate** | `{ token?, user }` |
| POST | `/auth/verify-otp` | `{ code }` | `{}` |
| POST | `/auth/forgot-password` | `{ email }` | `{}` |
| POST | `/auth/reset-password` | `{ email, code, newPassword, password }` | `{}` |
| GET | `/auth/me` | — | `user` |
| POST | `/auth/logout` | — | `{}` |
| PATCH | `/auth/profile` | `{ fullName?, name?, phone?, photo? }` (photo may become multipart `photo` file) | `user` |

`user` shape:

```json
{
  "id": "user-1", "fullName": "الاسم", "name": "الاسم",
  "email": "a@b.com", "phone": "01012345678",
  "photo": "<url>", "city": "مدينة نصر",
  "hasVerified": true
}
```

Register location rule: the app shows **governorate → city** dropdowns whose
data comes from **`GET /locations/governorates`** (bundled offline list is
used in mock mode and as fallback when the API is unreachable).
Governorate only filters the city list on-device; the register request
sends **only `city`**.

### 4.2 Cases / reports

| Method | Path | Query / Body | Returns |
|---|---|---|---|
| GET | `/cases/missing` | `search, city, area, gender(male\|female), minAge, maxAge, activeOnly, foundOnly, sort(newest\|oldest)` | `[case]` / `{ data: [case] }` |
| GET | `/cases/found` | — | `[case]` |
| GET | `/cases/:id` | — | `case` |
| GET | `/cases/nearby` | `lat, lng, radius` (meters) | `[case]` |
| GET | `/cases/statistics` | — | `{ activeCases, childrenFound, reportsToday, reunifications }` |
| GET | `/cases/:id/matches` | — | `[{ case\|foundCase, matchPercent\|score, distanceMeters\|distance, timeGapHours }]` |
| POST | `/sightings` | `{ caseId, latitude, longitude, lat, lng, occurredAt(ISO), description, notes? }` | `{}` |
| POST | `/cases/missing` | `{ name, age, gender, missingSince(ISO), lastKnownLocation, city, area, clothing, description, distinguishingMarks?, phone?, email?, coordinates{lat,lng}? }` (photos → multipart later) | `case` |
| POST | `/cases/found` | `{ estimatedAge, age, gender, foundSince(ISO), foundLocation, city, area, clothing, description, extraInfo?, coordinates? }` | `case` |
| GET | `/me/reports` | — | `[case]` |
| GET | `/me/findings` | — | `[case]` |
| GET | `/me/sightings` | — | `[case]` |

`case` shape (client normalizes snake_case/camelCase, `lat/lng` or
`latitude/longitude`):

```json
{
  "id": "RC-1001", "type": "missing|found", "name": "…",
  "age": 7, "gender": "male|female",
  "status": "reported|underReview|published|possibleSighting|childFound|caseClosed",
  "urgency": "high|medium|low",
  "lastKnownLocation": "…", "city": "…", "area": "…",
  "missingSince": "ISO", "lastSeen": "ISO",
  "clothing": "…", "description": "…",
  "distinguishingMarks": "…", "photo": "<url>",
  "verified": false, "coordinates": { "lat": 30.04, "lng": 31.23 }
}
```

### 4.3 Notifications

| Method | Path | Returns |
|---|---|---|
| GET | `/notifications` | `[notification]` / `{ data: [...] }` / `{ notifications: [...] }` |
| POST | `/notifications/read-all` | `{}` |

### 4.4 Locations (governorates + cities)

| Method | Path | Returns |
|---|---|---|
| GET | `/locations/governorates` | `[governorate]` / `{ data: [...] }` / `{ governorates: [...] }` |

```json
[
  {
    "id": "cairo",
    "name": "القاهرة",
    "cities": [{ "id": "nasr-city", "name": "مدينة نصر" }, "مصر الجديدة"]
  }
]
```

Rules: `cities` items may be plain strings or `{ id, name }` objects;
`nameAr`/`arabicName` are accepted as name aliases. The client falls back
to its bundled offline list when the call fails, so this endpoint is
required for fresh data but never blocks registration.

```json
{
  "id": "n1", "type": "emergency|caseUpdate|possibleMatch|success",
  "title": "…", "body": "…",
  "createdAt": "ISO", "caseId": "RC-1001",
  "namedArgs": { "place": "…" }, "read": false
}
```

---

## 5. Required permissions

### Android (`android/app/src/main/AndroidManifest.xml`)

| Permission | Why |
|---|---|
| `INTERNET` | API calls (Dio) |
| `ACCESS_NETWORK_STATE` | offline/online detection (`connectivity_plus`) |
| `ACCESS_FINE_LOCATION` + `ACCESS_COARSE_LOCATION` | nearby cases, map, sighting location (`geolocator`) |
| `CAMERA` | report/profile photos (`image_picker`) |
| `READ_MEDIA_IMAGES` (API 33+) / `READ_EXTERNAL_STORAGE` (≤32) | pick photo from gallery |
| `POST_NOTIFICATIONS` (API 33+) | nearby alerts, case updates, matches |
| `VIBRATE` | notification vibration |
| `RECEIVE_BOOT_COMPLETED` | reschedule local notifications after reboot |

`android.hardware.camera` / `android.hardware.location` are declared with
`required="false"` (app works on devices without them).

### iOS (`ios/Runner/Info.plist`)

| Key | Purpose |
|---|---|
| `NSLocationWhenInUseUsageDescription` | nearby alerts + map while using the app |
| `NSLocationAlwaysAndWhenInUseUsageDescription` | background nearby alerts |
| `NSCameraUsageDescription` | attach report photo via camera |
| `NSPhotoLibraryUsageDescription` | pick existing photo for a report |
| `NSPhotoLibraryAddUsageDescription` | save report photos |
| `UIBackgroundModes: fetch, remote-notification` | background notification updates |

Runtime permission flows (location via `geolocator`, photos via
`image_picker`) are requested in-app when the feature is used; denied states
show the localized `errors.permission` message guiding the user to Settings.
