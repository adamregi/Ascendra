-- ============================================================================
-- 024_auth_invitation_rpcs.sql — Helper RPC functions for authentication and invitations
-- ============================================================================

-- Resolves a distributor ID to their email for password sign-in.
create or replace function public.resolve_distributor_login(p_distributor_id text)
returns text
language sql
security definer
stable
set search_path = public
as $$
  select email from public.profiles
  where lower(distributor_id) = lower(p_distributor_id)
  limit 1;
$$;

-- Atomically creates invited profile and pending invitation in a single transaction.
create or replace function public.create_invitation_atomic(
  p_inviter_id uuid,
  p_distributor_id text,
  p_full_name text,
  p_phone text,
  p_company_id uuid
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_profile_id uuid;
  v_invitation_id uuid;
  v_invitation record;
begin
  -- 1. Check uniqueness of distributor_id
  if exists (
    select 1 from public.profiles
    where company_id = p_company_id and lower(distributor_id) = lower(p_distributor_id)
  ) then
    raise exception 'Distributor ID % already exists in this company', p_distributor_id;
  end if;

  -- 2. Check uniqueness of phone
  if exists (
    select 1 from public.profiles
    where phone = p_phone
  ) then
    raise exception 'Phone number % is already registered', p_phone;
  end if;

  -- 3. Set the inviter context for the trigger check
  perform set_config('app.current_inviter_id', p_inviter_id::text, true);

  -- 4. Create profile (status = 'invited')
  v_profile_id := gen_random_uuid();
  insert into public.profiles (id, company_id, distributor_id, full_name, phone, role, status)
  values (v_profile_id, p_company_id, p_distributor_id, p_full_name, p_phone, 'member', 'invited');

  -- 5. Create invitation (status = 'pending')
  v_invitation_id := gen_random_uuid();
  insert into public.invitations (id, inviter_id, profile_id, company_id, distributor_id, full_name, phone, status, expires_at)
  values (
    v_invitation_id,
    p_inviter_id,
    v_profile_id,
    p_company_id,
    p_distributor_id,
    p_full_name,
    p_phone,
    'pending',
    now() + interval '7 days'
  )
  returning * into v_invitation;

  return row_to_json(v_invitation)::jsonb;
end;
$$;

-- Atomically accepts invitation, updates profile, and creates network tree node.
create or replace function public.accept_invitation_atomic(
  p_invitation_id uuid,
  p_auth_user_id uuid
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_profile_id uuid;
  v_company_id uuid;
  v_invitation record;
begin
  -- 1. Lock and fetch the invitation
  select * into v_invitation
  from public.invitations
  where id = p_invitation_id
  for update;

  if not found then
    raise exception 'Invitation not found';
  end if;

  if v_invitation.status != 'pending' then
    raise exception 'Invitation is not pending (status: %)', v_invitation.status;
  end if;

  if v_invitation.expires_at is not null and v_invitation.expires_at < now() then
    update public.invitations
    set status = 'expired'
    where id = p_invitation_id;
    raise exception 'Invitation has expired';
  end if;

  v_profile_id := v_invitation.profile_id;
  v_company_id := v_invitation.company_id;

  -- 2. Link auth_user_id to the existing profile and set status to active
  update public.profiles
  set auth_user_id = p_auth_user_id,
      status = 'active',
      updated_at = now()
  where id = v_profile_id;

  -- 3. Set invitation status = accepted
  update public.invitations
  set status = 'accepted',
      accepted_at = now()
  where id = p_invitation_id
  returning * into v_invitation;

  -- 4. Create network tree node under the inviter (leader)
  declare
    v_parent_node record;
    v_path text;
    v_depth integer;
    v_parent_id uuid;
  begin
    select * into v_parent_node
    from public.network_nodes
    where profile_id = v_invitation.inviter_id;

    if v_parent_node.id is not null then
      v_path := v_parent_node.path || '.' || v_profile_id::text;
      v_depth := v_parent_node.depth + 1;
      v_parent_id := v_invitation.inviter_id;
    else
      -- Fallback: inviter has no node, place as a new root node
      v_path := v_profile_id::text;
      v_depth := 0;
      v_parent_id := null;
    end if;

    insert into public.network_nodes (profile_id, parent_id, company_id, depth, path)
    values (v_profile_id, v_parent_id, v_company_id, v_depth, v_path);

    -- Increment parent's downline count
    if v_parent_node.id is not null then
      update public.network_nodes
      set downline_count = downline_count + 1
      where profile_id = v_invitation.inviter_id;
    end if;
  end;

  return row_to_json(v_invitation)::jsonb;
end;
$$;

-- Atomically cancels invitation and cleans up the associated invited profile.
create or replace function public.cancel_invitation_atomic(p_invitation_id uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_profile_id uuid;
begin
  select profile_id into v_profile_id from public.invitations where id = p_invitation_id;
  -- Deleting the profile automatically cascades to delete the invitation record.
  delete from public.profiles where id = v_profile_id;
end;
$$;

-- Computes a leader's subscription plan usage.
create or replace function public.get_leader_plan_usage(p_leader_id uuid)
returns jsonb
language plpgsql
security definer
stable
set search_path = public, extensions
as $$
declare
  v_limit integer;
  v_active_count integer;
  v_invited_count integer;
begin
  -- 1. Get plan limit
  select sp.member_limit into v_limit
  from public.subscriptions s
  join public.subscription_plans sp on s.plan_id = sp.id
  where s.leader_id = p_leader_id
    and s.status = 'active';

  if v_limit is null then
    v_limit := 0;
  end if;

  -- 2. Count active/warned/suspended members where this leader is the closest leader ancestor
  select count(*)::integer into v_active_count
  from public.profiles p
  where p.role = 'member'
    and p.status != 'terminated'
    and p.status != 'invited'
    and exists (
      select 1
      from public.network_nodes nn_m
      where nn_m.profile_id = p.id
        and nn_m.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
        and not exists (
          select 1
          from public.network_nodes nn_mid
          join public.profiles p_mid on p_mid.id = nn_mid.profile_id
          where p_mid.role = 'leader'
            and p_mid.id != p_leader_id
            and nn_mid.path_ltree @> nn_m.path_ltree
            and nn_mid.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
        )
    );

  -- 3. Count invited members invited by this leader
  select count(*)::integer into v_invited_count
  from public.profiles p
  where p.role = 'member'
    and p.status = 'invited'
    and exists (
      select 1 from public.invitations i
      where i.profile_id = p.id
        and i.inviter_id = p_leader_id
    );

  return jsonb_build_object(
    'limit', v_limit,
    'active_members', v_active_count,
    'invited_members', v_invited_count
  );
end;
$$;
