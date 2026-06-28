# Dependencies — Ascendra

> This document explains **why** each dependency exists in Ascendra. Before adding, removing, or replacing any package, consult this guide.

---

## Core Dependencies

| Package | Version | Purpose | Replaceable? |
|---------|---------|---------|-------------|
| `flutter` | SDK ^3.7.2 | Cross-platform UI framework | **No** — fundamental |
| `cupertino_icons` | ^1.0.8 | iOS-style icons | Yes — but no benefit |

## Backend & Data

| Package | Version | Purpose | Replaceable? |
|---------|---------|---------|-------------|
| `supabase_flutter` | ^2.8.4 | Auth, database, RPC, storage, realtime | **No** — core backend |
| `dio` | ^5.8.0+1 | HTTP client for NestJS API calls | Partially — could use `http` but Dio provides interceptors |
| `flutter_secure_storage` | ^9.2.4 | Encrypted token storage for Supabase auth | **No** — security requirement |

## State Management

| Package | Version | Purpose | Replaceable? |
|---------|---------|---------|-------------|
| `flutter_riverpod` | ^2.6.1 | Reactive state management | **No** — architectural decision |
| `riverpod_annotation` | ^2.6.1 | Code-generated providers (`@riverpod`) | **No** — paired with flutter_riverpod |

## Navigation

| Package | Version | Purpose | Replaceable? |
|---------|---------|---------|-------------|
| `go_router` | ^15.1.2 | Declarative routing with deep linking | **No** — handles auth redirect, shell routes |

## Data Models

| Package | Version | Purpose | Replaceable? |
|---------|---------|---------|-------------|
| `freezed_annotation` | ^3.0.0 | Immutable model annotations | **No** — architectural decision |
| `json_annotation` | ^4.9.0 | JSON serialization annotations | **No** — paired with freezed |

## Video Conferencing

| Package | Version | Purpose | Replaceable? |
|---------|---------|---------|-------------|
| `hmssdk_flutter` | ^1.11.1 | 100ms video conferencing SDK | **No** — backend integrated with 100ms |
| `video_player` | ^2.10.1 | Meeting replay video playback | Partially — could use `chewie` wrapper |

## Notifications

| Package | Version | Purpose | Replaceable? |
|---------|---------|---------|-------------|
| `flutter_local_notifications` | ^18.0.1 | Local push notification display | **No** — required for foreground notifications |
| `permission_handler` | ^11.4.0 | Runtime permission requests | **No** — Android requires runtime permissions |

## File Handling

| Package | Version | Purpose | Replaceable? |
|---------|---------|---------|-------------|
| `image_picker` | ^1.1.2 | Camera/gallery access for proof submission | **No** — task proof workflow |
| `file_picker` | ^10.1.9 | Document picker for PDF/file proof | **No** — task proof workflow |

## UI & Display

| Package | Version | Purpose | Replaceable? |
|---------|---------|---------|-------------|
| `cached_network_image` | ^3.4.1 | Network image caching with placeholders | **No** — performance requirement |
| `lucide_icons` | ^0.257.0 | Icon library (consistent, modern) | Yes — but would require icon migration |
| `fl_chart` | ^0.69.0 | Charts for analytics dashboards | Partially — `syncfusion` is more feature-rich but heavy |

## Utilities

| Package | Version | Purpose | Replaceable? |
|---------|---------|---------|-------------|
| `intl` | ^0.20.2 | Date/number formatting and localization | **No** — standard for i18n |
| `uuid` | ^4.5.1 | Client-side UUID generation | **No** — needed for optimistic inserts |
| `connectivity_plus` | ^6.1.4 | Network connectivity detection | **No** — offline handling |

---

## Dev Dependencies

| Package | Version | Purpose | Replaceable? |
|---------|---------|---------|-------------|
| `build_runner` | ^2.5.4 | Code generation orchestrator | **No** — required for freezed/riverpod |
| `riverpod_generator` | ^2.6.5 | Generates provider code from annotations | **No** — paired with riverpod_annotation |
| `freezed` | ^3.0.0 | Generates immutable model code | **No** — paired with freezed_annotation |
| `json_serializable` | ^6.9.4 | Generates JSON parsing code | **No** — paired with json_annotation |
| `custom_lint` | ^0.7.5 | Custom lint rule engine | Optional — but improves quality |
| `riverpod_lint` | ^2.6.5 | Riverpod-specific lint rules | Recommended — catches common mistakes |
| `mockito` | ^5.4.6 | Mock generation for tests | **No** — standard test mocking |
| `flutter_launcher_icons` | ^0.14.4 | Generates app icons from source image | Optional — one-time use |
| `flutter_native_splash` | ^2.4.6 | Generates native splash screens | Optional — one-time use |

---

## Adding New Dependencies

Before adding a package:

1. **Check if the functionality already exists** in current dependencies
2. **Verify the package** has active maintenance (last publish < 6 months)
3. **Check compatibility** with current Flutter SDK (^3.7.2)
4. **Prefer packages** with null safety and Flutter 3.x support
5. **Document the reason** in this file
6. **Run `flutter pub get`** and verify no conflicts

## Removing Dependencies

Before removing a package:

1. **Search for all imports** across the codebase
2. **Verify no transitive dependency** relies on it
3. **Update this document** to remove the entry
4. **Run `flutter analyze`** to catch missing imports

---

*See also: [BUILD_GUIDE.md](BUILD_GUIDE.md), [UPGRADE_GUIDE.md](UPGRADE_GUIDE.md)*
