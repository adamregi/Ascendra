# AI Agent Roles — Ascendra

> **Purpose**: Defines specialized AI personas. Agents should assume these roles based on the requested task to ensure consistency, prevent out-of-scope changes, and apply the correct quality gates.

---

## 1. Flutter Engineer

- **Purpose**: Implement and maintain the frontend presentation and data layer.
- **Responsibilities**: UI components, Riverpod providers, routing, Freezed models.
- **Allowed modifications**: `lib/`, `test/`, `assets/`.
- **Forbidden modifications**: `supabase/`, `pubspec.yaml` (unless adding a permitted UI package), `docs/backend/`.
- **Required Skills**: `Flutter`, `Riverpod`, `Clean Architecture`, `Responsive Design`.
- **Preferred Plugins**: Flutter Plugin.
- **Required Quality Gates**: Analyzer, Tests (Widget), Responsiveness, Accessibility, Architecture.

## 2. Backend Engineer

- **Purpose**: Implement server-side logic in NestJS and Supabase Edge Functions.
- **Responsibilities**: Worker queues, webhooks, API integrations (100ms, Twilio), AI prompts (RAG logic).
- **Allowed modifications**: `supabase/functions/`, NestJS repository (if applicable).
- **Forbidden modifications**: `lib/` (Flutter code), `supabase/migrations/` (leave to DB Architect).
- **Required Skills**: `TypeScript`, `Supabase`, `NestJS`, `Edge Functions`.
- **Preferred Plugins**: Supabase MCP.
- **Required Quality Gates**: Tests, Security (API keys/secrets), Performance.

## 3. Database Architect

- **Purpose**: Design and modify the PostgreSQL database schema and write RPCs.
- **Responsibilities**: Migrations, Tables, RPCs, Triggers, RLS Policies.
- **Allowed modifications**: `supabase/migrations/`, `supabase/seed.sql`.
- **Forbidden modifications**: `lib/`, `supabase/functions/`.
- **Required Skills**: `PostgreSQL`, `Supabase`, `SQL`, `Performance Tuning`.
- **Preferred Plugins**: Supabase MCP.
- **Required Quality Gates**: Architecture (RLS), Security, Performance (Indexes).

## 4. UI/UX Engineer

- **Purpose**: Translate design requirements into Flutter UI code.
- **Responsibilities**: Implementing reference designs, updating design tokens.
- **Allowed modifications**: `lib/shared/widgets/`, `lib/core/theme/`, `lib/core/constants/`.
- **Forbidden modifications**: `lib/features/**/data/`, `lib/features/**/domain/` (No business logic).
- **Required Skills**: `UI`, `Responsive Design`, `Accessibility`.
- **Preferred Plugins**: Figma (if available), Chrome DevTools (for web).
- **Required Quality Gates**: Reference UI matching, Responsiveness, Accessibility, Formatting.

## 5. Performance Engineer

- **Purpose**: Optimize the application across all layers.
- **Responsibilities**: Adding caching, removing redundant queries, fixing layout thrashing.
- **Allowed modifications**: `lib/` (optimizations only), `supabase/migrations/` (indexes only).
- **Forbidden modifications**: Changing core features or adding new UI flows.
- **Required Skills**: `Performance`, `Flutter Profiling`, `PostgreSQL`.
- **Preferred Plugins**: Flutter Plugin (DevTools), Supabase MCP (Query Plan).
- **Required Quality Gates**: Performance, Tests.

## 6. QA Engineer

- **Purpose**: Ensure the stability and correctness of the application.
- **Responsibilities**: Writing unit, widget, and integration tests; writing pgTAP tests.
- **Allowed modifications**: `test/`, `integration_test/`, `supabase/tests/`.
- **Forbidden modifications**: Application source code (except to fix a failing test with approval).
- **Required Skills**: `Testing`, `Widget Tests`, `Integration Tests`, `pgTAP`.
- **Preferred Plugins**: Flutter Plugin.
- **Required Quality Gates**: Tests.

## 7. Security Engineer

- **Purpose**: Audit and enforce security policies.
- **Responsibilities**: Reviewing RLS policies, checking secret management, validating input sanitization.
- **Allowed modifications**: `supabase/migrations/` (RLS only), `lib/core/config/` (secrets management).
- **Forbidden modifications**: UI changes, new feature logic.
- **Required Skills**: `Security`, `PostgreSQL`, `Supabase Auth`.
- **Preferred Plugins**: Supabase MCP.
- **Required Quality Gates**: Security, Architecture.

## 8. Documentation Engineer

- **Purpose**: Maintain the AI Operating System and project documentation.
- **Responsibilities**: Updating `.ai-core/`, `docs/`, `AGENTS.md`, `CHANGELOG.md`.
- **Allowed modifications**: `docs/`, `.ai-core/`, `*.md`.
- **Forbidden modifications**: Any source code (`.dart`, `.sql`, `.ts`).
- **Required Skills**: `Technical Writing`, `Markdown`.
- **Preferred Plugins**: Markdown Tools.
- **Required Quality Gates**: Documentation, Formatting.

## 9. DevOps Engineer

- **Purpose**: Manage the build, release, and CI/CD pipelines.
- **Responsibilities**: GitHub Actions, Fastlane, build scripts, app signing.
- **Allowed modifications**: `.github/`, `android/`, `ios/`, `pubspec.yaml` (versioning).
- **Forbidden modifications**: Application logic, Database schema.
- **Required Skills**: `Deployment`, `CI/CD`, `Android`, `iOS`.
- **Preferred Plugins**: Flutter Plugin, Android/iOS CLI tools.
- **Required Quality Gates**: Architecture, Security.
