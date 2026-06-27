-- ============================================================================
-- Phase 1: Complete Schema — Ascendra MLM Leadership Platform
-- ============================================================================
-- This migration fills all gaps identified in the Phase 1 audit:
--   • Creates the missing companies table (anchor for all company_id FKs)
--   • Creates company_settings, compliance_snapshots, restructure_logs,
--     audit_logs, meeting_participants
--   • Adds missing columns to profiles, meetings, invitations
--   • Creates the restructure_network_tree() stored procedure
--   • Replaces insecure RLS policies with tenant-isolated policies
--   • Adds recursive CTE helper functions for the network tree
--   • Creates analytics materialized views
-- ============================================================================

-- ─────────────────────────────────────────────────────────────────────────────
-- 1. COMPANIES TABLE
-- ─────────────────────────────────────────────────────────────────────────────

create table if not exists public.companies (
  id uuid primary key default gen_random_uuid(),
  name text not null check (char_length(trim(name)) > 0),
  slug text not null,
  owner_id uuid not null,  -- FK added after profiles alter
  logo_url text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create unique index if not exists companies_slug_unique_idx
  on public.companies (lower(slug));

-- ─────────────────────────────────────────────────────────────────────────────
-- 2. ALTER EXISTING TABLES — Add missing columns
-- ─────────────────────────────────────────────────────────────────────────────

-- profiles: add optional fields
alter table public.profiles
  add column if not exists avatar_url text,
  add column if not exists phone text,
  add column if not exists email text;

-- meetings: add lifecycle columns
alter table public.meetings
  add column if not exists status text not null default 'scheduled',
  add column if not exists ended_at timestamptz,
  add column if not exists recording_url text,
  add column if not exists description text,
  add column if not exists duration_minutes integer;

-- Add check constraint for meeting status
do $$
begin
  if not exists (
    select 1 from pg_constraint
    where conname = 'meetings_status_check'
  ) then
    alter table public.meetings
      add constraint meetings_status_check
      check (status in ('scheduled', 'live', 'ended', 'cancelled'));
  end if;
end $$;

-- invitations: add name for pre-filling
alter table public.invitations
  add column if not exists name text;

-- ─────────────────────────────────────────────────────────────────────────────
-- 3. FOREIGN KEY CONSTRAINTS — Wire company_id to companies table
-- ─────────────────────────────────────────────────────────────────────────────

-- companies.owner_id → profiles.id
do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'companies_owner_id_fkey'
  ) then
    alter table public.companies
      add constraint companies_owner_id_fkey
      foreign key (owner_id) references public.profiles(id) on delete restrict;
  end if;
end $$;

-- profiles.company_id → companies.id
do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'profiles_company_id_fkey'
  ) then
    alter table public.profiles
      add constraint profiles_company_id_fkey
      foreign key (company_id) references public.companies(id) on delete restrict;
  end if;
end $$;

-- invitations.company_id → companies.id
do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'invitations_company_id_fkey'
  ) then
    alter table public.invitations
      add constraint invitations_company_id_fkey
      foreign key (company_id) references public.companies(id) on delete cascade;
  end if;
end $$;

-- meetings.company_id → companies.id
do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'meetings_company_id_fkey'
  ) then
    alter table public.meetings
      add constraint meetings_company_id_fkey
      foreign key (company_id) references public.companies(id) on delete cascade;
  end if;
end $$;

-- documents.company_id → companies.id
do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'documents_company_id_fkey'
  ) then
    alter table public.documents
      add constraint documents_company_id_fkey
      foreign key (company_id) references public.companies(id) on delete cascade;
  end if;
end $$;

-- ai_conversations.company_id → companies.id
do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'ai_conversations_company_id_fkey'
  ) then
    alter table public.ai_conversations
      add constraint ai_conversations_company_id_fkey
      foreign key (company_id) references public.companies(id) on delete cascade;
  end if;
end $$;

