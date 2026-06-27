-- ============================================================================
-- 022_compliance_events.sql — Compliance immutable events log
-- ============================================================================
-- Immutable log of compliance-related events.
--
-- Dependencies: 002_companies.sql, 003_profiles.sql

create table if not exists public.compliance_events (
  id          uuid primary key default gen_random_uuid(),
  profile_id  uuid not null references public.profiles(id) on delete cascade,
  company_id  uuid not null references public.companies(id) on delete cascade,
  event_type  text not null check (event_type in ('missed_meeting', 'partial_attendance', 'task_overdue', 'inactive', 'followup_missed')),
  event_value text,
  source_id   uuid not null,
  occurred_at timestamptz not null default now()
);

-- Index for querying events chronologically per member
create index if not exists compliance_events_profile_occurred_idx
  on public.compliance_events (profile_id, occurred_at desc);

-- Enable RLS
alter table public.compliance_events enable row level security;

-- Comment
comment on table public.compliance_events is 'Immutable audit trail of member compliance events.';
