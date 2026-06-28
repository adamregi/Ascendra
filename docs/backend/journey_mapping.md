# Ascendra Backend User Journey Mapping

This document maps core user journeys to the underlying database state changes, transaction flows, and backend event-driven processing steps.

---

## Journey 1: Leader Signup & Company Setup

This journey establishes the root company tenant and its primary leader profile.

### Step-by-Step Flow

```mermaid
sequenceDiagram
    autonumber
    Leader ->> API: Submit Signup Form
    Note over API: Invoke Edge Function "/create-company"
    API ->> DB: Call RPC "create_company_atomic()"
    Note over DB: Circular Dependency Check (Profiles <=> Companies)
    DB ->> DB: Insert public.companies
    DB ->> DB: Insert public.profiles (role='leader', status='active')
    DB ->> DB: Bind subscription (subscriptions table - Starter Plan)
    DB ->> DB: Insert public.network_nodes (parent_id=NULL, depth=0)
    DB -->> Leader: HTTP 201 Created (Token & Profile Data)
```

### Backend State Map

| Actions | Affected Tables | Key Column Changes | Triggers / Side Effects |
|---|---|---|---|
| Initiate signup | `companies`, `profiles` | `companies.owner_id` set to profile uuid; `profiles.company_id` set to company uuid. | Constraints set to `INITIALLY DEFERRED` to prevent circular dependency errors. |
| Allocate plan | `subscriptions` | `status = 'active'`, `expires_at = now() + interval '30 days'` | `check_subscription_leader` trigger asserts that profile has the leader role. |
| Setup tree | `network_nodes` | `parent_id = null`, `depth = 0`, `path = <profile_uuid>` | GiSt index tracks node. `path_ltree` generated from path. |

---

## Journey 2: Leader Invites Member & Onboarding Completion

This journey details the onboarding flow, which uses phone-based OTP verification for security.

### Step-by-Step Flow

```mermaid
sequenceDiagram
    autonumber
    Leader ->> API: Enter Member Details (Name, Phone, ID)
    Note over API: Invoke Edge Function "/invite-member"
    API ->> DB: Query active member count vs plan limit
    alt Limit Exceeded
        API -->> Leader: HTTP 400 Plan limit reached
    else Limit OK
        API ->> DB: Insert profile (status='invited')
        API ->> DB: Insert invitation (status='pending')
        API ->> DB: Insert network_node (under leader node)
        Note over API: Publish "MemberInvited" event to Event Bus
        API -->> Leader: HTTP 201 Member Invited
    end
    
    Note over EventBus: Onboarding Queue consumes "MemberInvited"
    EventBus ->> NotificationService: Dispatch SMS Invite Link with OTP token
    
    Member ->> DB: Accepts invite, verify phone OTP
    Note over DB: supabase.auth signup + link profile
    DB ->> DB: Update profiles (status='active', auth_user_id=auth.uid())
    DB ->> DB: Update invitations (status='accepted', accepted_at=now())
```

### Backend State Map

| Actions | Affected Tables | Key Column Changes | Triggers / Side Effects |
|---|---|---|---|
| Leader submits invite | `profiles`, `invitations` | `profiles.status = 'invited'`; `invitations.status = 'pending'` | Slot consumed. System counts `invited` profiles in plan limit check to prevent over-invitations. |
| Event emitted | `invitations` | `expires_at = now() + interval '7 days'` | `MemberInvited` event is pushed to Upstash Redis. Onboarding worker picks it up for SMS sending. |
| Member signs up | `auth.users`, `profiles` | `profiles.auth_user_id` linked, `profiles.status = 'active'` | RLS updates. Member can now query other tables within their company. |

---

## Journey 3: Video Meeting & Attendance Compliance Auditing

This journey tracks compliance requirements (e.g., minimum duration and frequency) for team video calls, using asynchronous event evaluation.

### Step-by-Step Flow

```mermaid
sequenceDiagram
    autonumber
    Leader ->> API: Schedules Meeting
    Note over API: Edge Fn "/schedule-meeting" -> 100ms API
    API ->> DB: Write to meetings table
    Leader ->> HMS: Starts Video Meeting
    HMS -->> API: Webhook: Room Live
    API ->> DB: Update meetings status = 'live'
    Member ->> HMS: Joins room
    HMS -->> API: Webhook: User Joined
    API ->> DB: Insert attendance_events & meeting_attendances
    Member ->> HMS: Leaves room
    HMS -->> API: Webhook: User Left
    API ->> DB: Update left_at & calculate duration_minutes
    HMS -->> API: Webhook: Room Ended
    API ->> DB: Update meeting status = 'ended'
    API ->> EventBus: Publish Event "MeetingEnded" (meeting_id, company_id)
    
    Note over EventBus: Meeting Queue processes "MeetingEnded" asynchronously
    EventBus ->> NestJS: Run attendance evaluation & refresh MV
    NestJS ->> DB: Update compliance snapshots
    EventBus ->> NestJS: Generate AI Meeting Summary
    NestJS ->> Gemini: Summarize transcript & decisions
    Gemini -->> NestJS: Summary Text
    NestJS ->> DB: Save Summary to document storage
```

