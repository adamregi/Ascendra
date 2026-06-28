# RPC Guide — Ascendra

> **Purpose**: Conventions for creating and maintaining PostgreSQL Stored Procedures (RPCs) in Ascendra.

---

## 1. Why Use RPCs?

In Ascendra, the Flutter client is "dumb". It should not perform complex joins, calculate aggregates, or execute multi-step database transactions.

- **For Reads**: RPCs act as Backend-for-Frontend (BFF) endpoints. They join data, calculate metrics, and return a single JSON object that perfectly maps to a Flutter Freezed ViewModel.
- **For Writes**: RPCs ensure atomicity. If a write requires updating 3 tables, it happens in one SQL transaction.

## 2. Naming Conventions

- **Pattern**: `<verb>_<entity>[_<qualifier>]`
- **Read Operations**: `get_member_profile_view_model`, `get_company_dashboard`
- **Write Operations (Transactional)**: `create_company_atomic`, `accept_invitation_atomic`
- **Business Actions**: `start_meeting`, `terminate_member`

## 3. Parameter Conventions

- Always prefix parameters with `p_` to avoid naming collisions with column names.
- Example: `p_profile_id`, `p_company_id`.

## 4. Security Definitions

### `security invoker` (Default & Preferred)
- The RPC runs with the permissions of the calling user.
- Supabase Row-Level Security (RLS) is fully enforced.
- Use this for 95% of RPCs.

### `security definer` (Use with Extreme Caution)
- The RPC runs with the privileges of the user who created it (usually `postgres` admin).
- Bypasses RLS entirely.
- MUST explicitly set the search path: `set search_path = public`.
- **Use Case**: Auth helpers (e.g., resolving a distributor ID to a user ID before they have logged in).

## 5. Returning JSON for ViewModels

When an RPC builds a complex ViewModel for Flutter, use `json_build_object` to return exactly what the client needs.

```sql
create or replace function get_member_hero_view_model(p_profile_id uuid)
returns json
language plpgsql
security invoker
as $$
declare
  result json;
begin
  select json_build_object(
    'distributor_id', p.id,
    'first_name', p.first_name,
    'last_name', p.last_name,
    'status', p.status,
    'joined_date', p.created_at,
    'current_streak', coalesce(cs.streak, 0)
  ) into result
  from profiles p
  left join compliance_snapshots cs on p.id = cs.profile_id
  where p.id = p_profile_id;

  return result;
end;
$$;
```

## 6. Calling RPCs in Flutter

Always cast the response appropriately before mapping to Freezed.

```dart
final response = await _client.rpc(
  'get_member_hero_view_model',
  params: {'p_profile_id': profileId},
);

// For single JSON object
final model = MemberHeroModel.fromJson(response as Map<String, dynamic>);

// For SETOF JSON (arrays)
final list = (response as List).map((json) => MyModel.fromJson(json)).toList();
```
