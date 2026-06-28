# Business Rules — Ascendra

> **Purpose**: Core business policies that dictate how the Ascendra platform operates. This is vital for implementing logic correctly.

---

## 1. Subscription & Tenancy

### Plan Enforcement
- **Starter**: 50 members max.
- **Pro**: 100 members max + Analytics access.
- **Enterprise**: 200 members max + Full platform access.
- *Rule*: Before a leader can invite a new member, the system must check `get_leader_plan_usage()`. If the limit is reached, the invitation is blocked at the database level via a trigger.

### Tenant Isolation
- A user can only belong to **one** company.
- All database reads/writes are restricted by `company_id`.
- Members cannot see profiles of users outside their company or outside their allowed visibility scope (defined by `ltree` path).

## 2. Onboarding & Accounts

### Invitation Only
- There is no public registration page.
- All members must be invited by an existing leader within their company.
- Invitations are sent via SMS/WhatsApp with an OTP link.

### Atomic Account Creation
- Acceptance of an invitation triggers `accept_invitation_atomic()`.
- This creates the Supabase Auth user, creates the `profiles` record, creates the `network_nodes` record, and updates the `invitations` status in a single database transaction.

## 3. Compliance Scoring

### The 100-Point System
Every member has a compliance score from 0-100, calculated daily by NestJS based on:
1. **Attendance (50%)**: Ratio of attended meetings vs expected meetings in the last 30 days.
2. **Task Completion (30%)**: Ratio of completed tasks vs assigned tasks in the last 30 days.
3. **Follow-ups (20%)**: Response rate to leader follow-ups.

### Status Transitions
- `active`: Score >= 70
- `warned`: Score drops below 70. (Triggers notification).
- `suspended`: Score drops below 50 OR leader manually suspends.
- `terminated`: Leader manually terminates.

## 4. Meetings & Video

### Room Lifecycle
- Creating a meeting in the app creates a database record.
- Starting a meeting triggers an Edge Function to create a 100ms room.
- Ending a meeting disables the 100ms room and triggers the NestJS worker to compile attendance.

### Attendance Policy
- A member must be present in the 100ms room for at least **70% of the meeting duration** to be marked as "attended". This is calculated via webhooks.

## 5. Network Tree Rules

### Ltree Immutability
- The `path` column in `network_nodes` determines upline/downline relationships.
- Manual changes to `path` are strictly prohibited.
- Restructuring must go through the `restructure_network_tree()` RPC which ensures no circular loops are created and recalculates all child paths automatically.

### Termination Impact
- If a member with a downline is terminated, their direct downline rolls up to the terminated member's sponsor.

## 6. AI Assistant (Gemini)

### Access Control
- The AI can only search documents uploaded by the user's specific company (`company_id` filter on pgvector).
- Context injected into prompts is limited to the querying user's downline data (enforced by `can_view_profile()`).

---

*For technical implementation of these rules, see [PROJECT_ARCHITECTURE.md](PROJECT_ARCHITECTURE.md).*
