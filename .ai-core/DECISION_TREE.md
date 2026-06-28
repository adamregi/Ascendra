# Decision Tree — Ascendra

> **Purpose**: Helps AI agents choose the correct implementation path for common architectural decisions.

---

## 1. Where Should This Logic Live?

```
Is it a UI concern (layout, animation, user interaction)?
├── YES → Flutter widget (presentation layer)
│
└── NO → Does it involve data aggregation, scoring, or analytics?
    ├── YES → Backend RPC or materialized view
    │         Flutter NEVER computes aggregates
    │
    └── NO → Is it a simple data transformation (formatting, sorting)?
        ├── YES → Repository or provider (data/presentation layer)
        │
        └── NO → Is it a complex business rule that changes with product iterations?
            ├── YES → NestJS application service (migrate from SQL when ready)
            │
            └── NO → Is it data integrity or atomic transaction?
                ├── YES → PostgreSQL RPC (keep in SQL)
                │
                └── NO → Ask the user for clarification
```

## 2. How Should I Fetch This Data?

```
Does an RPC already exist for this data?
├── YES → Use the existing RPC through a repository
│
└── NO → Is the data an aggregate/computed value?
    ├── YES → Create a new RPC (do not compute in Flutter)
    │         File: supabase/migrations/0XX_<feature>_rpc.sql
    │
    └── NO → Is it a simple CRUD read?
        ├── YES → Use Supabase PostgREST through a repository
        │         _client.from('table').select().eq('id', id)
        │
        └── NO → Does it require cross-service orchestration?
            ├── YES → Call NestJS API via Dio through a repository
            │
            └── NO → Use Supabase PostgREST with filters
```

## 3. Where Should I Put This File?

```
Is it a data model (DTO)?
├── YES → lib/features/<feature>/data/models/<name>_model.dart
│
├── Is it a domain entity?
│   └── YES → lib/features/<feature>/domain/entities/<name>.dart
│
├── Is it a repository interface?
│   └── YES → lib/features/<feature>/domain/repositories/<name>_repository.dart
│
├── Is it a repository implementation?
│   └── YES → lib/features/<feature>/data/repositories/<name>_repository_impl.dart
│
├── Is it a provider?
│   └── YES → lib/features/<feature>/presentation/providers/<name>_provider.dart
│
├── Is it a page (full screen)?
│   └── YES → lib/features/<feature>/presentation/pages/<name>_page.dart
│
├── Is it a feature-specific widget?
│   └── YES → lib/features/<feature>/presentation/widgets/<name>.dart
│
├── Is it a shared widget (used across features)?
│   └── YES → lib/shared/widgets/<name>.dart
│
├── Is it a core utility (used everywhere)?
│   └── YES → lib/core/<category>/<name>.dart
│
├── Is it a SQL migration?
│   └── YES → supabase/migrations/0XX_<description>.sql
│
└── Is it a test?
    └── YES → test/features/<feature>/<layer>/<name>_test.dart
```

## 4. Should I Create a New Widget or Reuse?

```
Does an existing widget in shared/widgets/ handle this?
├── YES → Reuse it (pass different parameters if needed)
│
└── NO → Does an existing widget in the feature's widgets/ handle this?
    ├── YES → Reuse it
    │
    └── NO → Will this widget be used in 2+ features?
        ├── YES → Create in lib/shared/widgets/
        │
        └── NO → Create in lib/features/<feature>/presentation/widgets/
```

## 5. RPC vs Edge Function vs NestJS

```
Is the operation a simple database read/write?
├── YES → RPC in PostgreSQL
│         - Respects RLS automatically
│         - Called via Supabase PostgREST
│
└── NO → Does it need < 15 second execution time?
    ├── YES → Does it interact with external APIs (100ms, webhooks)?
    │   ├── YES → Edge Function (Deno/TypeScript)
    │   │         - Stateless, scales to zero
    │   │         - Max 15s timeout, 150MB memory
    │   │
    │   └── NO → RPC in PostgreSQL
    │
    └── NO → Does it require heavy processing (AI, compliance evaluation)?
        ├── YES → NestJS service (Railway)
        │         - Persistent container
        │         - Long-running jobs via BullMQ
        │
        └── NO → Edge Function with event publishing
                  - Do the lightweight part in Edge Function
                  - Publish event to Redis for NestJS to handle the rest
```

## 6. How Should I Handle State?

```
Is this global app state (auth, theme, locale)?
├── YES → App-level provider in lib/app/providers/
│
└── NO → Is this feature-level data (list of tasks, member profile)?
    ├── YES → @riverpod provider with ref.cacheFor() TTL
    │         Put in lib/features/<feature>/presentation/providers/
    │
    └── NO → Is this UI-only state (selected tab, search query, filter)?
        ├── YES → @riverpod class-based notifier (local state)
        │
        └── NO → Is this form state (text fields, validation)?
            ├── YES → StatefulWidget with TextEditingControllers
            │
            └── NO → Ref.watch a computed provider
```

## 7. How Should I Handle Errors?

```
Is the error from Supabase (PostgrestException)?
├── YES → BaseRepository.handleException wraps it
│         Provider receives it as AsyncError
│         Widget shows ErrorDisplay widget
│
└── NO → Is the error from auth (AuthException)?
    ├── YES → BaseRepository.handleException wraps it
    │         Redirect to /login if session expired
    │
    └── NO → Is the error from Dio (NestJS)?
        ├── YES → Check DioException.type
        │         - connectionTimeout → show "Connection failed"
        │         - badResponse → parse error body
        │
        └── NO → Unexpected error → log and show generic message
```

---

*This decision tree is designed for AI agents. Follow it for every implementation decision.*
