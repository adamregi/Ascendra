# Ascendra — AI Operating Manual

> **Version**: 1.0.0
> **Last Updated**: 2026-06-28
> **Audience**: AI Coding Agents (Claude Code, Codex, Cursor, Cline, Roo Code, Gemini CLI, GitHub Copilot, Windsurf)
> **Scope**: Complete project knowledge, architecture, standards, and workflows

This document is the **permanent operating manual** for every AI agent working on Ascendra. It is the single source of truth. Every implementation, review, and decision must comply with this manual.

---

## Table of Contents

1. [Project Identity](#part-i--project-identity)
2. [Technology Stack](#part-ii--technology-stack)
3. [Architecture](#part-iii--architecture)
4. [Feature Modules](#part-iv--feature-modules)
5. [Folder Structure](#part-v--folder-structure)
6. [Permanent Development Rules](#part-vi--permanent-development-rules)
7. [Skills System](#part-vii--skills-system)
8. [Plugin & MCP Policy](#part-viii--plugin--mcp-policy)
9. [UI Development Workflow](#part-ix--ui-development-workflow)
10. [Backend Integration Rules](#part-x--backend-integration-rules)
11. [Flutter Coding Standards](#part-xi--flutter-coding-standards)
12. [State Management](#part-xii--state-management)
13. [Design System](#part-xiii--design-system)
14. [Responsive Design](#part-xiv--responsive-design)
15. [Performance Rules](#part-xv--performance-rules)
16. [Accessibility Rules](#part-xvi--accessibility-rules)
17. [Security Rules](#part-xvii--security-rules)
18. [Testing Requirements](#part-xviii--testing-requirements)
19. [Build & Run Commands](#part-xix--build--run-commands)
20. [Release Process](#part-xx--release-process)
21. [Git Workflow & Code Review](#part-xxi--git-workflow--code-review)
22. [Documentation Standards](#part-xxii--documentation-standards)
23. [Code Simplification Rules](#part-xxiii--code-simplification-rules)
24. [AI Self-Review Checklist](#part-xxiv--ai-self-review-checklist)
25. [Definition of Done](#part-xxv--definition-of-done)

---

# Part I — Project Identity

## Vision

Ascendra is a **leader-centric MLM leadership SaaS platform** that empowers network marketing leaders to manage their teams, conduct meetings, assign tasks, track compliance, and leverage AI coaching — all from a single application.

## Business Goals

1. Replace scattered spreadsheets and WhatsApp groups with a unified command center.
2. Provide real-time compliance monitoring and automated warnings.
3. Enable video meetings with attendance tracking and AI-generated summaries.
4. Deliver an AI leadership coach powered by company-specific knowledge.
5. Scale to 100,000+ users across thousands of tenant companies.

## Product Philosophy

- **Leader-first**: Leaders purchase subscriptions and manage members. Members do not self-register.
- **Backend-driven intelligence**: All analytics, compliance scores, and recommendations are computed on the backend. Flutter is a presentation layer.
- **Compliance as a feature**: Attendance, task completion, and engagement metrics are tracked automatically and surfaced proactively.
- **AI-augmented leadership**: The AI assistant uses company-specific documents (RAG) to provide contextual coaching.

## Non-Goals

- Ascendra is NOT a social media platform.
- Ascendra does NOT replace CRM systems (Salesforce, HubSpot).
- Ascendra does NOT handle financial transactions or commissions.
- Ascendra does NOT support self-registration. All onboarding is invitation-based.

## Supported Platforms

| Platform | Status | Notes |
|----------|--------|-------|
| Android | Primary | Target SDK 34+ |
| iOS | Planned | Same Flutter codebase |
| Web | Planned | Responsive dashboard |

## User Roles

| Role | Capabilities |
|------|-------------|
| **Leader** | Full platform access. Manages members, meetings, tasks, compliance, AI, settings. Purchases subscriptions. |
| **Member** | Limited access. Attends meetings, completes tasks, views own compliance, chats with AI. Cannot invite others. |

## Subscription Model

| Plan | Member Limit | Features |
|------|-------------|----------|
| Starter | 50 | Core features |
| Pro | 100 | Core + analytics |
| Enterprise | 200 | Full platform |

---

# Part II — Technology Stack

## Frontend

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter` | SDK ^3.7.2 | Cross-platform UI framework |
| `flutter_riverpod` | ^2.6.1 | State management |
| `riverpod_annotation` | ^2.6.1 | Code-generated providers |
| `go_router` | ^15.1.2 | Declarative routing |
| `freezed_annotation` | ^3.0.0 | Immutable data models |
| `json_annotation` | ^4.9.0 | JSON serialization |
| `dio` | ^5.8.0+1 | HTTP client for NestJS backend |
| `flutter_secure_storage` | ^9.2.4 | Encrypted token storage |
| `flutter_local_notifications` | ^18.0.1 | Local push notifications |
| `permission_handler` | ^11.4.0 | Runtime permissions |
| `image_picker` | ^1.1.2 | Camera and gallery access |
| `file_picker` | ^10.1.9 | Document uploads |
| `cached_network_image` | ^3.4.1 | Image caching |
| `intl` | ^0.20.2 | Date/number formatting |
| `uuid` | ^4.5.1 | UUID generation |
| `connectivity_plus` | ^6.1.4 | Network detection |
| `hmssdk_flutter` | ^1.11.1 | 100ms video conferencing |
| `video_player` | ^2.10.1 | Meeting replay playback |
| `lucide_icons` | ^0.257.0 | Icon library |
| `fl_chart` | ^0.69.0 | Charts and graphs |

## Dev Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `build_runner` | ^2.5.4 | Code generation orchestrator |
| `riverpod_generator` | ^2.6.5 | Provider code generation |
| `freezed` | ^3.0.0 | Immutable model generation |
| `json_serializable` | ^6.9.4 | JSON parsing generation |
| `riverpod_lint` | ^2.6.5 | Riverpod-specific lint rules |
| `custom_lint` | ^0.7.5 | Custom lint engine |
| `mockito` | ^5.4.6 | Test mocking |
| `flutter_launcher_icons` | ^0.14.4 | App icon generation |
| `flutter_native_splash` | ^2.4.6 | Splash screen generation |

## Backend

| Service | Purpose |
|---------|---------|
| **Supabase** | Auth, PostgreSQL, REST (PostgREST), Realtime (WebSockets), Storage, Edge Functions |
| **NestJS** (Railway) | Heavy workflows, AI orchestration, compliance evaluation, notification routing |
| **Upstash Redis** | BullMQ event bus for async domain events |
| **100ms** | Video conferencing rooms and webhook events |
| **Google Gemini** | AI assistant (RAG with pgvector) |
| **Twilio** | SMS/WhatsApp notifications |
| **SendGrid** | Email notifications |
| **FCM** | Push notifications |

## Database Extensions

| Extension | Purpose |
|-----------|---------|
| `uuid-ossp` | UUID generation |
| `pgcrypto` | Cryptographic functions |
| `ltree` | Hierarchical path storage for MLM network trees |
| `pgvector` | 768-dimensional vector storage for RAG search |
| `pg_trgm` | Trigram fuzzy text matching |

---

# Part III — Architecture

## System Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    Client Layer (Flutter App)                    │
│                                                                 │
│   Riverpod Providers → Repositories → Supabase/Dio Client      │
└─────────┬──────────────┬──────────────┬──────────────┬─────────┘
          │              │              │              │
          ▼              ▼              ▼              ▼
┌─────────────┐ ┌──────────────┐ ┌──────────┐ ┌─────────────┐
│ Supabase    │ │ Supabase     │ │ Supabase │ │ Edge        │
│ Auth        │ │ REST/RPC     │ │ Storage  │ │ Functions   │
│ (GoTrue)    │ │ (PostgREST)  │ │ API      │ │ (Deno/TS)   │
└─────────────┘ └──────┬───────┘ └──────────┘ └──────┬──────┘
                       │                              │
                       ▼                              ▼
              ┌────────────────┐            ┌─────────────────┐
              │  PostgreSQL    │            │ Upstash Redis   │
              │  + RLS         │            │ (BullMQ Events) │
              │  + ltree       │            └────────┬────────┘
              │  + pgvector    │                     │
              │  + Triggers    │                     ▼
              │  + Mat. Views  │            ┌─────────────────┐
              └────────────────┘            │ NestJS Workers  │
                                            │ (Railway)       │
                                            │ - AI/Gemini     │
                                            │ - Compliance    │
                                            │ - Notifications │
                                            └─────────────────┘
```

## Clean Architecture Layers (Flutter)

```
┌──────────────────────────────────┐
│        Presentation Layer        │
│  Pages → Widgets → Providers     │
│  (UI only — no business logic)   │
├──────────────────────────────────┤
│          Domain Layer            │
│  Entities → Repositories (abs)   │
│  Use Cases (optional)            │
├──────────────────────────────────┤
│           Data Layer             │
│  Models (Freezed/JSON) →         │
│  Repository Implementations →    │
│  Supabase/Dio Clients            │
└──────────────────────────────────┘
```

### Dependency Rule

Dependencies flow **inward only**:

```
Presentation → Domain ← Data
```

- Presentation depends on Domain (entities, abstract repositories).
- Data depends on Domain (implements abstract repositories).
- Domain depends on **nothing** outside itself.
- Widgets **NEVER** import from `data/` directly.
- Widgets **NEVER** call Supabase, Dio, or any external service.

## Data Flow

```
User Action
    ↓
Widget calls Provider method
    ↓
Provider calls Repository
    ↓
Repository calls Supabase RPC / REST / Dio
    ↓
Response parsed into Freezed Model
    ↓
Provider updates state (AsyncValue)
    ↓
Widget rebuilds with new data
```

## Event-Driven Architecture

```
User Action → Edge Function → PostgreSQL (write)
                            → Redis Event Bus (publish)
                                    ↓
                            NestJS Worker (consume)
                                    ↓
                            AI / Notifications / Mat. View Refresh
```

### Core Domain Events

| Event | Trigger | Side Effects |
|-------|---------|-------------|
| `MemberInvited` | Leader invites member | SMS/OTP dispatch |
| `MeetingEnded` | Meeting status → ended | RAG summary, attendance audit, mat. view refresh |
| `TaskCompleted` | Proof submitted & approved | Leaderboard update, leader notification |
| `MemberTerminated` | Leader terminates member | Downline restructuring, path recalculation |

---

# Part IV — Feature Modules

Ascendra contains **16 feature modules**, each following Clean Architecture:

| Module | Path | Purpose |
|--------|------|---------|
| `auth` | `lib/features/auth/` | Login, splash, bootstrap, session management |
| `dashboard` | `lib/features/dashboard/` | Executive overview, KPIs, recommendations, pipeline |
| `meetings` | `lib/features/meetings/` | Schedule, live video (100ms), replay, attendance |
| `tasks` | `lib/features/tasks/` | Create, assign, proof submission, review, followups |
| `members` | `lib/features/members/` | Profile, directory, compliance, timeline, recognition |
| `compliance` | `lib/features/compliance/` | Rules, snapshots, violations, scoring |
| `ai` | `lib/features/ai/` | AI chat interface |
| `ai_assistant` | `lib/features/ai_assistant/` | AI coaching backend integration |
| `alerts` | `lib/features/alerts/` | Alert rules, deliveries, preferences |
| `settings` | `lib/features/settings/` | Company and user settings |
| `subscriptions` | `lib/features/subscriptions/` | Plan management, usage tracking |
| `knowledge` | `lib/features/knowledge/` | Document ingestion, vector search |
| `followups` | `lib/features/followups/` | Automated reminder system |
| `invitations` | `lib/features/invitations/` | Member invitation flow |
| `profile` | `lib/features/profile/` | User profile, company context |
| `dev` | `lib/features/dev/` | Component gallery (development only) |

### Feature Internal Structure

Every feature follows this structure:

```
features/<name>/
├── data/
│   ├── models/          # Freezed + json_serializable DTOs
│   └── repositories/    # Repository implementations
├── domain/
│   ├── entities/        # Domain entities (Freezed)
│   ├── repositories/    # Abstract repository interfaces
│   └── usecases/        # Use cases (optional)
└── presentation/
    ├── pages/           # Full-screen page widgets
    ├── providers/       # Riverpod providers + generated .g.dart
    └── widgets/         # Reusable UI components
```

---

# Part V — Folder Structure

```
distributor_os/                    # Project root
├── AGENTS.md                      # THIS FILE — AI operating manual
├── pubspec.yaml                   # Flutter dependencies
├── analysis_options.yaml          # Lint configuration
│
├── lib/                           # Dart source code
│   ├── main.dart                  # App entry point
│   ├── app/                       # App-level configuration
│   │   ├── Router/                # GoRouter configuration
│   │   ├── bootstrap/             # Auth state bootstrapping
│   │   └── providers/             # App-level providers
│   ├── core/                      # Cross-cutting concerns
│   │   ├── config/                # Supabase config, secure storage
│   │   ├── constants/             # Colors, typography, spacing, radius, strings
│   │   ├── errors/                # Error types
│   │   ├── extensions/            # Dart extensions (ref.cacheFor)
│   │   ├── failures/              # Failure types
│   │   ├── network/               # Network utilities
│   │   ├── repositories/          # BaseRepository
│   │   ├── responsive/            # Breakpoints, grid, builder, padding
│   │   ├── services/              # Core services
│   │   ├── theme/                 # AppTheme (light + dark)
│   │   ├── utils/                 # Utility functions
│   │   └── widgets/               # Core reusable widgets
│   ├── features/                  # Feature modules (16 modules)
│   │   ├── auth/
│   │   ├── dashboard/
│   │   ├── meetings/
│   │   ├── tasks/
│   │   ├── members/
│   │   ├── compliance/
│   │   ├── ai/
│   │   ├── ai_assistant/
│   │   ├── alerts/
│   │   ├── settings/
│   │   ├── subscriptions/
│   │   ├── knowledge/
│   │   ├── followups/
│   │   ├── invitations/
│   │   ├── profile/
│   │   └── dev/
│   └── shared/                    # Shared across features
│       ├── extensions/            # Shared Dart extensions
│       ├── models/                # Shared data models
│       └── widgets/               # Shared UI components (16 widgets)
│
├── assets/
│   ├── branding/                  # Logo, splash assets
│   └── reference/                 # Reference UI designs (42 screens)
│       └── <screen_name>/
│           ├── screen.png         # Visual reference
│           └── code.html          # HTML/CSS reference implementation
│
├── supabase/
│   ├── config.toml                # Local Supabase configuration
│   ├── seed.sql                   # Seed data
│   ├── functions/                 # Edge Functions (Deno/TypeScript)
│   │   ├── _shared/               # Shared modules
│   │   ├── create-company/
│   │   ├── invite-member/
│   │   ├── accept-invitation/
│   │   ├── ai-chat/
│   │   ├── schedule-meeting/
│   │   └── restructure-tree/
│   └── migrations/                # SQL migrations (001–060)
│
├── docs/                          # Documentation suite
│   ├── backend/                   # Existing backend documentation
│   │   ├── architecture_diagram.md
│   │   ├── site_mapping.md
│   │   ├── detailed_backend_notes.md
│   │   ├── business_logic_ownership.md
│   │   ├── journey_mapping.md
│   │   ├── ER_diagram.md
│   │   ├── edge_vs_nestjs_contract.md
│   │   ├── userflow.md
│   │   └── adrs/                  # Architecture Decision Records
│   └── (reference guides)        # Generated documentation
│
├── .ai-core/                           # AI-specific indexes and rules
│
├── Skills/                        # Skills library (24,000+ skills)
│   ├── skills/                    # Individual skill directories
│   └── plugins/                   # Plugin directories
│
├── test/                          # Unit and widget tests
├── integration_test/              # Integration tests
├── android/                       # Android platform code
├── ios/                           # iOS platform code
├── web/                           # Web platform code
├── windows/                       # Windows platform code
├── linux/                         # Linux platform code
└── macos/                         # macOS platform code
```

### Dependency Rules

| Directory | May Import From | Must NOT Import From |
|-----------|----------------|---------------------|
| `core/` | Dart/Flutter SDK, external packages | `features/`, `shared/` |
| `shared/` | `core/`, Dart/Flutter SDK | `features/` |
| `features/<X>/presentation/` | `features/<X>/domain/`, `core/`, `shared/` | `features/<X>/data/`, `features/<Y>/` |
| `features/<X>/domain/` | `core/` | `features/<X>/data/`, `features/<X>/presentation/`, `features/<Y>/` |
| `features/<X>/data/` | `features/<X>/domain/`, `core/`, external packages | `features/<X>/presentation/`, `features/<Y>/` |

---

# Part VI — Permanent Development Rules

These rules are **non-negotiable**. Every implementation must comply.

### Rule 1: Reference-First UI

Before building any screen, **always** inspect:

```
assets/reference/<screen>/screen.png    — Visual design reference
assets/reference/<screen>/code.html     — HTML/CSS reference implementation
```

Do NOT invent layouts unless the user explicitly requests it. If reference assets exist, use them.

### Rule 2: Responsive by Default

Every screen must work from **360px phones through desktop widths** without overflow. Use the responsive utilities in `core/responsive/`.

### Rule 3: Component-First

Build **reusable widgets** before composing pages. Check `shared/widgets/` for existing components before creating new ones.

### Rule 4: Presentation-Only Widgets

Widgets receive **typed view models** (Freezed models) and **never** fetch data directly. No Supabase calls, no Dio calls, no repository calls inside widgets.

```dart
// ✅ CORRECT
class MemberHero extends StatelessWidget {
  final MemberHeroModel heroData;  // Typed, immutable view model
  const MemberHero({super.key, required this.heroData});
}

// ❌ WRONG
class MemberHero extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(supabaseProvider).rpc('get_member');  // NEVER do this
  }
}
```

### Rule 5: Backend-Driven Aggregation

Analytics, timelines, compliance summaries, and KPIs come from **RPCs or materialized views**, NOT client-side calculations.

```
✅ Flutter → Repository → RPC / Materialized View → ViewModel → Widget
❌ Meetings + Tasks + Follow-ups + Profiles → Flutter merges everything
```

### Rule 6: Skills Folder Compliance

Before implementing a feature, review the corresponding implementation guidance in the `Skills/` folder. See [Part VII](#part-vii--skills-system) for the discovery workflow.

---

# Part VII — Skills System

## Overview

The `Skills/` directory contains **24,000+ specialized skill documents**. These are NOT hardcoded into this manual. Instead, the AI must **dynamically discover and apply** relevant skills for every task.

## Discovery Workflow

For every task, follow this workflow:

```
1. Receive task from user
         ↓
2. Identify task categories (e.g., Flutter, RPC, UI, Testing)
         ↓
3. Search Skills/ folder for matching skills
         ↓
4. Load and read relevant SKILL.md files
         ↓
5. If multiple skills apply, combine them consistently
         ↓
6. Implement following both project architecture AND skill guidance
         ↓
7. Validate that implementation complies with both
```

## Search Strategy

When searching for skills, use these category mappings:

| Task Type | Search Terms |
|-----------|-------------|
| Login / Auth | `authentication`, `supabase`, `riverpod`, `security`, `session` |
| Dashboard | `rpc`, `repository`, `responsive`, `charts`, `analytics` |
| Member Profile | `flutter`, `viewmodel`, `ui`, `responsive`, `design-system` |
| Meetings | `video`, `100ms`, `providers`, `attendance`, `compliance` |
| Task System | `task`, `assignment`, `proof`, `workflow`, `state` |
| Database | `postgresql`, `supabase`, `rpc`, `rls`, `migration` |
| AI Features | `pgvector`, `edge-functions`, `gemini`, `rag`, `embeddings` |
| Forms | `validation`, `components`, `input`, `form` |
| Navigation | `go-router`, `routing`, `navigation`, `deep-link` |
| Models | `freezed`, `json-serializable`, `immutable`, `dto` |
| Testing | `widget-test`, `riverpod-test`, `golden-test`, `integration` |
| Performance | `caching`, `rendering`, `riverpod`, `profiling`, `lazy` |
| Release | `android-build`, `signing`, `apk`, `aab`, `deployment` |
| Documentation | `adr`, `readme`, `api-docs`, `changelog` |
| Code Review | `review`, `checklist`, `quality`, `standards` |

## Conflict Resolution

When skill guidance conflicts with project architecture:

1. **Project architecture wins** (this document and `AGENTS.md` rules).
2. If the skill provides a better approach that doesn't violate architecture, prefer the skill.
3. If unsure, ask the user.

## Automatic Application

The AI must apply skills **without being asked**. The user should never need to say "check the Skills folder." This is automatic for every task.

See also: [.ai-core/SKILL_INDEX.md](.ai-core/SKILL_INDEX.md), [.ai-core/FEATURE_TO_SKILL_MAP.md](.ai-core/FEATURE_TO_SKILL_MAP.md)

---

# Part VIII — Plugin & MCP Policy

## Available Plugins

### Supabase MCP

| Aspect | Details |
|--------|---------|
| **Purpose** | Database queries, RPC execution, migration management, edge functions |
| **When to use** | Any database operation, schema inspection, migration creation |
| **When NOT to use** | Flutter UI work, frontend-only changes |
| **Priority** | HIGH — prefer over manual SQL when available |
| **Tools** | `execute_sql`, `list_tables`, `apply_migration`, `list_migrations`, `deploy_edge_function`, etc. |

### Firebase Plugin

| Aspect | Details |
|--------|---------|
| **Purpose** | Push notifications, analytics, crashlytics |
| **When to use** | Notification setup, crash reporting, analytics events |
| **When NOT to use** | Auth (use Supabase Auth), database (use Supabase) |
| **Priority** | MEDIUM |

### Flutter Plugin

| Aspect | Details |
|--------|---------|
| **Purpose** | Build, analyze, test, run, format |
| **When to use** | All Flutter CLI operations |
| **Priority** | HIGH |

### GitKraken

| Aspect | Details |
|--------|---------|
| **Purpose** | Git operations, branch management |
| **When to use** | Commit, push, branch operations |
| **Priority** | LOW — use CLI git commands preferably |

### Chrome DevTools Plugin

| Aspect | Details |
|--------|---------|
| **Purpose** | Browser debugging, web app inspection |
| **When to use** | Debugging web builds |
| **Priority** | LOW — only for web-specific issues |

## Automatic Plugin Selection

The AI must automatically determine when a plugin provides a better solution. The user should not need to explicitly request plugin usage.

**Decision flow:**

```
Is the task database-related?    → Use Supabase MCP
Is the task build-related?       → Use Flutter CLI
Is the task notification-related? → Use Firebase
Is the task git-related?         → Use CLI git (prefer over GitKraken)
```

---

# Part IX — UI Development Workflow

## Mandatory Process

Before building ANY screen, follow this exact sequence:

```
Step 1: Check Reference Assets
         ↓
    assets/reference/<screen>/screen.png  — Does it exist?
    assets/reference/<screen>/code.html   — Does it exist?
         ↓
Step 2: Review Relevant Skills
         ↓
    Search Skills/ for UI, responsive, component, and design-system skills
         ↓
Step 3: Check Existing Components
         ↓
    Review shared/widgets/ for reusable components
    Review core/widgets/ for core components
    Review the feature's own widgets/ directory
         ↓
Step 4: Apply Design System
         ↓
    Use AppColors, AppTypography, AppSpacing, AppRadius
    Follow Serene Modernist design language
         ↓
Step 5: Build Components First
         ↓
    Create reusable widgets that accept typed view models
    Place in the feature's widgets/ directory
         ↓
Step 6: Compose Page
         ↓
    Assemble page from reusable components
    Ensure responsive layout
    Place in the feature's pages/ directory
         ↓
Step 7: Wire Providers
         ↓
    Connect page to Riverpod providers
    Handle loading, error, and data states
```

## Available Reference Screens (42)

The `assets/reference/` directory contains design references for these screens:

- Login, Onboarding (3 screens), Password Reset (2 screens)
- Leader Home, Company Operating System, Leadership Control Center
- Meetings: Command Center, Schedule, Detail, Live Room, Replay, Ended Summary
- Tasks: Command Center, Campaign Builder, Intelligence Center
- Members: Profile Command Center, Team Leadership
- Compliance: Command Center, Rules Configuration, Warning
- AI: Executive Coach, Knowledge Ingestion, Learning Center
- Network: Genealogy, Tree Visualizer, Change Audit
- Analytics: Overview Command Center, Leadership Intelligence
- Invitation: Invite Member (2 screens), Join Team, QR Scanner
- Termination: Impact Analysis, Reassignment, Review/Execute, Success
- Branding: Team Identity

## Existing Shared Widgets

Before creating new widgets, check these existing components in `shared/widgets/`:

| Widget | File | Purpose |
|--------|------|---------|
| `AppAvatar` | `app_avatar.dart` | User avatars with initials fallback |
| `AppButton` | `app_button.dart` | Styled buttons (primary, secondary, outline) |
| `AppCard` | `app_card.dart` | Consistent card styling |
| `AppShell` | `app_shell.dart` | Bottom navigation shell |
| `AppTextField` | `app_text_field.dart` | Form input fields |
| `AssigneeAvatarGroup` | `assignee_avatar_group.dart` | Overlapping avatar stack |
| `AttachmentChip` | `attachment_chip.dart` | File/link attachment display |
| `Badges` | `badges.dart` | Status and priority badges |
| `BasePage` | `base_page.dart` | Base page scaffold |
| `Dialogs` | `dialogs.dart` | Confirmation and action dialogs |
| `ErrorWidgets` | `error_widgets.dart` | Error state displays |
| `LoadingWidgets` | `loading_widgets.dart` | Loading state displays |
| `ResponsiveMetricsGrid` | `responsive_metrics_grid.dart` | Responsive KPI grid |
| `SectionHeader` | `section_header.dart` | Section title with optional action |
| `Tiles` | `tiles.dart` | List tile variants |
| `TimelineItem` | `timeline_item.dart` | Timeline indicator + content |

---

# Part X — Backend Integration Rules

## RPC Conventions

### Naming

```sql
-- Pattern: verb_noun[_qualifier]
get_member_profile_view_model    -- Read operation
create_task_atomic               -- Write with transaction
evaluate_compliance              -- Compute operation
```

### Parameters

- Always prefix with `p_`: `p_profile_id`, `p_company_id`
- Use `UUID` for IDs
- Use `TIMESTAMPTZ` for dates
- Use `TEXT` for strings (with CHECK constraints)

### Return Types

- Single object → `JSON` (parsed into Freezed model)
- List → `SETOF JSON` or `JSON[]`
- Void operations → `VOID`

### Security

- Use `SECURITY INVOKER` by default (respects RLS)
- Use `SECURITY DEFINER` only for auth helpers that need elevated access
- Always set `search_path = public`

## RLS (Row-Level Security)

Every table has RLS enabled. Policies use `get_user_company_id()` for tenant isolation:

```sql
create policy "Company isolation"
  on public.<table>
  for select
  using (company_id = public.get_user_company_id());
```

## Materialized Views

| View | Purpose | Refresh Strategy |
|------|---------|-----------------|
| `mv_company_dashboard_stats` | Dashboard KPIs | Event-driven (MeetingEnded, TaskCompleted) |
| `mv_member_progress` | Member progress tracking | Event-driven |
| `mv_leadership_pipeline` | Leadership score tracking | Event-driven |
| `mv_growth_analytics` | Period-over-period metrics | Scheduled (every 30 min) |
| `mv_recommendation_center` | AI recommendations | Scheduled |

Materialized views are refreshed by NestJS workers, NOT by SQL triggers.

## Business Logic Boundaries

| Owner | What Goes Here |
|-------|---------------|
| **PostgreSQL** | Atomic transactions, circular FK resolution, tree traversal (ltree), vector search (pgvector), RLS, data integrity constraints |
| **NestJS** | Evolving business rules, compliance evaluation, AI orchestration, notification routing, score calculations |
| **Flutter** | UI rendering, local state management, form validation, navigation. **No business logic.** |

---

# Part XI — Flutter Coding Standards

## Naming Conventions

| Element | Convention | Example |
|---------|-----------|---------|
| Files | `snake_case` | `member_profile_view_model.dart` |
| Classes | `PascalCase` | `MemberProfileViewModel` |
| Variables | `camelCase` | `memberProfile` |
| Constants | `camelCase` | `defaultTimeout` |
| Providers | `camelCase` + `Provider` suffix | `memberProfileProvider` |
| Private members | `_camelCase` | `_client` |
| Freezed models | `PascalCase` + `Model` suffix | `MemberHeroModel` |
| Repositories | `PascalCase` + `Repository` suffix | `MemberProfileRepository` |
| Repository impls | `PascalCase` + `RepositoryImpl` suffix | `MemberProfileRepositoryImpl` |
| Pages | `PascalCase` + `Page` suffix | `MemberProfilePage` |
| Widgets | `PascalCase` (descriptive) | `MemberHero`, `ScoreRing` |

## Import Order

```dart
// 1. Dart SDK
import 'dart:async';
import 'dart:math';

// 2. Flutter SDK
import 'package:flutter/material.dart';

// 3. External packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// 4. Core
import '../../../../core/constants/app_colors.dart';

// 5. Shared
import '../../../../shared/widgets/app_card.dart';

// 6. Feature-local
import '../providers/member_profile_provider.dart';
import '../widgets/member_hero.dart';
```

## Widget Rules

1. **Use `const` constructors** wherever possible.
2. **Keep widgets small**. If a widget exceeds ~150 lines, extract sub-widgets.
3. **Prefer `StatelessWidget`** unless local state is truly needed.
4. **Use `ConsumerWidget`** or `ConsumerStatefulWidget` for Riverpod integration.
5. **Handle all `AsyncValue` states**: loading, error, data.

```dart
// ✅ Standard async pattern
ref.watch(memberProfileProvider(profileId)).when(
  data: (profile) => MemberHero(heroData: profile.hero),
  loading: () => const ShimmerPlaceholder(),
  error: (error, stack) => ErrorDisplay(message: error.toString()),
);
```

## Repository Rules

1. **Extend `BaseRepository`** for consistent error handling.
2. **Accept `SupabaseClient`** via constructor injection.
3. **Return typed Freezed models**, never raw `Map<String, dynamic>`.
4. **Wrap all calls** in try/catch using `handleException()`.

```dart
class MemberProfileRepositoryImpl extends BaseRepository
    implements MemberProfileRepository {
  final SupabaseClient _client;

  MemberProfileRepositoryImpl(this._client);

  @override
  Future<MemberProfileViewModel> getMemberProfile(String profileId) async {
    try {
      final response = await _client.rpc(
        'get_member_profile_view_model',
        params: {'p_profile_id': profileId},
      );
      return MemberProfileViewModel.fromJson(response as Map<String, dynamic>);
    } catch (e, stack) {
      handleException(e, stack);
    }
  }
}
```

## Freezed Model Rules

1. **Use `@freezed`** annotation for all data models.
2. **Use `@JsonSerializable(fieldRename: FieldRename.snake)`** for snake_case JSON.
3. **Include `factory .fromJson`** for deserialization.
4. **Keep models immutable** — no mutable fields.

```dart
@freezed
class MemberHeroModel with _$MemberHeroModel {
  const factory MemberHeroModel({
    required String distributorId,
    required String firstName,
    required String lastName,
    required String rank,
    required String status,
    String? avatarUrl,
    String? leaderName,
    required DateTime joinedDate,
    @Default(0) int currentStreak,
  }) = _MemberHeroModel;

  factory MemberHeroModel.fromJson(Map<String, dynamic> json) =>
      _$MemberHeroModelFromJson(json);
}
```

---

# Part XII — State Management

## Riverpod Patterns

### Code-Generated Providers

All providers use `@riverpod` annotation with code generation:

```dart
@riverpod
TaskRepository taskRepository(Ref ref) {
  return TaskRepositoryImpl(Supabase.instance.client);
}

@riverpod
Future<List<Task>> companyTasks(Ref ref) async {
  ref.cacheFor(const Duration(minutes: 5));
  final companyId = await ref.watch(companyIdProvider.future);
  if (companyId == null) return [];
  return ref.watch(taskRepositoryProvider).getTasks(companyId: companyId);
}
```

### TTL Caching

Use `ref.cacheFor()` for all data providers to prevent unnecessary refetching:

```dart
ref.cacheFor(const Duration(minutes: 5));  // Standard TTL
```

The `cacheFor` extension keeps providers alive for the specified duration after the last listener unsubscribes, then disposes.

### Family Providers

Use family providers for parameterized data:

```dart
@riverpod
Future<MemberProfileViewModel> memberProfile(
  Ref ref,
  String profileId,
) async {
  ref.cacheFor(const Duration(minutes: 5));
  final repo = ref.watch(memberProfileRepositoryProvider);
  return repo.getMemberProfile(profileId);
}
```

### Filter State Providers

Use `@riverpod` class-based notifiers for filter state:

```dart
@riverpod
class MemberSearchQuery extends _$MemberSearchQuery {
  @override
  String build() => '';
  void update(String query) => state = query;
}
```

### Provider Organization

Group related providers in a single file:

```
tasks_providers.dart
├── taskRepositoryProvider        (repository)
├── companyTasksProvider          (data, cached)
├── selectedTaskFilterProvider    (filter state)
├── taskSearchQueryProvider       (search state)
├── filteredTasksProvider         (computed)
└── searchedTasksProvider         (computed)
```

---

# Part XIII — Design System

## Serene Modernist

Ascendra uses the **Serene Modernist** design language — a calm, professional aesthetic with muted earth tones, clean typography, and generous whitespace.

### Color Tokens

| Token | Hex | Usage |
|-------|-----|-------|
| `primary` | `#181e1a` | Primary actions, headers |
| `secondary` | `#536257` | Secondary elements, success indicators |
| `tertiary` | `#241a1b` | Tertiary elements |
| `accentWarm` | `#D4AF37` | Gold accents, member color, warnings |
| `error` | `#ba1a1a` | Error states |
| `background` | `#fcf9f7` | Page background |
| `surface` | `#ffffff` | Card surfaces |
| `surfaceContainerLow` | `#f6f3f1` | Subtle container |
| `surfaceContainer` | `#f0edec` | Medium container |
| `surfaceVariant` | `#e5e2e0` | Variant surface |
| `onSurface` | `#1c1c1b` | Text on surfaces |
| `onSurfaceVariant` | `#444844` | Secondary text |
| `borderSubtle` | `#E5E5E0` | Subtle borders |

### Typography

| Style | Font | Size | Weight | Usage |
|-------|------|------|--------|-------|
| `displayLgMobile` | Newsreader | 36 | 600 | Hero headings |
| `h1` | Inter | 32 | 700 | Page titles |
| `h2` | Inter | 24 | 600 | Section titles |
| `h3` | Inter | 20 | 600 | Card titles |
| `subtitle1` | Inter | 16 | 500 | Subtitles |
| `body1` | Inter | 16 | 400 | Body text |
| `body2` | Inter | 14 | 400 | Secondary body |
| `bodyLg` | Hanken Grotesk | 18 | 400 | Large body text |
| `bodyMd` | Hanken Grotesk | 16 | 400 | Medium body text |
| `labelMd` | Hanken Grotesk | 14 | 600 | Labels |
| `labelSm` | Hanken Grotesk | 12 | 500 | Small labels |
| `caption` | Inter | 12 | 400 | Captions |

### Spacing Scale

| Token | Value | Usage |
|-------|-------|-------|
| `xs` | 4px | Tight gaps |
| `sm` | 8px | Small gaps |
| `md` | 16px | Standard padding |
| `lg` | 24px | Section spacing |
| `xl` | 32px | Large spacing |
| `xxl` | 48px | Major sections |

### Border Radius Scale

| Token | Value | Usage |
|-------|-------|-------|
| `sm` | 4px | Small elements |
| `md` | 8px | Buttons, inputs |
| `lg` | 12px | Cards |
| `xl` | 16px | Dialogs |
| `xxl` | 24px | Modal sheets |
| `full` | 9999px | Circles, pills |

### Dark Mode

The app supports system-driven dark mode via `ThemeMode.system`. Dark theme uses:

```dart
scaffoldBackgroundColor: Color(0xFF111827)
appBarBackgroundColor: Color(0xFF1F2937)
```

Color scheme is generated from `ColorScheme.fromSeed` with `brightness: Brightness.dark`.

---

# Part XIV — Responsive Design

## Breakpoints

| Name | Width | Usage |
|------|-------|-------|
| `mobileSmall` | 360px | Minimum supported width |
| `mobileMedium` | 390px | Standard phones |
| `mobileLarge` | 414px | Large phones |
| `tabletSmall` | 768px | Portrait tablets |
| `tabletLarge` | 1024px | Landscape tablets |
| `desktop` | 1280px | Desktop browsers |

## Responsive Utilities

Located in `core/responsive/`:

- **`ResponsiveBreakpoints`** — Static breakpoint constants
- **`ResponsiveBuilder`** — Widget that provides different layouts per breakpoint
- **`ResponsiveGrid`** — Flexible grid with responsive column counts
- **`ResponsivePadding`** — Automatic padding adjustment by screen width

## Rules

1. Every screen must work at 360px without horizontal overflow.
2. Use `ResponsiveBuilder` for layout variations, not `MediaQuery.of(context)` directly.
3. Use `ResponsiveGrid` for metric cards and dashboards.
4. Use `ResponsivePadding` for consistent edge spacing.
5. Test on at least: 360px, 390px, 768px, 1280px.

---

# Part XV — Performance Rules

1. **Use `const` constructors** wherever possible to prevent unnecessary rebuilds.
2. **Minimize provider rebuilds** — use `select()` to watch only specific fields.
3. **Use `ref.cacheFor()`** on all data providers (5-minute standard TTL).
4. **Avoid rebuilding large lists** — use `ListView.builder` with item keys.
5. **Use `cached_network_image`** for all network images.
6. **Lazy-load heavy content** — defer analytics charts and timelines.
7. **Never compute aggregates in Flutter** — use backend RPCs and materialized views.
8. **Profile with DevTools** before and after optimization changes.
9. **Keep widget trees shallow** — extract deeply nested builders into separate widgets.
10. **Use `const` for static decoration objects** (BoxDecoration, EdgeInsets, TextStyle).

---

# Part XVI — Accessibility Rules

1. **Use Semantic widgets** — `Semantics`, `ExcludeSemantics`, `MergeSemantics`.
2. **Add labels to icon buttons** — use `tooltip` parameter.
3. **Ensure touch targets ≥ 48x48** logical pixels.
4. **Maintain contrast ratios** — minimum 4.5:1 for normal text, 3:1 for large text.
5. **Support screen readers** — test with TalkBack (Android) and VoiceOver (iOS).
6. **Support keyboard navigation** — ensure focus order is logical.
7. **Never convey information by color alone** — pair color with icons or text.
8. **Use `textScaleFactor` awareness** — layouts should not break at 200% text size.

---

# Part XVII — Security Rules

1. **Never hardcode secrets** — use environment variables or `flutter_secure_storage`.
2. **Supabase anon key is NOT a secret** — it's a publishable key. It's safe in client code.
3. **Never bypass RLS** — always use `SECURITY INVOKER` for RPCs unless specifically needed.
4. **Validate all inputs** — both client-side (UX) and server-side (security).
5. **Use HTTPS exclusively** — no HTTP endpoints.
6. **Store tokens in `SecureLocalStorage`** — never in SharedPreferences or plain text.
7. **Sanitize user-generated content** — prevent XSS in web builds.
8. **Never log sensitive data** — no passwords, tokens, or PII in logs.
9. **Use parameterized queries** — never concatenate SQL strings.
10. **Review RLS policies** when adding new tables or modifying schema.

---

# Part XVIII — Testing Requirements

## Test Types

| Type | Location | Purpose |
|------|----------|---------|
| Repository Tests | `test/features/<name>/data/` | Verify repository methods against mocked Supabase |
| Provider Tests | `test/features/<name>/presentation/` | Verify provider state transitions |
| Widget Tests | `test/features/<name>/presentation/` | Verify UI rendering and interactions |
| Golden Tests | `test/golden/` | Verify pixel-perfect UI against reference images |
| Integration Tests | `integration_test/` | End-to-end flows with real backend |

## Testing Patterns

### Repository Test

```dart
test('getMemberProfile returns parsed model', () async {
  when(mockClient.rpc('get_member_profile_view_model', params: any))
      .thenAnswer((_) async => mockJson);

  final result = await repo.getMemberProfile('test-id');
  expect(result.hero.firstName, 'John');
});
```

### Provider Test

```dart
test('memberProfile provider fetches and caches', () async {
  final container = ProviderContainer(overrides: [
    memberProfileRepositoryProvider.overrideWithValue(mockRepo),
  ]);

  final result = await container.read(memberProfileProvider('id').future);
  expect(result.hero.distributorId, 'D001');
});
```

### Widget Test

```dart
testWidgets('MemberHero displays name', (tester) async {
  await tester.pumpWidget(
    MaterialApp(home: MemberHero(heroData: testHero)),
  );
  expect(find.text('John Doe'), findsOneWidget);
});
```

## Coverage Requirements

- Repositories: 80%+ coverage
- Providers: 80%+ coverage
- Critical widgets: Key interaction paths tested
- Integration: Core user journeys (login, create task, schedule meeting)

---

# Part XIX — Build & Run Commands

## Daily Development

```bash
# Install dependencies
flutter pub get

# Generate code (Freezed, Riverpod, JSON)
dart run build_runner build -d

# Watch for changes (development)
dart run build_runner watch -d

# Format code
dart format .

# Analyze for errors
flutter analyze

# Run tests
flutter test

# Run integration tests
flutter test integration_test

# Run app (debug)
flutter run

# Clean project
flutter clean && flutter pub get && dart run build_runner build -d
```

## Build Artifacts

```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# Split APKs (smaller downloads)
flutter build apk --split-per-abi

# App Bundle (Play Store)
flutter build appbundle --release

# iOS (requires macOS)
flutter build ios --release

# Web
flutter build web --release
```

## Output Locations

| Build Type | Output Path |
|-----------|-------------|
| Debug APK | `build/app/outputs/flutter-apk/app-debug.apk` |
| Release APK | `build/app/outputs/flutter-apk/app-release.apk` |
| Split APKs | `build/app/outputs/flutter-apk/app-{abi}-release.apk` |
| App Bundle | `build/app/outputs/bundle/release/app-release.aab` |
| Web | `build/web/` |

## Code Generation Requirements

After modifying **any** file with `@freezed`, `@riverpod`, or `@JsonSerializable` annotations:

```bash
dart run build_runner build -d
```

The `-d` flag deletes conflicting outputs. Always run this after:

- Adding/modifying Freezed models
- Adding/modifying Riverpod providers
- Adding/modifying JSON serializable classes

---

# Part XX — Release Process

## Version Bumping

Update `pubspec.yaml`:

```yaml
version: 1.2.0+5    # major.minor.patch+buildNumber
```

- **Major**: Breaking changes, major redesigns
- **Minor**: New features
- **Patch**: Bug fixes
- **Build number**: Always increment for Play Store

## Signing (Android)

1. **Keystore**: Must exist at the configured path in `android/app/build.gradle`.
2. **Key properties**: Stored in `android/key.properties` (gitignored).
3. **Proguard**: Configure in `android/app/proguard-rules.pro` if using obfuscation.

## Release Checklist

- [ ] Version bumped in `pubspec.yaml`
- [ ] `flutter analyze` passes with zero errors
- [ ] `flutter test` passes
- [ ] Build succeeds: `flutter build appbundle --release`
- [ ] Tested on physical device
- [ ] Changelog updated
- [ ] Git tagged: `git tag v1.2.0`

---

# Part XXI — Git Workflow & Code Review

## Branch Strategy

```
main              ← Production releases
  └── develop     ← Integration branch
       └── feature/<name>    ← Feature branches
       └── fix/<name>        ← Bug fix branches
       └── milestone/<name>  ← Milestone branches
```

## Commit Messages

```
feat: add member profile hero widget
fix: resolve overflow on 360px screens
refactor: extract timeline into shared widget
docs: add members guide
chore: update dependencies
test: add member repository tests
```

## Code Review Checklist

Before merging, verify:

- [ ] Follows Clean Architecture (no layer violations)
- [ ] Uses existing shared widgets (no duplicates)
- [ ] Responsive at 360px–1280px
- [ ] Widgets are presentation-only (no data fetching)
- [ ] Analytics computed on backend (no client-side aggregation)
- [ ] `flutter analyze` clean
- [ ] Tests pass
- [ ] Design matches reference (if reference exists)
- [ ] Skills folder consulted (if applicable)
- [ ] New models use Freezed + json_serializable
- [ ] New providers use `@riverpod` with code generation
- [ ] TTL caching applied to data providers

---

# Part XXII — Documentation Standards

## Architecture Decision Records (ADRs)

Location: `docs/backend/adrs/`

Format:

```markdown
# ADR-NNN: Title

## Status: Accepted | Deprecated | Superseded

## Context
Why this decision was needed.

## Decision
What was decided.

## Consequences
Positive and negative outcomes.
```

## Existing ADRs

| ADR | Title |
|-----|-------|
| 001 | Row-Level Security |
| 002 | ltree for Hierarchical Data |
| 003 | RPC-Based Dashboard |
| 004 | 100ms for Video |
| 005 | Gemini RAG Architecture |
| 006 | BullMQ Event Bus |
| 007 | Materialized View Refresh Strategy |
| 008 | Business Logic Boundaries |

## Code Comments

- Use `///` doc comments on public APIs.
- Explain **why**, not **what**.
- Mark TODOs with `// TODO(name): description`.

---

# Part XXIII — Code Simplification Rules

When reviewing or writing code, actively apply these simplification patterns:

### 1. Replace Nested Ifs with Guard Clauses

```dart
// ❌ Before
if (user != null) {
  if (user.isActive) {
    return buildProfile(user);
  }
}
return const SizedBox.shrink();

// ✅ After
if (user == null || !user.isActive) return const SizedBox.shrink();
return buildProfile(user);
```

### 2. Extract Duplicate Widgets

If the same widget structure appears in 2+ places, extract it into `shared/widgets/`.

### 3. Remove Unnecessary Abstractions

If a use case class just delegates to a repository with no additional logic, remove it and call the repository directly from the provider.

### 4. Replace Manual JSON Parsing with Freezed

```dart
// ❌ Before
final name = json['first_name'] as String;

// ✅ After
final model = MemberHeroModel.fromJson(json);
```

### 5. Move Business Logic to Repositories

If a widget or provider contains business logic (calculations, filtering rules, status transitions), move it to a repository or backend RPC.

### 6. Use Extensions for Common Patterns

```dart
extension DateFormatting on DateTime {
  String get relativeLabel {
    final diff = DateTime.now().difference(this);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    return '${diff.inDays}d ago';
  }
}
```

---

# Part XXIV — AI Self-Review Checklist

Before completing **every task**, the AI must verify:

- [ ] Did I inspect reference UI assets (if they exist for this screen)?
- [ ] Did I search and apply relevant Skills?
- [ ] Did I use the appropriate plugin/MCP when it would help?
- [ ] Did I reuse existing shared widgets instead of creating duplicates?
- [ ] Did I violate Clean Architecture dependency rules?
- [ ] Did I compute analytics or aggregates in Flutter? (**Must be NO**)
- [ ] Are all widgets presentation-only (no direct data fetching)?
- [ ] Is the screen responsive from 360px to desktop?
- [ ] Did I follow Serene Modernist design tokens?
- [ ] Are new models using Freezed with JSON serialization?
- [ ] Are new providers using `@riverpod` code generation?
- [ ] Is `ref.cacheFor()` applied to data providers?
- [ ] Does `flutter analyze` pass with zero errors?
- [ ] Can any of this code be simpler?
- [ ] Can any of this code be reused?

---

# Part XXV — Definition of Done

A feature is **not complete** until ALL of the following are true:

### Code Quality
- [ ] `flutter analyze` passes with zero errors
- [ ] `dart format .` applied
- [ ] Code follows naming conventions
- [ ] No duplicated logic

### Architecture
- [ ] Clean Architecture layers respected
- [ ] Repository pattern used for data access
- [ ] Providers use `@riverpod` code generation
- [ ] Models use `@freezed` with `json_serializable`
- [ ] No business logic in widgets or providers

### UI
- [ ] Responsive from 360px to desktop
- [ ] Matches reference design (if reference exists)
- [ ] Uses design system tokens (AppColors, AppTypography, AppSpacing)
- [ ] Reuses existing shared widgets where applicable
- [ ] Loading, error, and empty states handled

### Backend
- [ ] Analytics and aggregates computed via RPC/materialized views
- [ ] Data flows through repository → provider → widget
- [ ] Error handling uses BaseRepository pattern

### Testing
- [ ] Repository methods have unit tests
- [ ] Critical providers have state tests
- [ ] Key widget interactions are tested

### Process
- [ ] Skills folder consulted
- [ ] Reference UI inspected
- [ ] AI Self-Review Checklist passed
- [ ] Code review checklist passed

---

# Reference Documents

For detailed information on specific topics, see these companion documents:

| Document | Topic |
|----------|-------|
| [docs/PROJECT_OVERVIEW.md](docs/PROJECT_OVERVIEW.md) | Vision, business context, user roles |
| [docs/PROJECT_ARCHITECTURE.md](docs/PROJECT_ARCHITECTURE.md) | Full system architecture diagrams |
| [docs/BUSINESS_RULES.md](docs/BUSINESS_RULES.md) | Profile lifecycle, subscription limits |
| [docs/FOLDER_STRUCTURE.md](docs/FOLDER_STRUCTURE.md) | Complete directory guide |
| [docs/DEPENDENCIES.md](docs/DEPENDENCIES.md) | Why each package exists |
| [docs/ENVIRONMENT.md](docs/ENVIRONMENT.md) | Environment configuration |
| [docs/FLUTTER_GUIDE.md](docs/FLUTTER_GUIDE.md) | Flutter development guide |
| [docs/RIVERPOD_GUIDE.md](docs/RIVERPOD_GUIDE.md) | Riverpod patterns |
| [docs/CLEAN_ARCHITECTURE.md](docs/CLEAN_ARCHITECTURE.md) | Layer rules and dependency diagram |
| [docs/CODING_STANDARDS.md](docs/CODING_STANDARDS.md) | Naming, imports, style |
| [docs/DESIGN_SYSTEM.md](docs/DESIGN_SYSTEM.md) | Complete Serene Modernist specification |
| [docs/RESPONSIVE_GUIDELINES.md](docs/RESPONSIVE_GUIDELINES.md) | Breakpoints and responsive utilities |
| [docs/UI_IMPLEMENTATION_GUIDE.md](docs/UI_IMPLEMENTATION_GUIDE.md) | Reference-first UI workflow |
| [docs/SCREEN_CATALOG.md](docs/SCREEN_CATALOG.md) | All screens with routes and components |
| [docs/COMPONENT_CATALOG.md](docs/COMPONENT_CATALOG.md) | All reusable widgets |
| [docs/SUPABASE_GUIDE.md](docs/SUPABASE_GUIDE.md) | Supabase integration |
| [docs/DATABASE_GUIDE.md](docs/DATABASE_GUIDE.md) | Database conventions |
| [docs/DATABASE_SCHEMA.md](docs/DATABASE_SCHEMA.md) | Tables, views, indexes |
| [docs/RPC_GUIDE.md](docs/RPC_GUIDE.md) | RPC conventions |
| [docs/API_REFERENCE.md](docs/API_REFERENCE.md) | Complete RPC catalog |
| [docs/STORAGE_GUIDE.md](docs/STORAGE_GUIDE.md) | File uploads and storage |
| [docs/AUTHENTICATION_GUIDE.md](docs/AUTHENTICATION_GUIDE.md) | Auth flow and session management |
| [docs/ADR_INDEX.md](docs/ADR_INDEX.md) | Architecture decision index |
| [docs/MEETINGS_GUIDE.md](docs/MEETINGS_GUIDE.md) | Meetings feature |
| [docs/TASKS_GUIDE.md](docs/TASKS_GUIDE.md) | Tasks feature |
| [docs/MEMBERS_GUIDE.md](docs/MEMBERS_GUIDE.md) | Members feature |
| [docs/NETWORK_GUIDE.md](docs/NETWORK_GUIDE.md) | Network hierarchy |
| [docs/ANALYTICS_GUIDE.md](docs/ANALYTICS_GUIDE.md) | Analytics and materialized views |
| [docs/AI_GUIDE.md](docs/AI_GUIDE.md) | AI assistant and RAG |
| [docs/SETTINGS_GUIDE.md](docs/SETTINGS_GUIDE.md) | Settings feature |
| [docs/SKILLS_GUIDE.md](docs/SKILLS_GUIDE.md) | Skills discovery system |
| [docs/PLUGIN_GUIDE.md](docs/PLUGIN_GUIDE.md) | Plugin and MCP usage |
| [docs/BUILD_GUIDE.md](docs/BUILD_GUIDE.md) | Build commands and configuration |
| [docs/RELEASE_GUIDE.md](docs/RELEASE_GUIDE.md) | Release process |
| [docs/UPGRADE_GUIDE.md](docs/UPGRADE_GUIDE.md) | SDK and package upgrades |
| [docs/TESTING_GUIDE.md](docs/TESTING_GUIDE.md) | Testing strategy |
| [docs/DEVELOPMENT_WORKFLOW.md](docs/DEVELOPMENT_WORKFLOW.md) | Development process |
| [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md) | Getting started |
| [docs/AI_WORKFLOW.md](docs/AI_WORKFLOW.md) | AI agent workflow |
| [docs/PERFORMANCE_GUIDE.md](docs/PERFORMANCE_GUIDE.md) | Performance optimization |
| [docs/ACCESSIBILITY_GUIDE.md](docs/ACCESSIBILITY_GUIDE.md) | Accessibility standards |
| [docs/SECURITY_GUIDE.md](docs/SECURITY_GUIDE.md) | Security requirements |
| [docs/DEBUGGING_GUIDE.md](docs/DEBUGGING_GUIDE.md) | Debugging techniques |
| [docs/CODE_REVIEW.md](docs/CODE_REVIEW.md) | Review checklist |
| [docs/DEFINITIONS_OF_DONE.md](docs/DEFINITIONS_OF_DONE.md) | Completion checklists |
| [docs/CHANGELOG_GUIDE.md](docs/CHANGELOG_GUIDE.md) | Changelog format |
| [.ai-core/SKILL_INDEX.md](.ai-core/SKILL_INDEX.md) | Skill discovery guide |
| [.ai-core/PLUGIN_INDEX.md](.ai-core/PLUGIN_INDEX.md) | Plugin capabilities |
| [.ai-core/FEATURE_TO_SKILL_MAP.md](.ai-core/FEATURE_TO_SKILL_MAP.md) | Task-to-skill mapping |
| [.ai-core/FEATURE_TO_PLUGIN_MAP.md](.ai-core/FEATURE_TO_PLUGIN_MAP.md) | Feature-to-plugin mapping |
| [.ai-core/BUILD_COMMANDS.md](.ai-core/BUILD_COMMANDS.md) | Quick command reference |
| [.ai-core/COMMON_WORKFLOWS.md](.ai-core/COMMON_WORKFLOWS.md) | Step-by-step recipes |
| [.ai-core/ARCHITECTURE_DECISIONS.md](.ai-core/ARCHITECTURE_DECISIONS.md) | ADR summaries |
| [.ai-core/CHECKLISTS.md](.ai-core/CHECKLISTS.md) | Pre-commit, pre-PR checklists |
| [.ai-core/MEMORY.md](.ai-core/MEMORY.md) | Permanent AI assumptions |
| [.ai-core/AI_RULES.md](.ai-core/AI_RULES.md) | AI prohibitions and constraints |
| [.ai-core/DECISION_TREE.md](.ai-core/DECISION_TREE.md) | Implementation decision flow |

---

*This document is the source of truth for all AI agents working on Ascendra. It must be kept up-to-date as the project evolves.*
