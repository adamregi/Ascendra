# ADR 003: Dashboard Analytics via Materialized Views and RPCs

## Status
Accepted

## Context
The leader dashboard requires real-time aggregate statistics, including the number of active/warned members, meeting attendance rates, task completion percentages, and compliance warning flags. 

Calculating these metrics on demand by joining and querying transactional tables (`profiles`, `meetings`, `meeting_attendances`, and `tasks`) on every dashboard request would slow down performance at scale. We need a way to serve these metrics quickly without overloading the database.

## Decision
We decided to pre-aggregate analytics using PostgreSQL **Materialized Views** and expose them to the Flutter client through dedicated **RPC stored procedures** (e.g. `get_executive_brief_data`).

1. **Materialized Aggregations**: Created views like `mv_company_dashboard_stats` and `mv_member_progress` to consolidate metrics, grouping them by company and user profiles.
2. **Indexing**: Added unique indexes to each materialized view to allow concurrent refreshes:
   ```sql
   create unique index mv_company_dashboard_stats_company_idx on public.mv_company_dashboard_stats (company_id);
   ```
3. **Decoupled Refresh Strategy**: Rather than refreshing views directly on database write triggers, refreshes are triggered asynchronously by NestJS workers when relevant domain events (`MeetingEnded`, `TaskCompleted`) are processed.
4. **RPC Interface**: The Flutter client calls a single RPC function, which queries the indexed materialized views and returns a consolidated JSON payload in a single network round-trip.

## Consequences

### Positive Impacts
- **Fast Response Times**: Dashboard queries return instantly because the database reads pre-computed rows from disk instead of calculating aggregates on the fly.
- **Reduced DB Load**: Minimizes query traffic on core transactional tables, preventing database locks during peak usage.
- **Reduced Client Overhead**: The client retrieves all dashboard data through a single API request, reducing network round-trips.

### Trade-offs & Cons
- **Data Latency (Staleness)**: Dashboard metrics may be slightly out of sync (delayed by seconds or minutes) while waiting for the background queue worker to refresh the materialized view.
- **Concurrent Refresh Overhead**: Refreshing a materialized view concurrently requires temporary tablespace and CPU resources, which can impact performance if multiple refreshes run at the same time.
- **Index Maintenance**: Schema changes in target tables require recreating the materialized views and their unique indexes.