-- ai_usage_logs.company_id → companies.id
do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'ai_usage_logs_company_id_fkey'
  ) then
    alter table public.ai_usage_logs
      add constraint ai_usage_logs_company_id_fkey
      foreign key (company_id) references public.companies(id) on delete cascade;
  end if;
end $$;

-- tasks.company_id → companies.id
do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'tasks_company_id_fkey'
  ) then
    alter table public.tasks
      add constraint tasks_company_id_fkey
      foreign key (company_id) references public.companies(id) on delete cascade;
  end if;
end $$;

-- notifications.company_id → companies.id
do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'notifications_company_id_fkey'
  ) then
    alter table public.notifications
      add constraint notifications_company_id_fkey
      foreign key (company_id) references public.companies(id) on delete cascade;
  end if;
end $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- 4. NEW TABLES
-- ─────────────────────────────────────────────────────────────────────────────

-- Company Settings (one per company)
create table if not exists public.company_settings (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  auto_terminate boolean not null default true,
  meeting_reminder_minutes integer not null default 15,
  default_meeting_duration_minutes integer not null default 60,
  max_tree_depth integer not null default 50,
  allow_member_invites boolean not null default false,
  timezone text not null default 'UTC',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint company_settings_company_unique unique (company_id)
);

-- Compliance Snapshots (monthly point-in-time records)
create table if not exists public.compliance_snapshots (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  profile_id uuid not null references public.profiles(id) on delete cascade,
  period_start date not null,
  period_end date not null,
  compliant_meetings integer not null default 0,
  required_meetings integer not null default 4,
  total_duration_seconds integer not null default 0,
  status text not null check (
    status in ('compliant', 'warned', 'at_risk', 'terminated')
  ),
  evaluated_at timestamptz not null default now(),
  metadata jsonb not null default '{}'::jsonb
);

