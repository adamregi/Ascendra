# AI Memory — Ascendra

> **Purpose**: Permanent project assumptions and conventions that AI agents must remember across sessions.
> **Last Updated**: 2026-06-28

---

## Project Identity

- **Product Name**: Ascendra
- **Package Name**: `distributor_os`
- **App Entry**: `lib/main.dart`
- **Design Language**: Serene Modernist
- **Primary Font**: Inter (system), Newsreader (display), Hanken Grotesk (body/labels)
- **Primary Color**: `#181e1a` (deep forest)
- **Accent Color**: `#D4AF37` (warm gold)

## Architecture Decisions

- **State Management**: Riverpod with code generation (`@riverpod`)
- **Data Models**: Freezed + json_serializable (always immutable)
- **Navigation**: GoRouter with ShellRoute for bottom nav
- **Backend**: Supabase (primary), NestJS on Railway (heavy workflows)
- **Event Bus**: Upstash Redis with BullMQ
- **Video**: 100ms SDK
- **AI**: Google Gemini with pgvector RAG
- **Network Tree**: PostgreSQL ltree extension

## Caching Convention

- All data providers use `ref.cacheFor(const Duration(minutes: 5))` — 5-minute standard TTL
- The `cacheFor` extension is defined in `lib/core/extensions/ref_extensions.dart`

## UI Sections Naming

- Use UI-focused section names (HeroSection, OverviewSection) rather than raw backend terminology (kpis)
- This convention facilitates future AI features that need user-facing labels

## Backend Aggregation Rule

- ALL analytics, KPIs, compliance scores, and trend data are computed by RPCs or materialized views
- Flutter NEVER computes aggregates from raw data
- Data flow: Flutter → Repository → RPC → ViewModel → Widget

## Member Profile Layout

- Uses Tabbed View: fixed sticky hero + changing tab content
- Tabs: Overview, Timeline, Compliance, Recognition, Analytics

## Migration Numbering

- Current latest migration: `060_m5_member_directory_rpc.sql`
- Next migration should be: `061_*.sql`
- Migrations are immutable once applied — never edit existing files

## RPC Versioning

- RPCs that return aggregated view models include `version` and `generated_at` fields
- Example: `get_member_profile_view_model` returns `{ "version": 1, "generated_at": "...", "hero": {...}, ... }`

## Existing Milestones Completed

| Milestone | Feature | Status |
|-----------|---------|--------|
| M1 | Authentication & Onboarding | ✅ Complete |
| M2 | Dashboard | ✅ Complete |
| M3 | Meetings (Schedule, Live, Replay) | ✅ Complete |
| M4 | Tasks (Create, Assign, Proof, Review) | ✅ Complete |
| M5 | Members (Profile, Directory) — Models/Repos/Providers | ✅ In Progress |

## Key File Locations

| Purpose | Path |
|---------|------|
| Supabase config | `lib/core/config/supabase_config.dart` |
| Secure storage | `lib/core/config/secure_local_storage.dart` |
| Base repository | `lib/core/repositories/base_repository.dart` |
| Cache extension | `lib/core/extensions/ref_extensions.dart` |
| App theme | `lib/core/theme/app_theme.dart` |
| Color tokens | `lib/core/constants/app_colors.dart` |
| Typography tokens | `lib/core/constants/app_typography.dart` |
| Spacing tokens | `lib/core/constants/app_spacing.dart` |
| Radius tokens | `lib/core/constants/app_radius.dart` |
| Router | `lib/app/Router/app_router.dart` |
| Bootstrap | `lib/app/bootstrap/bootstrap_provider.dart` |
| App shell (bottom nav) | `lib/shared/widgets/app_shell.dart` |

## Routes

| Route | Page | Shell? |
|-------|------|--------|
| `/splash` | SplashPage | No |
| `/login` | LoginPage | No |
| `/dashboard` | DashboardPage | Yes |
| `/meetings` | MeetingsPage | Yes |
| `/tasks` | TasksPage | Yes |
| `/alerts` | AlertsPage | Yes |
| `/ai` | AiPage | Yes |
| `/settings` | SettingsPage | Yes |
| `/meetings/schedule` | ScheduleMeetingPage | No |
| `/meetings/:id` | MeetingDetailPage | No |
| `/meetings/live/:id` | LiveMeetingPage | No |
| `/meetings/replay/:id` | MeetingReplayPage | No |
| `/tasks/create` | CreateTaskPage | No |
| `/tasks/:id` | TaskDetailPage | No |
| `/tasks/:id/followups` | TaskFollowupsPage | No |
| `/dev/components` | ComponentGalleryPage | No |

---

*This file is automatically consulted by AI agents to maintain context across sessions.*
