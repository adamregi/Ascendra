-- Production operational controls and audit history.
create extension if not exists ltree with schema extensions;

alter table public.invitations
  add column if not exists used_by uuid references public.profiles(id) on delete set null,
  add column if not exists accepted_at timestamptz;

alter table public.network_nodes
  add column if not exists path_ltree extensions.ltree
    generated always as (replace(path, '-', '_')::extensions.ltree) stored;

create table if not exists public.compliance_events (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles(id) on delete cascade,
  event_type text not null check (
    event_type in (
      'warned',
      'warning_removed',
      'terminated',
      'manual_override'
    )
  ),
  reason text,
  created_at timestamptz not null default now(),
  metadata jsonb not null default '{}'::jsonb
);

create table if not exists public.attendance_events (
  id uuid primary key default gen_random_uuid(),
  meeting_id uuid not null references public.meetings(id) on delete cascade,
  profile_id uuid not null references public.profiles(id) on delete cascade,
  attendance_id uuid references public.meeting_attendances(id) on delete set null,
  event_type text not null check (
    event_type in ('join', 'leave', 'disconnect', 'reconnect')
  ),
  occurred_at timestamptz not null default now(),
  metadata jsonb not null default '{}'::jsonb
);

create table if not exists public.ai_usage_logs (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null,
  profile_id uuid not null references public.profiles(id) on delete cascade,
  conversation_id uuid references public.ai_conversations(id) on delete set null,
  message_id uuid references public.ai_messages(id) on delete set null,
  provider text not null default 'gemini',
  model text not null,
  operation text not null default 'rag_chat',
  prompt_tokens integer not null default 0 check (prompt_tokens >= 0),
  completion_tokens integer not null default 0 check (completion_tokens >= 0),
  total_tokens integer not null default 0 check (total_tokens >= 0),
  latency_ms integer check (latency_ms is null or latency_ms >= 0),
  cost_usd numeric(12, 6) check (cost_usd is null or cost_usd >= 0),
  created_at timestamptz not null default now(),
  metadata jsonb not null default '{}'::jsonb
);

create table if not exists public.tasks (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null,
  created_by uuid not null references public.profiles(id) on delete cascade,
  assigned_to uuid not null references public.profiles(id) on delete cascade,
  title text not null check (char_length(trim(title)) > 0),
  description text,
  status text not null default 'open' check (
    status in ('open', 'in_progress', 'completed', 'cancelled')
  ),
  priority text not null default 'normal' check (
    priority in ('low', 'normal', 'high', 'urgent')
  ),
  due_at timestamptz,
  completed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  metadata jsonb not null default '{}'::jsonb,
  check (
    (status = 'completed' and completed_at is not null)
    or (status <> 'completed' and completed_at is null)
  )
);

create table if not exists public.task_events (
  id uuid primary key default gen_random_uuid(),
  task_id uuid not null references public.tasks(id) on delete cascade,
  actor_id uuid references public.profiles(id) on delete set null,
  event_type text not null check (
    event_type in ('created', 'assigned', 'started', 'completed', 'cancelled', 'reopened')
  ),
  note text,
  created_at timestamptz not null default now(),
  metadata jsonb not null default '{}'::jsonb
);

create table if not exists public.notifications (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null,
  recipient_id uuid not null references public.profiles(id) on delete cascade,
  actor_id uuid references public.profiles(id) on delete set null,
  task_id uuid references public.tasks(id) on delete set null,
  type text not null check (
    type in (
      'task_assigned',
      'task_completed',
      'compliance_warning',
      'compliance_restored',
      'compliance_terminated',
      'invite_accepted',
      'meeting_scheduled',
      'system'
    )
  ),
  title text not null,
  body text,
  read_at timestamptz,
  created_at timestamptz not null default now(),
  metadata jsonb not null default '{}'::jsonb
);

create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists set_tasks_updated_at on public.tasks;
create trigger set_tasks_updated_at
  before update on public.tasks
  for each row execute function public.set_updated_at();

create index if not exists invitations_used_by_idx on public.invitations(used_by);
create index if not exists invitations_accepted_at_idx on public.invitations(accepted_at);
create index if not exists network_nodes_path_ltree_gist_idx
  on public.network_nodes using gist (path_ltree);

create index if not exists compliance_events_profile_created_idx
  on public.compliance_events(profile_id, created_at desc);
create index if not exists compliance_events_type_created_idx
  on public.compliance_events(event_type, created_at desc);

create index if not exists attendance_events_meeting_profile_created_idx
  on public.attendance_events(meeting_id, profile_id, occurred_at desc);
create index if not exists attendance_events_attendance_id_idx
  on public.attendance_events(attendance_id);

create index if not exists ai_usage_logs_company_created_idx
  on public.ai_usage_logs(company_id, created_at desc);
create index if not exists ai_usage_logs_profile_created_idx
  on public.ai_usage_logs(profile_id, created_at desc);

create index if not exists tasks_assigned_status_due_idx
  on public.tasks(assigned_to, status, due_at);
create index if not exists tasks_created_by_status_idx
  on public.tasks(created_by, status);
create index if not exists tasks_company_status_idx
  on public.tasks(company_id, status);

create index if not exists task_events_task_created_idx
  on public.task_events(task_id, created_at desc);

create index if not exists notifications_recipient_read_created_idx
  on public.notifications(recipient_id, read_at, created_at desc);
create index if not exists notifications_company_created_idx
  on public.notifications(company_id, created_at desc);

alter table public.compliance_events enable row level security;
alter table public.attendance_events enable row level security;
alter table public.ai_usage_logs enable row level security;
alter table public.tasks enable row level security;
alter table public.task_events enable row level security;
alter table public.notifications enable row level security;

grant select on public.compliance_events to authenticated;
grant select on public.attendance_events to authenticated;
grant select on public.ai_usage_logs to authenticated;
grant select on public.tasks to authenticated;
grant select on public.task_events to authenticated;
grant select on public.notifications to authenticated;

create policy "Users can select own compliance events or company leaders can review"
  on public.compliance_events
  for select
  using (
    profile_id = (select auth.uid())
    or exists (
      select 1
      from public.profiles viewer
      join public.profiles subject on subject.id = compliance_events.profile_id
      where viewer.id = (select auth.uid())
        and viewer.role = 'leader'
        and viewer.company_id = subject.company_id
    )
  );

create policy "Users can select own attendance events or meeting hosts can review"
  on public.attendance_events
  for select
  using (
    profile_id = (select auth.uid())
    or exists (
      select 1
      from public.meetings m
      where m.id = attendance_events.meeting_id
        and m.host_id = (select auth.uid())
    )
  );

create policy "Users can select own ai usage or company leaders can review"
  on public.ai_usage_logs
  for select
  using (
    profile_id = (select auth.uid())
    or exists (
      select 1
      from public.profiles viewer
      where viewer.id = (select auth.uid())
        and viewer.role = 'leader'
        and viewer.company_id = ai_usage_logs.company_id
    )
  );

create policy "Users can select tasks they created or are assigned"
  on public.tasks
  for select
  using (
    created_by = (select auth.uid())
    or assigned_to = (select auth.uid())
  );

create policy "Users can select events for visible tasks"
  on public.task_events
  for select
  using (
    exists (
      select 1
      from public.tasks t
      where t.id = task_events.task_id
        and (
          t.created_by = (select auth.uid())
          or t.assigned_to = (select auth.uid())
        )
    )
  );

create policy "Users can select own notifications"
  on public.notifications
  for select
  using (recipient_id = (select auth.uid()));
