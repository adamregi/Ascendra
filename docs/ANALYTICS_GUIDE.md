# Analytics & Dashboards Guide — Ascendra

> **Purpose**: Describes how metrics and KPIs are aggregated and served to the Flutter client without locking the database.

---

## 1. The Core Rule

**Flutter NEVER computes aggregates.**

```
❌ PROHIBITED (in Flutter):
final totalTasks = tasks.length;
final completedTasks = tasks.where((t) => t.status == 'completed').length;
final completionRate = completedTasks / totalTasks;
```

This approach fails when a company has 10,000 tasks, as it requires pulling all of them to the client just to get a single percentage.

## 2. Materialized Views

Instead of calculating metrics on the fly for every request, Ascendra uses PostgreSQL **Materialized Views**.

A materialized view stores the result of a complex query (joins, sums, averages) on disk. Reading from it is as fast as reading from a standard table.

### Key Views
- `mv_company_dashboard_stats`: High-level metrics for the Executive Dashboard.
- `mv_member_progress`: Individual velocity metrics.
- `mv_leadership_pipeline`: Scores identifying rising stars.

## 3. The Refresh Strategy

Materialized views must be refreshed to show new data. If we trigger a refresh synchronously on every database write (via SQL triggers), the database will lock up under heavy load.

**Ascendra uses an asynchronous, event-driven refresh strategy:**

1. A member completes a task (writes to `task_assignments`).
2. An event is published to Upstash Redis.
3. A NestJS worker picks up the event.
4. The worker executes `REFRESH MATERIALIZED VIEW CONCURRENTLY mv_company_dashboard_stats`.

By using `CONCURRENTLY`, reads from the dashboard are never blocked while the view is updating.

## 4. Flutter Integration

The Flutter dashboard simply calls an RPC that reads the materialized view.

```dart
// The RPC
create function get_dashboard_view_model() returns json ...
  select json_build_object('total_members', total_members, ...)
  from mv_company_dashboard_stats
  where company_id = get_user_company_id();

// The Flutter Provider
@riverpod
Future<DashboardModel> companyDashboard(Ref ref) async {
  ref.cacheFor(const Duration(minutes: 5));
  return ref.watch(dashboardRepositoryProvider).getDashboardStats();
}
```

Because the data is pre-aggregated and cached via Riverpod, the dashboard loads instantly.
