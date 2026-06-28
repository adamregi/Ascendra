# Screen Catalog — Ascendra

> **Purpose**: A comprehensive directory of all screens in Ascendra, mapping routes to features, UI references, and primary data sources.

---

## 1. Authentication & Onboarding

| Screen | Route | Feature | Reference Asset | Primary Data Source |
|--------|-------|---------|-----------------|---------------------|
| Splash | `/splash` | `auth` | `splash_screen` | `bootstrapProvider` |
| Login | `/login` | `auth` | `login` | `AuthRepository` |
| Join Team | `/join/:id` | `invitations` | `join_team` | `InvitationRepository` |

## 2. Dashboard

| Screen | Route | Feature | Reference Asset | Primary Data Source |
|--------|-------|---------|-----------------|---------------------|
| Leader Home | `/dashboard` | `dashboard` | `leader_home` | `get_dashboard_view_model()` |

## 3. Meetings

| Screen | Route | Feature | Reference Asset | Primary Data Source |
|--------|-------|---------|-----------------|---------------------|
| Command Center | `/meetings` | `meetings` | `meetings_command_center` | `get_meetings()` |
| Schedule | `/meetings/schedule` | `meetings` | `schedule_meeting` | `schedule_meeting` (Edge Function) |
| Detail | `/meetings/:id` | `meetings` | `meeting_detail` | `get_meeting_detail()` |
| Live Room | `/meetings/live/:id` | `meetings` | `live_meeting` | 100ms SDK |
| Replay | `/meetings/replay/:id` | `meetings` | `meeting_replay` | `get_meeting_replay_view_model()` |
| Ended Summary | `/meetings/summary/:id` | `meetings` | `meeting_ended_summary` | `get_meeting_summary()` |

## 4. Tasks

| Screen | Route | Feature | Reference Asset | Primary Data Source |
|--------|-------|---------|-----------------|---------------------|
| Command Center | `/tasks` | `tasks` | `tasks_command_center` | `get_tasks_view_model()` |
| Detail / Proof | `/tasks/:id` | `tasks` | `task_detail` | `get_task_detail()` |
| Campaign Builder | `/tasks/create` | `tasks` | `campaign_builder` | `create_task_atomic()` |
| Followups | `/tasks/:id/followups` | `tasks` | `followups_center` | `get_task_followups()` |

## 5. Members & Network

| Screen | Route | Feature | Reference Asset | Primary Data Source |
|--------|-------|---------|-----------------|---------------------|
| Directory | `/members` | `members` | `team_leadership` | `get_member_directory()` |
| Profile | `/members/:id` | `members` | `profile_command_center` | `get_member_profile_view_model()` |
| Genealogy | `/network` | `members` | `genealogy_tree` | `get_descendants()` |

## 6. Compliance

| Screen | Route | Feature | Reference Asset | Primary Data Source |
|--------|-------|---------|-----------------|---------------------|
| Command Center | `/compliance` | `compliance` | `compliance_command_center` | `get_compliance_dashboard()` |
| Rules Config | `/settings/compliance` | `compliance` | `rules_configuration` | `get_compliance_rules()` |
| Warning Detail | `/compliance/warning/:id` | `compliance` | `warning_detail` | `get_compliance_violation()` |

## 7. AI & Knowledge

| Screen | Route | Feature | Reference Asset | Primary Data Source |
|--------|-------|---------|-----------------|---------------------|
| Coach Chat | `/ai` | `ai` | `executive_coach` | `/chat` (NestJS) |
| Knowledge Base | `/knowledge` | `knowledge` | `knowledge_ingestion` | `get_knowledge_documents()` |

## 8. Settings

| Screen | Route | Feature | Reference Asset | Primary Data Source |
|--------|-------|---------|-----------------|---------------------|
| Company Settings | `/settings/company` | `settings` | `company_operating_system` | `get_company_settings()` |
| Team Identity | `/settings/branding` | `settings` | `team_identity` | `get_company_branding()` |
