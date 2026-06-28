# File Ownership & Boundaries — Ascendra

> **Purpose**: A definitive guide on what is allowed and forbidden in specific directories to prevent architectural violations.

---

## 1. Flutter Core (`lib/core/`)

**Owner**: Lead Flutter Engineer / UI/UX Engineer

### `lib/core/constants/` & `lib/core/theme/`
- **Purpose**: Defining the Serene Modernist design tokens.
- **Allowed Changes**: Adding new colors, typography styles, or spacing variables.
- **Forbidden Changes**: Adding business logic, feature-specific variables (e.g., `TasksColors`).
- **Dependencies**: None.

### `lib/core/config/`
- **Purpose**: Environment variables and app initialization.
- **Allowed Changes**: Adding new environment variables read via `--dart-define`.
- **Forbidden Changes**: Hardcoding secrets (e.g., `static const apiKey = '123'`).

## 2. Flutter Shared (`lib/shared/`)

**Owner**: Flutter Engineer

### `lib/shared/widgets/`
- **Purpose**: Highly reusable, generic UI components (Buttons, Cards, Inputs).
- **Allowed Changes**: Creating new generic components or modifying existing ones.
- **Forbidden Changes**: Fetching data via Riverpod inside these widgets. Passing feature-specific domain models (e.g., passing a `TaskModel` into an `AppButton`).
- **Dependencies**: `lib/core/constants/`.

## 3. Flutter Features (`lib/features/`)

**Owner**: Flutter Engineer

### `lib/features/<name>/data/`
- **Purpose**: API communication and JSON parsing.
- **Allowed Changes**: Creating Freezed DTOs, implementing Repositories, making Supabase calls.
- **Forbidden Changes**: UI code, state management (Notifiers).
- **Dependencies**: `domain/`, `core/network/`.

### `lib/features/<name>/presentation/`
- **Purpose**: UI and local state.
- **Allowed Changes**: Pages, Widgets, Riverpod Providers (`@riverpod`).
- **Forbidden Changes**: Direct Supabase calls (`Supabase.instance.client...`), manual JSON parsing.
- **Dependencies**: `domain/`, `shared/`, `core/`.

## 4. Backend (`supabase/`)

**Owner**: Database Architect / Backend Engineer

### `supabase/migrations/`
- **Purpose**: Defining the database schema and RPCs.
- **Allowed Changes**: Creating new chronological `.sql` files.
- **Forbidden Changes**: Editing existing migrations that have already been applied to production.
- **Dependencies**: PostgreSQL, `pgvector`, `ltree`.

### `supabase/functions/`
- **Purpose**: Deno/TypeScript Edge Functions for 3rd-party integrations.
- **Allowed Changes**: Adding new functions, updating shared Deno modules.
- **Forbidden Changes**: Complex business logic that requires heavy database reads (use NestJS instead).
- **Dependencies**: Supabase Deno SDK, external REST APIs.
