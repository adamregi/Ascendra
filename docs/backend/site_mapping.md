# Ascendra Backend Site Mapping

This document provides a map of the backend directories, edge functions, database tables, views, RPC stored procedures, async background job queues, and the notification abstractions.

---

## 1. Directory Structure

```
distributor_os/
├── supabase/                    # Core Supabase Backend Config
│   ├── config.toml              # Local Supabase config (port, JWT, edge functions settings)
│   ├── seed.sql                 # Seed script for mock companies, profiles, and initial data
│   ├── verify_rules.sql         # Local SQL script to run schema audits
│   ├── functions/               # Supabase Edge Functions (Deno Runtime)
│   │   ├── _shared/             # Reusable modules (cors, supabaseClient, geminiClient)
│   │   ├── create-company/      # Atomic transaction for company + leader creation
│   │   ├── invite-member/       # Validates plan limit, creates profile & pending invitation
│   │   ├── accept-invitation/   # Verifies phone OTP, generates user, marks active
│   │   ├── ai-chat/             # Vector-RAG chatbot with Gemini & context logging
│   │   ├── schedule-meeting/    # Integrates with 100ms API to register room credentials
│   │   ├── restructure-tree/    # Moves downline members to a parent's upline node
│   │   └── ...                  # Other utility edge functions
│   └── migrations/              # SQL Migration Files (001_extensions.sql to 057_final_audit.sql)
```

---

## 2. API Routes & Edge Functions Map

All endpoints require a Bearer token (`Authorization: Bearer <jwt-token>`).

### Supabase Edge Functions (Lightweight Actions)
Hosted on: `https://<project-id>.supabase.co/functions/v1/<function-name>`

| Endpoint | Method | Request Payload | Description |
|---|---|---|---|
| `/create-company` | `POST` | `{ "company_name": "...", "slug": "slug", "leader_name": "...", "phone": "..." }` | Atomic creation of a tenant company and its root leader profile. |
| `/invite-member` | `POST` | `{ "full_name": "...", "phone": "+12345", "distributor_id": "D101" }` | Validates subscription limit, inserts `'invited'` profile & pending invitation. |
| `/accept-invitation` | `POST` | `{ "invitation_id": "uuid", "password": "...", "otp_code": "123456" }` | Validates invitation token, verifies phone OTP, updates profile to `'active'`. |
| `/schedule-meeting` | `POST` | `{ "title": "...", "agenda": "...", "scheduled_at": "timestamp" }` | Invokes 100ms API to create a room, writes to `meetings` table. |
| `/record-attendance` | `POST` | `{ "meeting_id": "uuid", "event_type": "join" }` | Webhook receiver. Writes to `attendance_events`, recalculates durations. |
| `/upload-document` | `POST` | FormData containing file upload | Uploads file to Supabase Storage bucket, triggers embedding generation. |

### NestJS API Gateway Routes (Heavy Actions)
Hosted on: `https://api.ascendra.io/v1/<route-name>`

| Endpoint | Method | Request Payload | Description |
|---|---|---|---|
| `/ai-chat` | `POST` | `{ "conversation_id": "uuid", "message": "What is rule A?" }` | Orchestrates RAG context lookup, queries Gemini, saves message, logs details. |
| `/search` | `GET` | `?q=query&type=all|members|meetings|tasks` | Unified search router querying full-text indexing schemas. |
| `/tasks/complete` | `POST` | `{ "task_id": "uuid", "proof_type": "screenshot", "file_url": "..." }` | Inserts `task_proofs`, fires trigger to set status to `'completed'`. |
| `/compliance/audit` | `POST` | `{ "profile_id": "uuid" }` | Performs background attendance audits. Inserts warnings or triggers escalation logs. |

---

## 3. Database Objects (PostgreSQL Map)

