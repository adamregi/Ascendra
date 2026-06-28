# Migration & Refactoring Guide — Ascendra

> **Purpose**: Safe procedures for executing heavy refactoring tasks without breaking the application or corrupting data.

---

## 1. Renaming an RPC

You cannot simply "rename" an RPC in PostgreSQL. You must drop the old one and create the new one, but this requires coordination with the Flutter client to prevent downtime during deployment.

### The Safe Process:
1. **Migration 1 (Database)**: Create a new migration that creates the *new* RPC. Do NOT drop the old one yet.
2. **Deploy DB**: Push the database migration to Production. (Now both RPCs exist).
3. **Update Client (Flutter)**: Update the Flutter Repository to call the *new* RPC name.
4. **Deploy Client**: Release the new Flutter app to the App Store/Play Store.
5. **Wait**: Wait for adoption (usually 2-4 weeks).
6. **Migration 2 (Database)**: Create a new migration that drops the *old* RPC (`DROP FUNCTION ...`).

## 2. Renaming a Riverpod Provider

Renaming a provider in Flutter is safer since it's compiled, but you must ensure you clean up the generated files.

1. Rename the function/class annotated with `@riverpod`.
2. Delete the old `.g.dart` file manually.
3. Run `dart run build_runner build -d`.
4. Run a global Search & Replace for the old provider name across the `lib/` directory.

## 3. Extracting a Shared Widget

If you notice a widget in `lib/features/tasks/presentation/widgets/` is being used in `meetings/` as well, it should be moved to `lib/shared/widgets/`.

### The Safe Process:
1. Move the file from the feature folder to `lib/shared/widgets/`.
2. Rename the class if necessary to be more generic (e.g., `TaskStatusBadge` -> `StatusBadge`).
3. Remove any feature-specific data models from its constructor. It should only accept primitive types (Strings, Colors, Enums).
4. Fix all import paths globally.
5. Run `flutter analyze` to ensure no orphaned imports remain.

## 4. Deprecating an API

If a column or RPC is no longer needed:
1. Do not delete it immediately.
2. If it's a column, mark it as nullable and remove it from Flutter's Freezed models.
3. If it's an RPC, add a comment `-- DEPRECATED: Use <new_rpc> instead`.
4. Wait for the client adoption cycle to complete before issuing the `DROP` migration.

## 5. Archiving Migrations

Over time, `supabase/migrations/` will grow massively.
- Do NOT delete old migrations.
- If the local startup time (`supabase start`) becomes too slow, you can squash migrations using `supabase db squash`. This combines all migrations up to a certain point into a single `00000000000000_init.sql` file.
