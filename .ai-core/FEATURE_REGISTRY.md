# Feature Registry — Ascendra

> **Purpose**: A master registry tracking all feature modules in the application. AI agents must consult this registry before editing a feature to understand its boundaries and components.
> **Maintenance Note**: This document should be updated manually when a new feature is added or heavily refactored. The status of existing features should be updated as they progress through the Feature Lifecycle.

---

## 1. Authentication (`auth`)

- **Status**: Completed
- **Description**: Handles user login via Distributor ID, session management, and the initial splash screen routing logic.
- **Business Owner**: Platform Security Team
- **Technical Owner**: Backend Engineer / Flutter Engineer
- **Feature Folder**: `lib/features/auth/`
- **Providers**: `authProvider`, `bootstrapProvider`
- **Repositories**: `AuthRepository`
- **RPCs**: `resolve_distributor_login`
- **Edge Functions**: None
- **Database Objects**: `auth.users`, `profiles`
- **Shared Widgets**: None (uses core inputs)
- **Routes**: `/login`, `/splash`
- **Reference Screens**: `login.png`, `splash_screen.png`
- **Tests**: `test/features/auth/`
- **Dependencies**: None (Core feature)

## 2. Dashboard (`dashboard`)

- **Status**: Completed
- **Description**: The executive overview for leaders, displaying high-level KPIs and alerts.
- **Business Owner**: Leadership Experience Team
- **Technical Owner**: Flutter Engineer
- **Feature Folder**: `lib/features/dashboard/`
- **Providers**: `companyDashboardProvider`
- **Repositories**: `DashboardRepository`
- **RPCs**: `get_dashboard_view_model`
- **Edge Functions**: None
- **Database Objects**: `mv_company_dashboard_stats` (Materialized View)
- **Shared Widgets**: `KpiCard`
- **Routes**: `/dashboard`
- **Reference Screens**: `leader_home.png`
- **Tests**: `test/features/dashboard/`
- **Dependencies**: Metrics calculated by NestJS

## 3. Meetings (`meetings`)

- **Status**: Completed
- **Description**: Scheduling, live video conferencing via 100ms, attendance tracking, and replays.
- **Business Owner**: Core Product Team
- **Technical Owner**: Backend Engineer (Video Integration) / Flutter Engineer
- **Feature Folder**: `lib/features/meetings/`
- **Providers**: `meetingsListProvider`, `meetingDetailProvider`, `meetingReplayProvider`
- **Repositories**: `MeetingRepository`, `MeetingReplayRepository`
- **RPCs**: `get_meetings`, `get_meeting_detail`, `start_meeting`, `end_meeting`
- **Edge Functions**: `schedule-meeting`, `100ms-webhook`
- **Database Objects**: `meetings`, `meeting_sessions`, `meeting_attendance`
- **Shared Widgets**: `StatusBadge`
- **Routes**: `/meetings`, `/meetings/:id`, `/meetings/live/:id`, `/meetings/replay/:id`
- **Reference Screens**: `meetings_command_center.png`, `live_meeting.png`
- **Tests**: `test/features/meetings/`
- **Dependencies**: `100ms SDK`, `auth` (for current user)

## 4. Tasks (`tasks`)

- **Status**: Completed
- **Description**: Task assignment, proof submission (images, text), and leader approval workflow.
- **Business Owner**: Core Product Team
- **Technical Owner**: Flutter Engineer
- **Feature Folder**: `lib/features/tasks/`
- **Providers**: `tasksListProvider`, `taskDetailProvider`, `taskController`
- **Repositories**: `TaskRepository`
- **RPCs**: `get_tasks_view_model`, `get_task_detail`, `create_task_atomic`, `submit_task_proof`
- **Edge Functions**: None
- **Database Objects**: `tasks`, `task_assignments`, `task_proofs` (Storage), `task_followups`
- **Shared Widgets**: `TimelineEventWidget`, `StatusBadge`
- **Routes**: `/tasks`, `/tasks/:id`, `/tasks/create`, `/tasks/:id/followups`
- **Reference Screens**: `tasks_command_center.png`, `task_detail.png`
- **Tests**: `test/features/tasks/`
- **Dependencies**: Supabase Storage (for proofs)

## 5. Members (`members`)

- **Status**: Completed
- **Description**: The member directory, tree hierarchy, and the comprehensive Member Profile (Tabbed View).
- **Business Owner**: Leadership Experience Team
- **Technical Owner**: Flutter Engineer
- **Feature Folder**: `lib/features/members/`
- **Providers**: `memberDirectoryProvider`, `memberProfileProvider`, `searchQueryProvider`
- **Repositories**: `MemberRepository`, `NetworkRepository`
- **RPCs**: `get_member_directory`, `get_member_profile_view_model`, `get_descendants`, `restructure_network_tree`
- **Edge Functions**: None
- **Database Objects**: `profiles`, `network_nodes` (`ltree`)
- **Shared Widgets**: `AppAvatar`, `SectionHeader`
- **Routes**: `/members`, `/members/:id`, `/network`
- **Reference Screens**: `team_leadership.png`, `profile_command_center.png`
- **Tests**: `test/features/members/`
- **Dependencies**: Aggregates data from `tasks`, `meetings`, and `compliance` via the RPC.

## 6. AI Assistant (`ai`)

- **Status**: Completed
- **Description**: The RAG-powered executive coach interface.
- **Business Owner**: AI Integration Team
- **Technical Owner**: Backend Engineer (NestJS/Gemini) / Flutter Engineer
- **Feature Folder**: `lib/features/ai/`
- **Providers**: `aiChatProvider`
- **Repositories**: `AiRepository`
- **RPCs**: None (Calls NestJS REST API directly)
- **Edge Functions**: None
- **Database Objects**: `ai_conversations`, `ai_messages`
- **Shared Widgets**: None
- **Routes**: `/ai`
- **Reference Screens**: `executive_coach.png`
- **Tests**: `test/features/ai/`
- **Dependencies**: NestJS backend, Google Gemini

---

*Note: For a complete list of all features, refer to the `lib/features/` directory.*
