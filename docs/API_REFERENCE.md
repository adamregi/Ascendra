# API Reference — Ascendra

> **Purpose**: A catalog of the core PostgreSQL RPCs used by the Flutter client.

---

## 1. Authentication & Tenancy

### `get_user_company_id()`
- **Purpose**: Returns the `company_id` for the currently authenticated user. Used extensively in RLS policies.
- **Parameters**: None
- **Returns**: `UUID`
- **Security**: `invoker`

### `resolve_distributor_login(p_distributor_id text)`
- **Purpose**: Looks up the `auth.users.id` associated with a readable distributor ID for login.
- **Parameters**: `p_distributor_id` (TEXT)
- **Returns**: `UUID`
- **Security**: `definer` (Bypasses RLS because user is not yet logged in).

## 2. Onboarding & Invitations

### `create_invitation_atomic(...)`
- **Purpose**: Creates an invitation and a placeholder profile.
- **Parameters**: `p_company_id`, `p_sponsor_id`, `p_phone`, `p_first_name`, `p_last_name`
- **Returns**: `UUID` (Invitation ID)
- **Security**: `invoker`

### `accept_invitation_atomic(...)`
- **Purpose**: Links a new auth user to their pending profile and inserts them into the network tree.
- **Parameters**: `p_invitation_id`, `p_auth_user_id`
- **Returns**: `VOID`
- **Security**: `invoker`

## 3. Network Tree (ltree)

### `get_descendants(p_profile_id uuid)`
- **Purpose**: Retrieves all members in the downline of the specified profile.
- **Parameters**: `p_profile_id`
- **Returns**: `SETOF network_nodes`
- **Security**: `invoker`

### `get_ancestors(p_profile_id uuid)`
- **Purpose**: Retrieves the upline chain for a specific profile, up to the root.
- **Parameters**: `p_profile_id`
- **Returns**: `SETOF network_nodes`
- **Security**: `invoker`

### `restructure_network_tree(p_profile_id uuid, p_new_sponsor_id uuid)`
- **Purpose**: Moves a member (and their entire downline subtree) to a new sponsor. Atomically recalculates all `ltree` paths.
- **Parameters**: `p_profile_id`, `p_new_sponsor_id`
- **Returns**: `VOID`
- **Security**: `invoker`

## 4. Meetings

### `start_meeting(p_meeting_id uuid)`
- **Purpose**: Transitions a meeting from scheduled to active.
- **Parameters**: `p_meeting_id`
- **Returns**: `VOID`
- **Security**: `invoker`

### `end_meeting(p_meeting_id uuid)`
- **Purpose**: Transitions a meeting to ended, triggering attendance calculations via NestJS.
- **Parameters**: `p_meeting_id`
- **Returns**: `VOID`
- **Security**: `invoker`

## 5. ViewModels (Backend-for-Frontend)

### `get_member_profile_view_model(p_profile_id uuid)`
- **Purpose**: Aggregates hero data, KPIs, and compliance status into a single JSON object for the Profile page.
- **Parameters**: `p_profile_id`
- **Returns**: `JSON`
- **Security**: `invoker`

### `get_dashboard_view_model()`
- **Purpose**: Fetches pre-computed KPIs from `mv_company_dashboard_stats`.
- **Parameters**: None
- **Returns**: `JSON`
- **Security**: `invoker`

---

*Note: This is a partial reference of the most critical RPCs. See `supabase/migrations/` for the complete definitions.*
