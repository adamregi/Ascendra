# Database Schema Guide — Ascendra

> **Purpose**: A reference map for the core database tables and their relationships.
> Note: For the full 1,200+ line schema dump, refer to `database.md` in the project root.

---

## 1. Core Tables

### `companies`
The top-level tenant entity.
- `id` (UUID, PK)
- `name` (TEXT)
- `plan_tier` (TEXT: starter, pro, enterprise)

### `profiles`
The user profile. Links exactly 1:1 with `auth.users`.
- `id` (UUID, PK, references `auth.users.id`)
- `company_id` (UUID, FK)
- `first_name` (TEXT)
- `last_name` (TEXT)
- `role` (TEXT: leader, member)
- `status` (TEXT: invited, active, warned, suspended, terminated)

### `network_nodes`
The MLM tree representation using `ltree`. Exactly 1:1 with `profiles`.
- `profile_id` (UUID, PK, references `profiles.id`)
- `company_id` (UUID, FK)
- `sponsor_id` (UUID, FK)
- `path` (LTREE) — e.g., `ROOT.D001.D005`
- `level` (INT)

### `invitations`
Pending invites to join the platform.
- `id` (UUID, PK)
- `company_id` (UUID, FK)
- `sponsor_id` (UUID, FK)
- `phone_number` (TEXT)
- `status` (TEXT: pending, accepted, cancelled, expired)

## 2. Feature Tables

### Meetings Module
- `meetings`: The scheduled meeting event.
- `meeting_sessions`: A specific occurrence of a meeting (100ms room instance).
- `meeting_attendance`: Join/leave timestamps for members.

### Tasks Module
- `tasks`: The task definition (title, description, points).
- `task_assignments`: Link between task and profile. Status tracking.
- `task_proofs`: References to Storage objects proving completion.
- `task_followups`: Reminders sent by leaders.

### Compliance Module
- `compliance_rules`: Company-specific scoring thresholds.
- `compliance_snapshots`: Daily calculated scores per member.
- `compliance_violations`: Specific infractions (e.g., missed meeting).

### Knowledge & AI Module
- `knowledge_documents`: Uploaded PDFs/text files.
- `knowledge_chunks`: `pgvector` embeddings for RAG.
- `ai_conversations`: Chat sessions.
- `ai_messages`: Individual messages within a session.

## 3. Materialized Views

Used for fast dashboard analytics. Refreshed asynchronously by NestJS.

- `mv_company_dashboard_stats`: High-level company KPIs.
- `mv_member_progress`: Individual compliance/task velocity.
- `mv_leadership_pipeline`: Scores identifying potential leaders.
- `mv_growth_analytics`: Period-over-period active member counts.

## 4. Key Relationships & Constraints

- A user's `company_id` is immutable once set.
- Deleting a `profile` cascades to almost all feature tables (tasks, attendance).
- `network_nodes` restructuring uses a deferred constraint during atomic operations to prevent FK violations while moving subtrees.
