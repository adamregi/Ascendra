# Ascendra Detailed Backend Engineering Notes

This document provides detailed explanations of key architectural components, technical decisions, database logic, and operational strategies in the Ascendra backend.

---

## 1. Multi-Tenant Isolation Strategy (RLS)

Every database record in Ascendra belongs to a specific company, identified by `company_id`. To prevent cross-tenant data leaks, PostgreSQL Row-Level Security (RLS) is enabled on all public tables.

### Tenant Context Lookup
Instead of relying on the client to pass the tenant ID (which can be manipulated), the database retrieves the tenant ID securely using the `get_user_company_id()` function:

```sql
create or replace function public.get_user_company_id()
returns uuid
language sql
stable
security definer
set search_path = public
as $$
  select company_id from public.profiles
  where auth_user_id = auth.uid()
  limit 1;
$$;
```

### RLS Implementation Example
Here is how policies are applied to tables like `tasks` or `meetings`:

```sql
alter table public.tasks enable row level security;

create policy "Users can view tasks in their company"
  on public.tasks
  for select
  using (company_id = public.get_user_company_id());

create policy "Leaders can insert tasks in their company"
  on public.tasks
  for insert
  with check (
    company_id = public.get_user_company_id() 
    and exists (
      select 1 from public.profiles 
      where id = auth.uid() and role = 'leader'
    )
  );
```

---

## 2. Business Logic Boundaries: SQL vs. NestJS

In production environments, placing complex, evolving business logic inside SQL triggers and stored procedures creates deployment coupling and scaling issues. Ascendra separates data layer constraints from application logic.

### PostgreSQL (Data Guard & Repository)
PostgreSQL handles data integrity, RLS, and atomic constraints.
- **Validations**: Ensuring that subscriptions are only owned by leaders, checking phone number uniqueness, and preventing network loops.
- **Atomic Operations**: Creating a company and its leader profile in a single transactional block using deferred foreign keys.

### NestJS (Application Server & Orchestration)
All business workflows, third-party integrations, and logic rules are managed by NestJS.
- **Compliance Rules**: Running daily compliance score calculations against metrics.
- **AI Orchestration**: Generating search vector queries, managing Gemini context assembly, and parsing outputs.
- **Decision Engine**: Processing metric updates to trigger warnings and suspensions.

---

## 3. Materialized View Refresh Strategy

Ascendra balances dashboard response times with data freshness by using materialized views (`mv_company_dashboard_stats`, `mv_member_progress`, `mv_growth_analytics`).

### Refresh Policies
1. **Asynchronous Event-Driven Refresh**:
   - Materialized views are not updated directly by SQL triggers. Instead, actions like completing a task or ending a meeting publish a domain event (`MeetingEnded`, `TaskCompleted`) to the event bus.
   - The queue worker in NestJS executes a throttled database command to refresh the specific materialized view:
     ```sql
     refresh materialized view concurrently public.mv_member_progress;
     ```
2. **Scheduled Interval Refresh**:
   - Heavy views, such as `mv_growth_analytics`, refresh on a scheduled interval (e.g., every 30 minutes) managed by NestJS cron jobs.
3. **Optimistic UI Caching**:
   - The Flutter client applies optimistic UI updates to the local state to ensure the app feels fast, while the background refresh ensures the database states align within seconds.

---

## 4. Unified Search Strategy

To let users search across members, meetings, tasks, and documents efficiently, the backend uses a unified query layer.

### Implementation
1. **PostgreSQL Full-Text Search (`tsvector`)**:
   - Columns containing searchable text (e.g., profile names, meeting agendas, task descriptions, and document contents) are mapped to a generated `tsvector` column.
   - The column is indexed using a **GIN** index for fast matching:
     ```sql
     alter table public.documents 
       add column search_vector tsvector 
       generated always as (to_tsvector('english', coalesce(title, '') || ' ' || coalesce(raw_text, ''))) stored;

     create index documents_search_idx on public.documents using gin(search_vector);
     ```
2. **Trigram Indexing (`pg_trgm`)**:
   - For short string columns (like member names, phone numbers, and distributor IDs) where users type partial matches, trigram indexes enable fast matching:
     ```sql
     create index profiles_name_trgm_idx on public.profiles using gin (full_name gin_trgm_ops);
     ```
3. **Unified Search Router**:
   - The NestJS `/search` endpoint parses search terms and queries the indexed columns, returning a consolidated JSON response containing matched categories.

---

## 5. Hierarchical Downline Traversal (`ltree`)

Managing an MLM network requires traversing deep hierarchy trees (which can exceed 100,000 users). Adjacency lists (using recursive CTEs) can become slow at scale. To solve this, Ascendra uses the PostgreSQL `ltree` extension to store materialized paths.

### Materialized Path Formatting
PostgreSQL's `ltree` label path supports alphanumeric characters and underscores, but not hyphens. Since Ascendra uses UUIDv4 keys, hyphens must be replaced with underscores:

```sql
-- path string: "c7b509be-a1c1-460d-9b51-096d4fb08c11.d3319084-25e2-452f-b4ba-ce9f3957ee0f"
-- path_ltree generated: "c7b509be_a1c1_460d_9b51_096d4fb08c11.d3319084_25e2_452f_b4ba_ce9f3957ee0f"
path_ltree extensions.ltree generated always as (replace(path, '-', '_')::extensions.ltree) stored;
```

---

## 6. Observability & Telemetry Framework

To maintain service quality and catch performance regressions before they affect users, we log telemetry at key operational checkpoints:

```
[Flutter Client] 
     │ (Edge / Network round-trip latency)
     ▼
[Edge Gateway] ──(Publish queue time)──► [BullMQ / Redis] ──(Execution time)──► [NestJS Server]
     │                                                                                │
     ├─► 100ms Webhook delay                                                          ├─► AI response time
     └─► RPC query latency                                                            └─► Database write speed
```

1. **RPC & DB Latency**: Custom middleware logs DB execution query times. Database queries taking longer than 250ms trigger warning alerts.
2. **AI Latency**: Every call to Gemini logs API latency in `ai_usage_logs` and `ai_context_logs` to isolate model response times from application processing.
3. **Queue Wait Times**: BullMQ metrics monitor how long jobs wait in the queue before processing.
