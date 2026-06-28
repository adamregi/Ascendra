# Folder Structure — Ascendra

> **Purpose**: A comprehensive guide to the project's directory structure, explaining the purpose and ownership of every major folder.

---

## 1. Project Root

```
distributor_os/
├── .agents/               # (Legacy) Replaced by root AGENTS.md
├── .ai-core/                   # AI-specific indexes, maps, and rules
├── .dart_tool/            # Dart build cache (gitignored)
├── .github/               # GitHub Actions CI/CD workflows
├── android/               # Native Android code and build configs
├── assets/                # Images, fonts, and reference designs
├── build/                 # Build outputs (gitignored)
├── docs/                  # This documentation suite
├── ios/                   # Native iOS code and build configs
├── lib/                   # Primary Flutter/Dart source code
├── macos/                 # Native macOS code
├── linux/                 # Native Linux code
├── windows/               # Native Windows code
├── Skills/                # AI Skills library (24,000+ files)
├── supabase/              # Database schema, functions, and config
├── test/                  # Unit and widget tests
├── integration_test/      # End-to-end UI tests
├── analysis_options.yaml  # Lint and formatting rules
├── pubspec.yaml           # Flutter dependencies and versioning
└── AGENTS.md              # The master AI operating manual
```

## 2. Flutter Source (`lib/`)

```
lib/
├── main.dart              # Application entry point (initializes Supabase)
├── app/                   # App-wide configuration
│   ├── bootstrap/         # Auth initialization and routing logic
│   ├── providers/         # Global state providers (theme, locale)
│   └── Router/            # GoRouter configuration and route definitions
│
├── core/                  # Cross-cutting concerns (used everywhere)
│   ├── config/            # Environment and service configurations
│   ├── constants/         # Design tokens (colors, typography, spacing)
│   ├── errors/            # Custom exception types
│   ├── extensions/        # Dart extensions (e.g., ref.cacheFor)
│   ├── failures/          # Domain failure types
│   ├── network/           # API clients and interceptors
│   ├── repositories/      # Base repository class
│   ├── responsive/        # Breakpoints, grids, and responsive builders
│   ├── services/          # Third-party integrations (100ms, Firebase)
│   ├── theme/             # Light/dark theme data
│   ├── utils/             # Helper functions
│   └── widgets/           # Core UI primitives
│
├── shared/                # Shared domain logic and complex widgets
│   ├── extensions/        # Shared extensions
│   ├── models/            # Shared data models (e.g., pagination responses)
│   └── widgets/           # Reusable components (e.g., AppCard, AppAvatar)
│
└── features/              # Feature modules (Clean Architecture)
```

## 3. Feature Modules (`lib/features/`)

Ascendra uses feature-based modularity. Each feature folder follows Clean Architecture.

```
features/<feature_name>/
├── data/                  # Data layer
│   ├── models/            # Freezed + JSON serializable DTOs
│   └── repositories/      # Implementations of abstract repositories
│
├── domain/                # Domain layer
│   ├── entities/          # Pure domain models (if applicable)
│   └── repositories/      # Abstract repository interfaces
│
└── presentation/          # Presentation layer
    ├── pages/             # Full-screen route destinations
    ├── providers/         # Riverpod providers (.g.dart generated files)
    └── widgets/           # Feature-specific UI components
```

**Available Features:**
`auth`, `dashboard`, `meetings`, `tasks`, `members`, `compliance`, `ai`, `ai_assistant`, `alerts`, `settings`, `subscriptions`, `knowledge`, `followups`, `invitations`, `profile`, `dev`.

## 4. Supabase Backend (`supabase/`)

```
supabase/
├── config.toml            # Local development configuration
├── seed.sql               # Seed data for local testing
├── migrations/            # Sequential SQL migrations (001 to current)
└── functions/             # Edge Functions (Deno/TypeScript)
    ├── _shared/           # Shared TS modules and CORS headers
    ├── create-company/    # Company onboarding logic
    ├── invite-member/     # Twilio integration for OTP
    ├── accept-invitation/ # Transactional acceptance logic
    ├── schedule-meeting/  # 100ms room creation
    └── ai-chat/           # Basic AI routing
```

## 5. Dependency Rules

| Source | Target (Allowed) | Target (Forbidden) |
|--------|------------------|--------------------|
| `core/` | Dart/Flutter SDK, packages | `features/`, `shared/` |
| `shared/` | `core/`, SDK, packages | `features/` |
| `features/<A>/presentation/`| `domain/`, `shared/`, `core/` | `data/`, `features/<B>/` |
| `features/<A>/domain/` | `core/`, Dart SDK | `data/`, `presentation/`, packages |
| `features/<A>/data/` | `domain/`, `core/`, packages | `presentation/` |

---

*See also: [CLEAN_ARCHITECTURE.md](CLEAN_ARCHITECTURE.md)*
