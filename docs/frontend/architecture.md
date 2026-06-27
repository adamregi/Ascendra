# Architecture

## Purpose
Defines how the frontend is organized.

## Tech Stack
- Flutter
- Riverpod
- GoRouter
- Freezed
- json_serializable
- flutter_secure_storage
- Supabase Flutter

## Architecture Flow
```text
UI
│
▼
Riverpod Provider
│
▼
Repository
│
▼
RPC / Edge Function
│
▼
Supabase
```

## Principles
* UI is presentation only.
* No business logic in widgets.
* No SQL in Flutter.
* Repositories own data access.
* Providers orchestrate state.
* Widgets receive typed models only.

## Folder Structure
```text
lib/
├── app/
├── core/
├── shared/
└── features/
    └── dashboard/
        ├── presentation/
        ├── application/
        ├── domain/
        └── data/
```

## Navigation
* GoRouter
* ShellRoute
* Auth Guards
* Role Guards

## Bootstrap Flow
```text
Splash
↓
Session
↓
Profile
↓
Permissions
↓
Company
↓
Dashboard Prefetch
↓
Dashboard
```
