# Maintenance Guide — Ascendra

> **Purpose**: Standard operating procedures for ongoing project maintenance, dependency updates, and environment health.

---

## 1. Dependency Management

Ascendra uses `pubspec.yaml` for Flutter dependencies and `package.json` for Edge Functions/NestJS.

### Flutter Dependencies
- **Rule**: Do not use `^` (caret) for major version bumps of critical dependencies (e.g., `flutter_riverpod`, `supabase_flutter`). Lock them to specific versions unless an upgrade is explicitly planned and tested.
- **Routine Updates**: Run `flutter pub outdated` monthly.
- **Upgrading**:
  1. Create a `chore/dependency-updates` branch.
  2. Run `flutter pub upgrade`.
  3. Run `flutter analyze` to check for deprecation warnings.
  4. Run the full test suite.

### Code Generation Maintenance
If `build_runner` starts failing or generating invalid code:
1. Run `flutter clean`
2. Run `flutter pub get`
3. Run `dart run build_runner clean`
4. Run `dart run build_runner build -d`

## 2. Database Maintenance

### Vacuuming
PostgreSQL handles vacuuming automatically, but for tables with high churn (like `task_assignments` or `meeting_attendance`), monitor table bloat.

### Materialized View Optimization
The concurrent refresh of materialized views requires a unique index. Ensure `mv_company_dashboard_stats` has `CREATE UNIQUE INDEX on mv_company_dashboard_stats (company_id);`.
If the refresh becomes slow, consider partitioning the underlying tables by `company_id` or date.

### pgvector Maintenance
As the `knowledge_chunks` table grows, vector similarity searches (HNSW or IVFFlat indexes) require re-indexing to maintain performance. Re-index during low-traffic windows.

## 3. Monitoring & Alerts

### Sentry (Crashlytics)
- Ensure all unhandled Flutter exceptions are caught in `main.dart` and sent to Sentry.
- Monitor for "OOM" (Out of Memory) crashes, which often indicate un-disposed Riverpod streams or un-cached images.

### NestJS / BullMQ
- Monitor the Redis queue for stalled or failed jobs.
- The `TaskCompleted` events are critical for compliance scoring; if the queue backs up, scores will be inaccurate.
