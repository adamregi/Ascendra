-- ============================================================================
-- 018_followups.sql — Follow-up reminders scheduled by leaders
-- ============================================================================
-- Allows leaders to schedule and log follow-ups for downline members.
--
-- Dependencies: 002_companies.sql, 003_profiles.sql

create table if not exists public.followups (
  id             uuid primary key default gen_random_uuid(),
  company_id     uuid not null references public.companies(id) on delete cascade,
  leader_id      uuid not null references public.profiles(id) on delete cascade,
  member_id      uuid not null references public.profiles(id) on delete cascade,
  reason_type    text not null
                 check (reason_type in ('missed_meeting', 'overdue_task', 'inactive', 'manual')),
  reason         text not null check (char_length(trim(reason)) > 0),
  notes          text check (notes is null or char_length(trim(notes)) > 0),
  due_date       timestamptz,
  status         text not null default 'open'
                 check (status in ('open', 'in_progress', 'completed', 'cancelled')),
  created_at     timestamptz not null default now(),
  updated_at     timestamptz not null default now()
);

-- ============================================================================
-- Indexes
-- ============================================================================

-- FK index: company_id
create index if not exists followups_company_id_idx
  on public.followups (company_id);

-- FK index: leader_id
create index if not exists followups_leader_id_idx
  on public.followups (leader_id);

-- FK index: member_id
create index if not exists followups_member_id_idx
  on public.followups (member_id);

-- Index for cron jobs / queries searching pending followups
create index if not exists followups_status_date_idx
  on public.followups (status, due_date)
  where status in ('open', 'in_progress');

-- Enable RLS
alter table public.followups enable row level security;

-- ============================================================================
-- Comments
-- ============================================================================

comment on table public.followups is
  'Follow-up reminders scheduled and logged by leaders for contacting downline members.';
comment on column public.followups.reason_type is
  'Categorized reason for follow-up: missed_meeting, overdue_task, inactive, or manual.';
comment on column public.followups.status is
  'Follow-up progress status: open, in_progress, completed, or cancelled.';
