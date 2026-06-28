# ADR 007: Materialized View Refresh Strategy & Telemetry

## Status
Accepted

## Context
Ascendra's dashboard analytics rely on materialized views (`mv_member_progress`, `mv_company_dashboard_stats`, `mv_growth_analytics`, etc.) to keep query latencies low. 

However, materialized views do not auto-update when their source tables change. We need a way to refresh them concurrently without blocking read access, causing request timeouts, or introducing complex dependencies in database triggers. Additionally, we need to monitor view staleness and refresh overhead.

## Decision
We decided to implement a centralized **Materialized View Refresh Strategy and Telemetry** layer in the database, with refreshes orchestrated asynchronously by the application server (NestJS).

1. **Strategy Catalog (`mv_refresh_logs`)**: We created a database table to register all materialized views, their refresh policies (e.g. event-driven, 5 min, 30 min, hourly), and their execution status.
2. **Tracked execution wrapper (`refresh_materialized_view_tracked()`)**: Created a `security definer` RPC function to:
   - Handle the `REFRESH MATERIALIZED VIEW CONCURRENTLY` SQL command safely.
   - Profile the exact execution duration in milliseconds.
   - Record the timestamp, success status, and error details in `mv_refresh_logs`.
3. **Decoupled Orchestration**:
   - **Event-driven views** (e.g., `mv_member_progress`) are refreshed by NestJS queue workers when they process events like `TaskCompleted` or `MeetingEnded`.
   - **Time-scheduled views** (e.g., `mv_growth_analytics` and `mv_recommendation_center`) are refreshed on a cron interval by NestJS scheduled tasks.
   - The database triggers are kept lightweight, focusing solely on data operations.

## Consequences

### Positive Impacts
- **Operational Playbook**: The `mv_refresh_logs` catalog serves as a clear operational overview of the refresh frequencies.
- **Traceable Latency Metrics**: Logging refresh durations helps identify performance issues and index deficiencies.
- **Concurrency Protection**: Running refreshes concurrently prevents database read locks, allowing the Flutter client to load dashboards while updates are in progress.

### Trade-offs & Cons
- **Write and CPU spikes**: Running concurrent refreshes is resource-intensive. If multiple refreshes run at the same time, it can cause CPU spikes.
- **Data Staleness**: Dashboard data is only as fresh as the last refresh run. Clients must be designed to handle data that is slightly out of sync.