### Backend State Map

| Actions | Affected Tables | Key Column Changes | Triggers / Side Effects |
|---|---|---|---|
| Create meeting | `meetings` | `status = 'scheduled'`, `room_id = '100ms-uuid'` | Generated token lets leader launch meeting. |
| User joins | `attendance_events`, `meeting_attendances` | `attendance_events.event_type = 'join'`, `meeting_attendances.joined_at = now()` | Real-time dashboards update. |
| User leaves | `attendance_events`, `meeting_attendances` | `attendance_events.event_type = 'leave'`, `meeting_attendances.duration_minutes = delta` | Calculates cumulative connection time across disconnects. |
| Meeting ends | `meetings`, `compliance_snapshots` | `meetings.status = 'ended'` | Publishes `MeetingEnded` domain event. Subscribed jobs calculate metrics and call Gemini. |

---

## Journey 4: Task Verification Flow

This journey tracks work proof verification for tasks assigned by leaders.

### Step-by-Step Flow

```mermaid
sequenceDiagram
    autonumber
    Leader ->> API: Create Task & Assign
    API ->> DB: Insert tasks (status='open')
    DB ->> DB: Insert task_events (event='created')
    Member ->> API: Set In Progress
    API ->> DB: Update tasks (status='in_progress')
    Member ->> API: Upload screenshot, submit completion
    Note over API: Save to Supabase Storage "task_proofs" bucket
    API ->> DB: Insert task_proofs & set tasks (status='completed')
    API ->> EventBus: Publish Event "TaskCompleted" (task_id)
    
    Note over EventBus: Task Queue processes "TaskCompleted"
    EventBus ->> NotificationService: Dispatch Push/WhatsApp to Leader
```

### Backend State Map

| Actions | Affected Tables | Key Column Changes | Triggers / Side Effects |
|---|---|---|---|
| Assign task | `tasks`, `task_events` | `status = 'open'`, `assigned_to = member_uuid` | Triggers a push notification to the member. |
| Submit proof | `task_proofs`, `tasks` | `tasks.status = 'completed'`, `task_proofs.file_url = <url>` | Asserts that `completed_at` is set when status is updated to `'completed'`. |

---

## Journey 5: Compliance Warn, Suspend & Restructure Pipeline

This diagram shows how compliance violations escalate to member termination and MLM tree restructuring.

### Step-by-Step Flow

```mermaid
sequenceDiagram
    autonumber
    Note over Engine: Daily Cron runs compliance engine in NestJS
    Engine ->> DB: Query mv_member_progress
    alt Attendance / Tasks deficient
        Engine ->> DB: Set profiles status='warned'
        Engine ->> DB: Write compliance_events ('warned')
        Engine ->> NotificationService: Send Warning Alert
    else Warning Grace Period Exceeded without Resolution
        Engine ->> DB: Set profiles status='suspended'
    else Extended Non-Compliance
        Engine ->> DB: Call RPC "terminate_member()"
        DB ->> DB: Set profiles status='terminated'
        DB ->> DB: Insert termination_logs
        DB ->> EventBus: Publish Event "MemberTerminated" (profile_id, company_id)
        
        Note over EventBus: Restructure Queue processes "MemberTerminated"
        EventBus ->> NestJS: Recalculate downline tree
        NestJS ->> DB: Call RPC "restructure_network_tree()"
        Note over DB: Move terminated children under parent
        DB ->> DB: Update children path & path_ltree
        DB ->> DB: Insert restructure_logs
    end
```

### Backend State Map

| Actions | Affected Tables | Key Column Changes | Triggers / Side Effects |
|---|---|---|---|
| Warning issued | `profiles`, `compliance_events` | `profiles.status = 'warned'`, `warned_at = now()` | Grace period countdown starts. |
| Terminated | `profiles`, `termination_logs` | `profiles.status = 'terminated'`, `terminated_at = now()` | Blocks user from accessing the system. |
| Restructure | `network_nodes`, `restructure_logs` | `network_nodes.parent_id = upline_parent_uuid`, `path = updated_materialized_path` | GiST tree indexes update. Recalculates downline counts for all nodes in the path. |
