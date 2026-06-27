-- ============================================================================
-- 020_triggers.sql — Core triggers and database integrity validations
-- ============================================================================
-- Automatically manages updated_at columns and enforces business constraints.
--
-- Dependencies: 002_companies.sql, 003_profiles.sql, 004_network_nodes.sql,
--               006_subscriptions.sql, 008_meetings.sql, 013_tasks.sql,
--               015_followups.sql

-- ============================================================================
-- Trigger Function: set_updated_at
-- ============================================================================
create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

-- Apply updated_at trigger to all tables containing updated_at
do $$
declare
  tbl text;
begin
  for tbl in
    select unnest(array[
      'companies', 'company_settings', 'profiles', 'subscriptions',
      'tasks', 'meetings', 'followups', 'network_nodes'
    ])
  loop
    execute format(
      'drop trigger if exists set_%s_updated_at on public.%I;
       create trigger set_%s_updated_at
         before update on public.%I
         for each row execute function public.set_updated_at();',
      tbl, tbl, tbl, tbl
    );
  end loop;
end $$;

-- ============================================================================
-- Validation Trigger: subscriptions.leader_id must reference role='leader'
-- ============================================================================
create or replace function public.validate_subscription_leader()
returns trigger
language plpgsql
as $$
begin
  if not exists (
    select 1 from public.profiles
    where id = new.leader_id and role = 'leader'
  ) then
    raise exception 'subscriptions.leader_id must reference a leader profile';
  end if;
  return new;
end;
$$;

drop trigger if exists check_subscription_leader on public.subscriptions;
create trigger check_subscription_leader
  before insert or update on public.subscriptions
  for each row execute function public.validate_subscription_leader();

-- ============================================================================
-- Validation Trigger: network_nodes.parent_id must be in the same company
-- ============================================================================
create or replace function public.validate_network_node_company()
returns trigger
language plpgsql
as $$
begin
  if new.parent_id is not null then
    if not exists (
      select 1 from public.network_nodes
      where profile_id = new.parent_id
        and company_id = new.company_id
    ) then
      raise exception 'Parent node must be in the same company';
    end if;
  end if;
  return new;
end;
$$;

drop trigger if exists check_network_node_company on public.network_nodes;
create trigger check_network_node_company
  before insert or update on public.network_nodes
  for each row execute function public.validate_network_node_company();

-- ============================================================================
-- Validation Trigger: profiles.company_id leader member limit check
-- ============================================================================
create or replace function public.validate_leader_member_limit()
returns trigger
language plpgsql
security definer
set search_path = public, extensions
as $$
declare
  v_leader_id uuid;
  v_member_limit integer;
  v_current_member_count integer;
