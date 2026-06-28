# Module Contracts — Ascendra

> **Purpose**: Explicitly defines the boundaries, inputs, outputs, and dependencies for every feature module. AI agents must respect these contracts and flag any breaking changes.

---

## 1. Dashboard Module (`dashboard`)

- **Responsibilities**: Displaying the executive overview and KPIs.
- **Inputs**: `company_id` (from Auth session).
- **Outputs**: `DashboardViewModel` (Freezed JSON).
- **Providers**: `companyDashboardProvider`.
- **Repositories**: `DashboardRepository`.
- **RPCs**: `get_dashboard_view_model`.
- **Events**: None (Read-only).
- **Dependencies**: Relies on `mv_company_dashboard_stats` being refreshed by NestJS.
- **Breaking-change considerations**: Adding a new KPI requires updating the Materialized View, the RPC, the Freezed model, and the UI.

## 2. Tasks Module (`tasks`)

- **Responsibilities**: Task assignment, proof upload, and review.
- **Inputs**: `task_id`, `proof_url`, `text_content`.
- **Outputs**: `TaskViewModel`, `TaskDetailModel`.
- **Providers**: `tasksListProvider`, `taskDetailProvider`, `taskController`.
- **Repositories**: `TaskRepository`.
- **RPCs**: `get_tasks_view_model`, `submit_task_proof`.
- **Events**: Emits `TaskProofSubmitted` to Redis.
- **Dependencies**: Supabase Storage (Proofs bucket).
- **Breaking-change considerations**: Changing proof upload logic requires migrating existing `proof_url` strings in the DB.

## 3. Meetings Module (`meetings`)

- **Responsibilities**: Scheduling, 100ms video integration, attendance.
- **Inputs**: `meeting_id`, `100ms_token`.
- **Outputs**: `MeetingViewModel`, `MeetingReplayModel`.
- **Providers**: `meetingDetailProvider`, `meetingReplayProvider`.
- **Repositories**: `MeetingRepository`, `MeetingReplayRepository`.
- **RPCs**: `start_meeting`, `end_meeting`.
- **Events**: Receives `100ms-webhook` events (joined, left, ended).
- **Dependencies**: 100ms SDK, Edge Functions.
- **Breaking-change considerations**: Altering webhook handling can corrupt compliance attendance scores.

## 4. Members Module (`members`)

- **Responsibilities**: Directory browsing, MLM tree rendering, Profiles.
- **Inputs**: `profile_id`.
- **Outputs**: `MemberProfileViewModel`.
- **Providers**: `memberDirectoryProvider`, `memberProfileProvider`.
- **Repositories**: `MemberRepository`, `NetworkRepository`.
- **RPCs**: `get_member_profile_view_model`, `get_descendants`.
- **Events**: Emits `MemberTerminated` to Redis (triggers tree restructure).
- **Dependencies**: Requires `ltree` extension.
- **Breaking-change considerations**: Restructuring the `ltree` path is highly expensive and must be done asynchronously via NestJS.