### Core Tables
- `companies`: The tenant organization root.
- `profiles`: System accounts with status lifecycles.
- `network_nodes`: Materialized path hierarchy representing management tree.
- `subscription_plans`: Catalogs Starter (50), Pro (100), and Enterprise (200) limits.
- `subscriptions`: Binds leaders to specific plans. Enforces a single active plan.
- `meetings`: Meeting records synced with 100ms rooms.
- `meeting_attendances`: Granular duration and join logs for compliance.
- `meeting_participants`: Multi-member attendance invitation registry.
- `attendance_events`: Raw stream of connect/disconnect activities.
- `tasks`: Operations assigned by leaders to members.
- `task_proofs`: Uploaded documents, text, or files verifying completion.
- `task_events`: Full history audit trail of tasks.
- `followups`: Automated and manual reminder callbacks.
- `compliance_rules`: Company-specific attendance frequency and durations requirements.
- `compliance_snapshots`: Periodical records evaluating member compliance.
- `compliance_violations`: Open, resolved, or escalated compliance issues.
- `termination_logs`: Audit trail for member terminations.
- `restructure_logs`: Audit logs tracking downline node migrations.
- `audit_logs`: Detailed tracking of CRUD operations with agent/IP info.
- `documents`: Storage paths for manuals, FAQs, and product sheets.
- `document_chunks`: Extracted text fragments with 768-dim vectors.
- `ai_conversations`: Grouped user-assistant threads.
- `ai_messages`: Messages in a conversation thread.
- `ai_context_logs`: Forensic database logs capturing prompts, RAG inputs, and parameters.
- `ai_usage_logs`: Token count log tracking costs and latency.
- `alert_rules`: Evaluated metric thresholds (e.g. `risk_score > 80`).
- `alerts`: Output intelligence items shown on dashboards.
- `alert_deliveries`: Delivery channels tracker.
- `alert_preferences`: Notification settings per user.
- `automation_logs`: Rule execution log of the Decision Engine.

### Materialized Views
- `mv_company_dashboard_stats`: Rolled up counts of active/warned members and meetings.
- `mv_member_progress`: Consolidated view of attendance and task completion rates.
- `mv_leadership_pipeline`: Leadership score and activity index tracking.
- `mv_growth_analytics`: Period-over-period performance metrics.
- `mv_recommendation_center`: Aggregated AI recommendations.

---

## 4. Stored Procedures & RPCs Map

| Function / RPC | Returns | Key Parameters | Purpose |
|---|---|---|---|
| `get_user_company_id()` | `UUID` | *None* | Fetches the company context of the currently logged-in profile. |
| `can_view_profile(viewer_id, target_id)` | `boolean` | `p_viewer_auth_id`, `p_target_profile_id` | Enforces permissions; returns true if in downline or same company. |
| `get_descendants(profile_id)` | `table` | `p_profile_id` | Returns table of all downline children recursively. |
| `get_ancestors(profile_id)` | `table` | `p_profile_id` | Returns table of all upline nodes recursively. |
| `create_company_atomic()` | `void` | `p_name`, `p_slug`, `p_leader_name`, `p_phone` | Solves circular profiles-companies insert dependency. |
| `terminate_member()` | `json` | `p_profile_id`, `p_leader_id`, `p_reason` | Executes termination, triggers downline tree restructuring. |
| `restructure_network_tree()` | `void` | `p_terminated_profile_id`, `p_new_parent_id` | Moves children to new parent, updates paths using `ltree`. |

---

## 5. Event Bus & Job Queues (Upstash Redis + BullMQ)

Async pipelines decouple synchronous API handlers from downstream side effects.

### BullMQ Queues
1. **`onboarding-queue`**:
   - Consumes `MemberInvited` event.
   - Triggers `NotificationService` to send SMS/OTP via Twilio.
2. **`meeting-evaluation-queue`**:
   - Consumes `MeetingEnded` event.
   - Evaluates attendance data, updates `mv_member_progress`, and triggers AI meeting summaries.
3. **`task-verification-queue`**:
   - Consumes `TaskCompleted` event.
   - Generates leaderboard updates and logs task events.
4. **`compliance-queue`**:
   - Consumes daily cron events.
   - Compares metrics against `compliance_rules` and triggers warnings.
5. **`alert-dispatch-queue`**:
   - Filters generated alerts against `alert_preferences`.
   - Routes delivery to FCM (push), Twilio (WhatsApp), and SendGrid (Email).

---

## 6. Unified Notification Wrapper (`NotificationService`)

Rather than letting individual modules call third-party endpoints directly, all communication is routed through a single NestJS module.

```
                  ┌───────────────────────┐
                  │  NotificationService  │
                  └──────────┬────────────┘
                             │
            ┌────────────────┼────────────────┐
            ▼                ▼                ▼
       ┌─────────┐      ┌─────────┐      ┌─────────┐
       │   FCM   │      │ Twilio  │      │SendGrid │
       └─────────┘      └─────────┘      └─────────┘
         (Push)         (WhatsApp)         (Email)
```
- **Preference Matching**: Automatically audits `alert_preferences` before sending alerts.
- **Failover Routing**: If a channel fails, the service falls back to alternative configured channels.
