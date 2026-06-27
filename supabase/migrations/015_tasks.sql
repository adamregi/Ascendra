-- ============================================================================
-- 015_tasks.sql — Tasks created by leaders
-- ============================================================================
-- Core task entity representing work item definitions created by leaders.
--
-- Dependencies: 002_companies.sql, 003_profiles.sql

create table if not exists public.tasks (
  id           uuid primary key default gen_random_uuid(),
  company_id   uuid not null references public.companies(id) on delete cascade,
  leader_id    uuid not null references public.profiles(id) on delete cascade,
  title        text not null check (char_length(trim(title)) > 0),
  description  text check (description is null or char_length(trim(description)) > 0),
  status       text not null default 'draft'
               check (status in ('draft', 'assigned', 'active', 'completed', 'cancelled')),
  priority     text not null default 'normal'
               check (priority in ('low', 'normal', 'high', 'urgent')),
  due_date     timestamptz,
  created_at   timestamptz not null default now(),
  updated_at   timestamptz not null default now()
);

-- ============================================================================
-- Indexes
-- ============================================================================

-- FK index: company_id
create index if not exists tasks_company_id_idx
  on public.tasks (company_id);

-- FK index: leader_id
create index if not exists tasks_leader_id_idx
  on public.tasks (leader_id);

-- Company-wide task dashboard index
create index if not exists tasks_company_status_idx
  on public.tasks (company_id, status);

-- Enable RLS
alter table public.tasks enable row level security;

-- ============================================================================
-- Comments
-- ============================================================================

comment on table public.tasks is
  'Task definitions created by leaders in a company.';
comment on column public.tasks.status is
  'Lifecycle: draft → assigned → active → completed | cancelled.';
comment on column public.tasks.priority is
  'Task urgency/priority: low, normal, high, urgent.';