begin
  -- If the profile being inserted/updated is a leader, they do not count towards any limit
  if new.role = 'leader' then
    return new;
  end if;

  -- 1. Try to find the leader via network tree (closest leader ancestor)
  select nn_leader.profile_id into v_leader_id
  from public.network_nodes nn_new
  join public.network_nodes nn_leader on nn_leader.path_ltree @> nn_new.path_ltree
  join public.profiles p_leader on p_leader.id = nn_leader.profile_id
  where nn_new.profile_id = new.id
    and p_leader.role = 'leader'
    and nn_leader.profile_id != new.id
  order by nn_leader.depth desc
  limit 1;

  -- 2. If not found in tree, try to find via invitation (invited profiles)
  if v_leader_id is null then
    select inviter_id into v_leader_id
    from public.invitations
    where profile_id = new.id
    limit 1;
  end if;

  -- 3. Fallback to company owner
  if v_leader_id is null then
    select owner_id into v_leader_id
    from public.companies
    where id = new.company_id;
  end if;

  -- If no leader is identified or if the profile is the leader themselves, allow it
  if v_leader_id is null or v_leader_id = new.id then
    return new;
  end if;

  -- Get the active subscription member limit for the leader
  select sp.member_limit into v_member_limit
  from public.subscriptions s
  join public.subscription_plans sp on s.plan_id = sp.id
  where s.leader_id = v_leader_id
    and s.status = 'active';

  -- If there is no active subscription, we do not enforce the limit here (billing checks are done at the API level)
  if v_member_limit is null then
    return new;
  end if;

  -- Count existing active + invited members under this leader
  select count(*)::integer into v_current_member_count
  from public.profiles p
  where p.company_id = new.company_id
    and p.role = 'member'
    and p.status != 'terminated'
    and p.id != new.id
    and (
      -- Case A: member has a network node, and v_leader_id is their closest leader ancestor
      exists (
        select 1
        from public.network_nodes nn_m
        where nn_m.profile_id = p.id
          and nn_m.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = v_leader_id)
          and not exists (
            select 1
            from public.network_nodes nn_mid
            join public.profiles p_mid on p_mid.id = nn_mid.profile_id
            where p_mid.role = 'leader'
              and p_mid.id != v_leader_id
              and nn_mid.path_ltree @> nn_m.path_ltree
              and nn_mid.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = v_leader_id)
          )
      )
      -- Case B: member has no network node, but was invited by v_leader_id
      or (
        not exists (select 1 from public.network_nodes where profile_id = p.id)
        and exists (
          select 1 from public.invitations i
          where i.profile_id = p.id
            and i.inviter_id = v_leader_id
        )
      )
      -- Case C: member has no network node and no invitation, fallback to company owner
      or (
        not exists (select 1 from public.network_nodes where profile_id = p.id)
        and not exists (select 1 from public.invitations i where i.profile_id = p.id)
        and (select owner_id from public.companies where id = new.company_id) = v_leader_id
      )
    );

  -- Check if inserting/updating this member exceeds the leader's limit
  if new.role = 'member' and new.status != 'terminated' and (v_current_member_count + 1) > v_member_limit then
    raise exception 'Subscription member limit reached (%)', v_member_limit;
  end if;

  return new;
end;
$$;

-- Drop the old trigger and function, and create the renamed ones
drop trigger if exists check_company_member_limit on public.profiles;
drop function if exists public.validate_company_member_limit();

drop trigger if exists check_leader_member_limit on public.profiles;
create trigger check_leader_member_limit
  before insert or update on public.profiles
  for each row execute function public.validate_leader_member_limit();


-- ============================================================================
-- Helper: log_compliance_event (logs raw compliance facts)
-- ============================================================================
create or replace function public.log_compliance_event(
  p_profile_id uuid,
  p_event_type text,
  p_event_value text default null,
  p_source_id uuid default null
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_company_id uuid;
begin
  select company_id into v_company_id from public.profiles where id = p_profile_id;
  
  insert into public.compliance_events (
    profile_id,
    company_id,
    event_type,
    event_value,
    source_id,
    occurred_at
  ) values (
    p_profile_id,
    v_company_id,
    p_event_type,
    p_event_value,
    p_source_id,
    now()
  );
end;
$$;

-- ============================================================================
-- Compliance Event Triggers
-- ============================================================================

-- Trigger function for meeting attendance transitions to absent/partial
create or replace function public.log_attendance_compliance_event()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if OLD.attendance_status <> NEW.attendance_status then
    if NEW.attendance_status = 'absent' then
      perform public.log_compliance_event(NEW.profile_id, 'missed_meeting', 'absent', NEW.meeting_id);
    elsif NEW.attendance_status = 'partial' then
      perform public.log_compliance_event(NEW.profile_id, 'partial_attendance', 'partial', NEW.meeting_id);
    end if;
  end if;
  return NEW;
end;
$$;

drop trigger if exists trigger_attendance_compliance_event on public.meeting_attendances;
create trigger trigger_attendance_compliance_event
  after update on public.meeting_attendances
  for each row execute function public.log_attendance_compliance_event();

-- Trigger function for task assignment transitions to overdue
create or replace function public.log_task_assignment_compliance_event()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if OLD.status <> NEW.status and NEW.status = 'overdue' then
    perform public.log_compliance_event(NEW.member_id, 'task_overdue', 'overdue', NEW.id);
  end if;
  return NEW;
end;
$$;

drop trigger if exists trigger_task_assignment_compliance_event on public.task_assignments;
create trigger trigger_task_assignment_compliance_event
  after update on public.task_assignments
  for each row execute function public.log_task_assignment_compliance_event();


