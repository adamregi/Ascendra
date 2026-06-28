# Architecture Evolution Log — Ascendra

> **Purpose**: A chronological log of major architectural shifts. This allows AI agents to learn the historical context of the codebase and understand why older code might look different than newer code.

---

## v0.1 — The Prototype (Deprecated)

- **UI**: Standard Material 3 widgets with inline colors.
- **State**: `StatefulWidget` and `setState`.
- **Backend**: Direct Supabase client queries (`Supabase.instance.client.from('tasks').select()`).
- **Database**: Standard Postgres relational tables with foreign keys.

## v0.2 — The Refactor (Deprecated)

- **UI**: Introduction of the Serene Modernist design tokens.
- **State**: BLoC pattern introduced for separating business logic.
- **Backend**: Row Level Security (RLS) enabled on all tables.
- **Database**: Introduction of `pg_trgm` for member search.

## v1.0 — Current Architecture (Active)

- **UI**: Strict enforcement of `AppColors`, `AppTypography`, and `lib/shared/widgets/`.
- **State**: Complete migration from BLoC to Riverpod (`@riverpod` code generation) for superior caching (`ref.cacheFor`) and reduced boilerplate.
- **Backend**: Strict Backend-for-Frontend (BFF) pattern. Flutter NEVER queries tables directly. All complex data is fetched via PostgreSQL RPCs returning JSON.
- **Database**: Introduction of `ltree` for hierarchical MLM data (replacing recursive CTEs). Introduction of Materialized Views for dashboard aggregations.

## v2.0 — AI Integration (Upcoming)

- **UI**: AI Chat interfaces and voice integration.
- **State**: Streaming RPCs via Supabase Realtime to update UI without manual invalidation.
- **Backend**: Heavy reliance on NestJS workers orchestrating Google Gemini workflows.
- **Database**: `pgvector` indexing for Retrieval-Augmented Generation (RAG) over company documents.