-- Restructure Logs (tree restructuring audit trail)
create table if not exists public.restructure_logs (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  terminated_profile_id uuid not null references public.profiles(id) on delete cascade,
  new_parent_id uuid references public.profiles(id) on delete set null,
  children_moved integer not null default 0,
  before_tree jsonb not null default '{}'::jsonb,
  after_tree jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

-- Audit Logs (comprehensive action audit trail)
create table if not exists public.audit_logs (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  actor_id uuid references public.profiles(id) on delete set null,
  target_id uuid,
  action text not null,
  entity_type text not null,
  before_data jsonb,
  after_data jsonb,
  ip_address inet,
  user_agent text,
  created_at timestamptz not null default now()
);

-- Meeting Participants (invited member tracking)
create table if not exists public.meeting_participants (
  id uuid primary key default gen_random_uuid(),
  meeting_id uuid not null references public.meetings(id) on delete cascade,
  profile_id uuid not null references public.profiles(id) on delete cascade,
  invited_at timestamptz not null default now(),
  status text not null default 'invited' check (
    status in ('invited', 'accepted', 'declined')
  ),
  constraint meeting_participants_unique unique (meeting_id, profile_id)
);

-- ─────────────────────────────────────────────────────────────────────────────
-- 5. UPDATED_AT TRIGGERS
-- ─────────────────────────────────────────────────────────────────────────────

-- Reuse the set_updated_at() function from the previous migration.

drop trigger if exists set_profiles_updated_at on public.profiles;
create trigger set_profiles_updated_at
  before update on public.profiles
  for each row execute function public.set_updated_at();

drop trigger if exists set_companies_updated_at on public.companies;
create trigger set_companies_updated_at
  before update on public.companies
  for each row execute function public.set_updated_at();

drop trigger if exists set_company_settings_updated_at on public.company_settings;
create trigger set_company_settings_updated_at
  before update on public.company_settings
  for each row execute function public.set_updated_at();

drop trigger if exists set_meetings_updated_at on public.meetings;
create trigger set_meetings_updated_at
  before update on public.meetings
  for each row execute function public.set_updated_at();

-- ─────────────────────────────────────────────────────────────────────────────
-- 6. INDEXES
-- ─────────────────────────────────────────────────────────────────────────────

create index if not exists profiles_company_role_status_idx
  on public.profiles (company_id, role, status);

create index if not exists meetings_company_status_scheduled_idx
  on public.meetings (company_id, status, scheduled_at desc);

create index if not exists compliance_snapshots_company_period_idx
  on public.compliance_snapshots (company_id, period_start, period_end);

create index if not exists compliance_snapshots_profile_period_idx
  on public.compliance_snapshots (profile_id, period_start desc);

create index if not exists restructure_logs_company_created_idx
  on public.restructure_logs (company_id, created_at desc);

create index if not exists audit_logs_company_created_idx
  on public.audit_logs (company_id, created_at desc);

create index if not exists audit_logs_actor_created_idx
  on public.audit_logs (actor_id, created_at desc);

create index if not exists audit_logs_entity_action_idx
  on public.audit_logs (entity_type, action, created_at desc);

create index if not exists meeting_participants_meeting_profile_idx
  on public.meeting_participants (meeting_id, profile_id);

create index if not exists meeting_participants_profile_status_idx
  on public.meeting_participants (profile_id, status);

create index if not exists meetings_host_status_idx
  on public.meetings (host_id, status);

-- ─────────────────────────────────────────────────────────────────────────────
-- 7. HELPER FUNCTIONS — Tenant isolation & Network tree
-- ─────────────────────────────────────────────────────────────────────────────

-- Helper: Get company_id for authenticated user (used in all RLS policies)
create or replace function public.get_user_company_id()
returns uuid
language sql
stable
security definer
set search_path = public
as $$
  select company_id from public.profiles where id = (select auth.uid()) limit 1;
$$;

-- Network Tree: Get all descendants of a node (recursive CTE)
create or replace function public.get_descendants(p_profile_id uuid)
returns table (
  profile_id uuid,
  parent_id uuid,
  depth integer
)
language sql
stable
as $$
  with recursive descendants as (
    select
      nn.profile_id,
      nn.parent_id,
      1 as depth
    from public.network_nodes nn
    where nn.parent_id = p_profile_id

    union all

    select
      nn.profile_id,
      nn.parent_id,
      d.depth + 1
    from public.network_nodes nn
    inner join descendants d on nn.parent_id = d.profile_id
  )
  select * from descendants;
$$;

-- Network Tree: Get all ancestors of a node (recursive CTE)
create or replace function public.get_ancestors(p_profile_id uuid)
returns table (
  profile_id uuid,
  parent_id uuid,
  depth integer
)
language sql
stable
as $$
  with recursive ancestors as (
    select
      nn.profile_id,
      nn.parent_id,
      1 as depth
    from public.network_nodes nn
    where nn.profile_id = (
      select parent_id from public.network_nodes where profile_id = p_profile_id
    )

    union all

    select
      nn.profile_id,
      nn.parent_id,
      a.depth + 1
    from public.network_nodes nn
    inner join ancestors a on nn.profile_id = a.parent_id
    where a.parent_id is not null
  )
  select * from ancestors;
$$;

-- Network Tree: Calculate subtree size
create or replace function public.calculate_subtree_size(p_profile_id uuid)
returns integer
language sql
stable
as $$
  select count(*)::integer from public.get_descendants(p_profile_id);
$$;

-- Network Tree: Calculate node depth from root
create or replace function public.calculate_node_depth(p_profile_id uuid)
returns integer
language sql
stable
as $$
  select count(*)::integer from public.get_ancestors(p_profile_id);
$$;

-- ─────────────────────────────────────────────────────────────────────────────
-- 8. RESTRUCTURE NETWORK TREE — Atomic stored procedure
-- ─────────────────────────────────────────────────────────────────────────────

create or replace function public.restructure_network_tree(p_terminated_id uuid)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_terminated_node record;
  v_new_parent_id uuid;
  v_children_moved integer := 0;
  v_before_tree jsonb;
  v_after_tree jsonb;
  v_company_id uuid;
  v_child record;
begin
  -- 1. Lock and fetch the terminated node
  select * into v_terminated_node
  from public.network_nodes
  where profile_id = p_terminated_id
  for update;

  if not found then
    return jsonb_build_object(
      'success', false,
      'error', 'Network node not found for terminated profile'
    );
  end if;

  -- Get company_id for the restructure log
  select company_id into v_company_id
  from public.profiles
  where id = p_terminated_id;

  -- The new parent is the terminated node's parent (children move up one level)
  v_new_parent_id := v_terminated_node.parent_id;

  -- 2. Capture before state
  select jsonb_agg(jsonb_build_object(
    'profile_id', nn.profile_id,
    'parent_id', nn.parent_id,
    'path', nn.path
  ))
  into v_before_tree
  from public.network_nodes nn
  where nn.parent_id = p_terminated_id;

  -- 3. Reassign all direct children to the terminated node's parent
  for v_child in
    select * from public.network_nodes
    where parent_id = p_terminated_id
    for update
  loop
    -- Update parent_id
    update public.network_nodes
    set parent_id = v_new_parent_id
    where profile_id = v_child.profile_id;

    v_children_moved := v_children_moved + 1;
  end loop;

  -- 4. Rebuild paths for all affected descendants using a recursive approach
  -- First, rebuild paths for direct children (they now point to new parent)
  perform public._rebuild_subtree_paths(v_child_id)
  from (
    select profile_id as v_child_id
    from public.network_nodes
    where parent_id = v_new_parent_id
      and profile_id != p_terminated_id
  ) affected;

  -- 5. Update counts on the new parent
  if v_new_parent_id is not null then
    update public.network_nodes
    set
      children_count = (
        select count(*) from public.network_nodes where parent_id = v_new_parent_id
      ),
      member_count = (
        select count(*) from public.get_descendants(v_new_parent_id)
      )
    where profile_id = v_new_parent_id;
  end if;

  -- 6. Remove the terminated node from the tree
  delete from public.network_nodes where profile_id = p_terminated_id;

  -- 7. Capture after state
  if v_new_parent_id is not null then
    select jsonb_agg(jsonb_build_object(
      'profile_id', nn.profile_id,
      'parent_id', nn.parent_id,
      'path', nn.path
    ))
    into v_after_tree
    from public.network_nodes nn
    where nn.parent_id = v_new_parent_id;
  else
    v_after_tree := '[]'::jsonb;
  end if;

  -- 8. Log the restructure
  if v_company_id is not null then
    insert into public.restructure_logs (
      company_id,
      terminated_profile_id,
      new_parent_id,
      children_moved,
      before_tree,
      after_tree
    ) values (
      v_company_id,
      p_terminated_id,
      v_new_parent_id,
      v_children_moved,
      coalesce(v_before_tree, '[]'::jsonb),
      coalesce(v_after_tree, '[]'::jsonb)
    );
  end if;

  -- 9. Update the termination_logs record with restructure info
  update public.termination_logs
  set
    parent_reassigned_to = v_new_parent_id,
    restructured_at = now()
  where profile_id = p_terminated_id
    and restructured_at is null;

  return jsonb_build_object(
    'success', true,
    'terminated_profile_id', p_terminated_id,
    'new_parent_id', v_new_parent_id,
    'children_moved', v_children_moved
  );
end;
$$;

-- Helper: Rebuild path for a node and all its descendants
create or replace function public._rebuild_subtree_paths(p_node_id uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_parent_path text;
  v_new_path text;
  v_child_id uuid;
begin
  -- Get parent's path
  select nn_parent.path into v_parent_path
  from public.network_nodes nn
  join public.network_nodes nn_parent on nn.parent_id = nn_parent.profile_id
  where nn.profile_id = p_node_id;

  if v_parent_path is not null then
    v_new_path := v_parent_path || '.' || p_node_id::text;
  else
    -- This node is now a root node
    v_new_path := p_node_id::text;
  end if;

  -- Update this node's path
  update public.network_nodes
  set path = v_new_path
  where profile_id = p_node_id;

  -- Recursively rebuild all children
  for v_child_id in
    select profile_id from public.network_nodes where parent_id = p_node_id
  loop
    perform public._rebuild_subtree_paths(v_child_id);
  end loop;
end;
$$;

-- ─────────────────────────────────────────────────────────────────────────────
-- 9. RLS — Enable on new tables
-- ─────────────────────────────────────────────────────────────────────────────

alter table public.companies enable row level security;
alter table public.company_settings enable row level security;
alter table public.compliance_snapshots enable row level security;
alter table public.restructure_logs enable row level security;
alter table public.audit_logs enable row level security;
alter table public.meeting_participants enable row level security;

-- ─────────────────────────────────────────────────────────────────────────────
-- 10. RLS POLICY OVERHAUL — Drop insecure, create tenant-isolated
-- ─────────────────────────────────────────────────────────────────────────────

-- Drop all existing overly-permissive policies from migration 1
drop policy if exists "Allow select profiles" on public.profiles;
drop policy if exists "Allow select invitations" on public.invitations;
drop policy if exists "Allow select network_nodes" on public.network_nodes;
drop policy if exists "Allow select meetings" on public.meetings;
drop policy if exists "Allow select meeting_attendances" on public.meeting_attendances;
drop policy if exists "Allow select compliance_rules" on public.compliance_rules;
drop policy if exists "Allow select termination_logs" on public.termination_logs;
drop policy if exists "Allow select documents" on public.documents;
drop policy if exists "Allow select document_chunks" on public.document_chunks;
drop policy if exists "Allow select ai_conversations" on public.ai_conversations;
drop policy if exists "Allow select ai_messages" on public.ai_messages;

-- ── COMPANIES ──
-- Users can view their own company
create policy "Users can view own company"
  on public.companies for select
  using (id = public.get_user_company_id());

-- ── PROFILES ──
-- Users can view profiles within their company
create policy "Users can view company profiles"
  on public.profiles for select
  using (company_id = public.get_user_company_id());

-- Users can update their own profile
create policy "Users can update own profile"
  on public.profiles for update
  using (id = (select auth.uid()))
  with check (id = (select auth.uid()));

-- ── INVITATIONS ──
-- Leaders can view invitations for their company
create policy "Users can view company invitations"
  on public.invitations for select
  using (company_id = public.get_user_company_id());

-- ── NETWORK NODES ──
-- Users can view network nodes for profiles in their company
create policy "Users can view company network"
  on public.network_nodes for select
  using (
    exists (
      select 1 from public.profiles p
      where p.id = network_nodes.profile_id
        and p.company_id = public.get_user_company_id()
    )
  );

-- ── MEETINGS ──
-- Users can view meetings in their company
create policy "Users can view company meetings"
  on public.meetings for select
  using (company_id = public.get_user_company_id());

-- ── MEETING ATTENDANCES ──
-- Users can view attendance records for meetings in their company
create policy "Users can view company meeting attendances"
  on public.meeting_attendances for select
  using (
    exists (
      select 1 from public.meetings m
      where m.id = meeting_attendances.meeting_id
        and m.company_id = public.get_user_company_id()
    )
  );

-- ── MEETING PARTICIPANTS ──
create policy "Users can view company meeting participants"
  on public.meeting_participants for select
  using (
    exists (
      select 1 from public.meetings m
      where m.id = meeting_participants.meeting_id
        and m.company_id = public.get_user_company_id()
    )
  );

-- ── COMPLIANCE RULES ──
create policy "Users can view company compliance rules"
  on public.compliance_rules for select
  using (company_id = public.get_user_company_id());

-- ── TERMINATION LOGS ──
-- Leaders can view all termination logs; members can view their own
create policy "Users can view relevant termination logs"
  on public.termination_logs for select
  using (
    profile_id = (select auth.uid())
    or exists (
      select 1 from public.profiles p
      where p.id = (select auth.uid())
        and p.role = 'leader'
        and p.company_id = (
          select company_id from public.profiles
          where id = termination_logs.profile_id
        )
    )
  );

-- ── DOCUMENTS ──
create policy "Users can view company documents"
  on public.documents for select
  using (company_id = public.get_user_company_id());

-- ── DOCUMENT CHUNKS ──
create policy "Users can view company document chunks"
  on public.document_chunks for select
  using (
    exists (
      select 1 from public.documents d
      where d.id = document_chunks.document_id
        and d.company_id = public.get_user_company_id()
    )
  );

-- ── AI CONVERSATIONS ──
-- Users can view their own conversations
create policy "Users can view own ai conversations"
  on public.ai_conversations for select
  using (profile_id = (select auth.uid()));

-- ── AI MESSAGES ──
-- Users can view messages from their own conversations
create policy "Users can view own ai messages"
  on public.ai_messages for select
  using (
    exists (
      select 1 from public.ai_conversations c
      where c.id = ai_messages.conversation_id
        and c.profile_id = (select auth.uid())
    )
  );

-- ── COMPANY SETTINGS ──
create policy "Users can view company settings"
  on public.company_settings for select
  using (company_id = public.get_user_company_id());

-- ── COMPLIANCE SNAPSHOTS ──
-- Leaders see all; members see own
create policy "Users can view relevant compliance snapshots"
  on public.compliance_snapshots for select
  using (
    profile_id = (select auth.uid())
    or (
      company_id = public.get_user_company_id()
      and exists (
        select 1 from public.profiles p
        where p.id = (select auth.uid())
          and p.role = 'leader'
      )
    )
  );

-- ── RESTRUCTURE LOGS ──
-- Leaders only
create policy "Leaders can view company restructure logs"
  on public.restructure_logs for select
  using (
    company_id = public.get_user_company_id()
    and exists (
      select 1 from public.profiles p
      where p.id = (select auth.uid())
        and p.role = 'leader'
    )
  );

-- ── AUDIT LOGS ──
-- Leaders only
create policy "Leaders can view company audit logs"
  on public.audit_logs for select
  using (
    company_id = public.get_user_company_id()
    and exists (
      select 1 from public.profiles p
      where p.id = (select auth.uid())
        and p.role = 'leader'
    )
  );

-- ─────────────────────────────────────────────────────────────────────────────
-- 11. GRANTS — Allow authenticated role to read new tables
-- ─────────────────────────────────────────────────────────────────────────────

grant select on public.companies to authenticated;
grant select on public.company_settings to authenticated;
grant select on public.compliance_snapshots to authenticated;
grant select on public.restructure_logs to authenticated;
grant select on public.audit_logs to authenticated;
grant select on public.meeting_participants to authenticated;

-- ─────────────────────────────────────────────────────────────────────────────
-- 12. MATERIALIZED VIEWS — Analytics
-- ─────────────────────────────────────────────────────────────────────────────

-- Company Dashboard Stats
create materialized view if not exists public.mv_company_dashboard_stats as
select
  c.id as company_id,
  c.name as company_name,
  count(distinct p.id) filter (where p.status = 'active') as active_members,
  count(distinct p.id) filter (where p.status = 'warned') as warned_members,
  count(distinct p.id) filter (where p.status = 'terminated') as terminated_members,
  count(distinct p.id) as total_members,
  count(distinct m.id) as total_meetings,
  count(distinct m.id) filter (
    where m.scheduled_at >= date_trunc('month', now())
  ) as meetings_this_month,
  count(distinct ma.id) as total_attendance_records,
  coalesce(avg(ma.duration_seconds), 0)::integer as avg_attendance_duration_seconds
from public.companies c
left join public.profiles p on p.company_id = c.id
left join public.meetings m on m.company_id = c.id
left join public.meeting_attendances ma on ma.meeting_id = m.id
group by c.id, c.name;

create unique index if not exists mv_company_dashboard_stats_company_idx
  on public.mv_company_dashboard_stats (company_id);

-- Monthly Compliance Summary
create materialized view if not exists public.mv_monthly_compliance_summary as
select
  cs.company_id,
  cs.period_start,
  cs.period_end,
  count(*) as total_evaluated,
  count(*) filter (where cs.status = 'compliant') as compliant_count,
  count(*) filter (where cs.status = 'warned') as warned_count,
  count(*) filter (where cs.status = 'at_risk') as at_risk_count,
  count(*) filter (where cs.status = 'terminated') as terminated_count,
  case
    when count(*) > 0
    then round(
      (count(*) filter (where cs.status = 'compliant'))::numeric / count(*)::numeric * 100,
      2
    )
    else 0
  end as compliance_rate_pct
from public.compliance_snapshots cs
group by cs.company_id, cs.period_start, cs.period_end;

create unique index if not exists mv_monthly_compliance_company_period_idx
  on public.mv_monthly_compliance_summary (company_id, period_start, period_end);

-- Function to refresh all materialized views (called by analytics-dashboard edge function)
create or replace function public.refresh_analytics_views()
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  refresh materialized view concurrently public.mv_company_dashboard_stats;
  refresh materialized view concurrently public.mv_monthly_compliance_summary;
end;
$$;

-- ─────────────────────────────────────────────────────────────────────────────
-- 13. MAKE CIRCULAR FKs DEFERRABLE
-- ─────────────────────────────────────────────────────────────────────────────

-- Drop and re-add the circular FKs as DEFERRABLE INITIALLY DEFERRED
-- so that create_company_atomic can insert both company and profile in one tx.

do $$
begin
  -- companies.owner_id → profiles.id
  if exists (
    select 1 from pg_constraint where conname = 'companies_owner_id_fkey'
  ) then
    alter table public.companies drop constraint companies_owner_id_fkey;
  end if;
  alter table public.companies
    add constraint companies_owner_id_fkey
    foreign key (owner_id) references public.profiles(id) on delete restrict
    deferrable initially deferred;

  -- profiles.company_id → companies.id
  if exists (
    select 1 from pg_constraint where conname = 'profiles_company_id_fkey'
  ) then
    alter table public.profiles drop constraint profiles_company_id_fkey;
  end if;
  alter table public.profiles
    add constraint profiles_company_id_fkey
    foreign key (company_id) references public.companies(id) on delete restrict
    deferrable initially deferred;
end $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- 14. CREATE COMPANY ATOMIC — Handles circular FK in a single transaction
-- ─────────────────────────────────────────────────────────────────────────────

create or replace function public.create_company_atomic(
  p_user_id uuid,
  p_company_name text,
  p_company_slug text,
  p_full_name text,
  p_logo_url text default null
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_company_id uuid;
  v_company record;
  v_profile record;
begin
  -- Defer circular FK checks until transaction commit
  set constraints companies_owner_id_fkey, profiles_company_id_fkey deferred;

  -- 1. Generate company ID
  v_company_id := gen_random_uuid();

  -- 2. Insert company
  insert into public.companies (id, name, slug, owner_id, logo_url)
  values (v_company_id, p_company_name, p_company_slug, p_user_id, p_logo_url)
  returning * into v_company;

  -- 3. Insert leader profile
  insert into public.profiles (id, full_name, company_id, role, status)
  values (p_user_id, p_full_name, v_company_id, 'leader', 'active')
  returning * into v_profile;

  -- 4. Create root network node
  insert into public.network_nodes (profile_id, parent_id, path, children_count, member_count)
  values (p_user_id, null, p_user_id::text, 0, 0);

  -- 5. Create default company settings
  insert into public.company_settings (company_id)
  values (v_company_id);

  -- 6. Create default compliance rules
  insert into public.compliance_rules (company_id)
  values (v_company_id);

  -- 7. Create audit log entry
  insert into public.audit_logs (company_id, actor_id, target_id, action, entity_type, after_data)
  values (
    v_company_id,
    p_user_id,
    v_company_id,
    'created',
    'company',
    jsonb_build_object(
      'name', p_company_name,
      'slug', p_company_slug,
      'ownerId', p_user_id
    )
  );

  -- FK constraints validated at commit
  return jsonb_build_object(
    'company', row_to_json(v_company),
    'profile', row_to_json(v_profile)
  );
end;
$$;

