# Ascendra Business Logic Ownership Map

This document classifies every SQL RPC function by its **long-term owner** — the layer that should contain the logic as the system matures. This is a living document that guides the gradual migration of evolving business rules out of PostgreSQL and into the NestJS application layer.

---

## Classification Criteria

| Owner | Criteria | Examples |
|---|---|---|
| **SQL (Keep)** | Atomic transactions, circular FK resolution, tree traversal, data integrity, security helpers, vector search | `create_company_atomic`, `get_descendants` |
| **NestJS (Migrate)** | Evolving business policies, multi-step evaluation loops, score calculations, rules that change with product iterations | `evaluate_compliance`, `run_decision_engine` |
| **Hybrid (SQL thin + NestJS orchestration)** | RPCs that mix data writes with side effects (notifications, audit logs). SQL handles the atomic write; NestJS handles the side effects. | `terminate_member`, `assign_task_members` |

---

## SQL — Keep in PostgreSQL

These functions are tightly coupled to data integrity, use transactional guarantees, or perform tree/vector operations that are most efficient at the database level.

| Function | File | Reason to Keep |
|---|---|---|
| `get_user_company_id()` | [028_helper_functions.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/028_helper_functions.sql#L13) | Security helper. Used by every RLS policy. Must stay in SQL. |
| `can_view_profile()` | [028_helper_functions.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/028_helper_functions.sql#L28) | Permission check using `ltree` operators. Index-backed, fast. |
| `get_descendants()` | [028_helper_functions.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/028_helper_functions.sql#L53) | Recursive CTE for tree traversal. Core data operation. |
| `get_ancestors()` | [028_helper_functions.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/028_helper_functions.sql#L85) | Recursive CTE for upline resolution. |
| `calculate_subtree_size()` | [028_helper_functions.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/028_helper_functions.sql#L120) | Simple wrapper over `get_descendants`. |
| `_rebuild_subtree_paths()` | [028_helper_functions.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/028_helper_functions.sql#L142) | Internal path rebuilder. Called during restructuring. |
| `restructure_network_tree()` | [028_helper_functions.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/028_helper_functions.sql#L188) | Atomic tree restructuring with row-level locks, path recalculation, and audit logging. Must be transactional. |
| `create_company_atomic()` | [028_helper_functions.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/028_helper_functions.sql#L322) | Solves circular FK dependency with deferred constraints. Cannot run outside a DB transaction. |
| `match_document_chunks()` | [028_helper_functions.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/028_helper_functions.sql#L406) | pgvector cosine similarity search. Must run in DB. |
| `create_invitation_atomic()` | [030_auth_invitation_rpcs.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/030_auth_invitation_rpcs.sql#L19) | Atomic profile + invitation insert with uniqueness checks. |
| `accept_invitation_atomic()` | [030_auth_invitation_rpcs.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/030_auth_invitation_rpcs.sql#L81) | Atomic invitation acceptance + network node creation + auth linking. |
| `cancel_invitation_atomic()` | [030_auth_invitation_rpcs.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/030_auth_invitation_rpcs.sql#L171) | Simple cascading delete. |
| `resolve_distributor_login()` | [030_auth_invitation_rpcs.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/030_auth_invitation_rpcs.sql#L6) | Auth lookup. Must be `security definer` in SQL. |
| `get_leader_plan_usage()` | [030_auth_invitation_rpcs.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/030_auth_invitation_rpcs.sql#L187) | Complex ltree query for plan usage calculation. Efficient in SQL. |
| `start_meeting()` | [028_helper_functions.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/028_helper_functions.sql#L651) | Atomic status transition with row lock. Simple enough to stay. |
| `end_meeting()` | [028_helper_functions.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/028_helper_functions.sql#L691) | Atomic status transition with row lock. |
| `join_meeting_session()` | [028_helper_functions.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/028_helper_functions.sql#L731) | Capacity check + idempotent session creation. Transactional. |
| `leave_meeting_session()` | [028_helper_functions.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/028_helper_functions.sql#L821) | Simple timestamp update. |
| `route_skill()` | [032_ai_skill_routes.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/032_ai_skill_routes.sql) | Pattern matching against company-specific skill routes. Read-only, fast. |
| `set_updated_at()` | [027_triggers.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/027_triggers.sql) | Trigger function. Must stay in SQL. |
| `validate_subscription_leader()` | [027_triggers.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/027_triggers.sql) | Cross-table constraint validation. Must stay in SQL. |
| `validate_network_node_company()` | [027_triggers.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/027_triggers.sql) | Cross-table constraint validation. Must stay in SQL. |

---

## NestJS — Migrate When Workers Exist

These functions contain evolving business rules, multi-step evaluation loops, or score calculations that will change as the product iterates. They should move into NestJS services.

| Function | File | Migration Rationale |
|---|---|---|
| `evaluate_compliance()` | [028_helper_functions.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/028_helper_functions.sql#L1228) | 200+ lines of nested loops evaluating 4 rule types (attendance, overdue tasks, inactive days, followups). Business rules will change frequently. Hard to unit test in SQL. |
| `run_decision_engine()` | [053_f9_decision_engine.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/053_f9_decision_engine.sql#L6) | Rule evaluation loop with metric-specific branching. Adding new rule types requires SQL migration. NestJS allows hot-reloading rule logic. |
| `create_compliance_snapshot()` | [028_helper_functions.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/028_helper_functions.sql#L1610) | Score weighting formula (50% attendance, 30% tasks, 20% followups) will evolve. Application-layer concern. |
| `sync_overdue_assignments()` | [028_helper_functions.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/028_helper_functions.sql#L1123) | Cron-driven batch status update. Better as a NestJS scheduled job. |
| `warn_member()` | [028_helper_functions.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/028_helper_functions.sql#L1517) | Status transition that should trigger notifications via a service, not just a DB write. |
| `suspend_member()` | [028_helper_functions.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/028_helper_functions.sql#L1534) | Same rationale as `warn_member`. |

> [!NOTE]
> **Migration strategy**: When NestJS is ready, each function here gets replaced by a thin SQL wrapper that only performs the atomic data write, while the NestJS service handles the evaluation logic, scoring, and side effects. The existing Flutter client continues calling the same RPC names — the implementation changes, not the interface.

---

## Hybrid — SQL Writes + NestJS Side Effects

These functions currently mix atomic data mutations with side effects like inserting notifications or audit logs. The data write stays in SQL; the notification/audit dispatch moves to NestJS.

| Function | File | What Stays in SQL | What Moves to NestJS |
|---|---|---|---|
| `terminate_member()` | [028_helper_functions.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/028_helper_functions.sql#L1551) | Profile status update, termination log, tree restructure call | Cancelling tasks, reassigning followups, notification dispatch |
| `assign_task_members()` | [028_helper_functions.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/028_helper_functions.sql#L925) | Task assignment insert, conflict handling | Notification creation, status transition to 'assigned' |
| `review_task_assignment()` | [028_helper_functions.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/028_helper_functions.sql#L1048) | Assignment status update, review comment | Notification to member, task completion check |
| `create_followup()` | [028_helper_functions.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/028_helper_functions.sql#L1147) | Followup row insert | Notification to member |
| `acknowledge_violation()` | [028_helper_functions.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/028_helper_functions.sql#L1469) | Violation status update | Audit log entry (future) |

---

## Sync Triggers — Keep in SQL

Document sync triggers that mirror content into the `documents` table for RAG indexing. These are data transformations, not business logic.

| Trigger | Source Table | Purpose |
|---|---|---|
| `sync_product_insert_update` | `products` | Mirrors product name/description into `documents` for vector search |
| `sync_product_faq_insert_update` | `product_faqs` | Mirrors FAQ Q&A into `documents` |
| `sync_success_story_insert_update` | `success_stories` | Mirrors stories into `documents` |

These stay in SQL because they maintain data consistency between source tables and the RAG knowledge base.

---

## Standard CRUD — Use PostgREST Directly

These operations do not need RPCs. The Flutter client can use the Supabase client's standard `.from().select()` / `.insert()` / `.update()` methods, protected by RLS.

| Operation | Table | Notes |
|---|---|---|
| List members | `profiles` | RLS filters by `company_id`. Use `.select()` with filters. |
| View meeting details | `meetings` | Direct select with RLS. |
| List notifications | `notifications` | Direct select, ordered by `created_at DESC`. |
| Mark notification read | `notifications` | Direct `.update({ read_at: now() })`. |
| List documents | `documents` | Direct select with category filter. |
| List AI conversations | `ai_conversations` | Direct select, ordered by `updated_at DESC`. |
| View AI messages | `ai_messages` | Direct select by `conversation_id`. |
| Update profile | `profiles` | Direct update (RLS restricts to own profile). |
