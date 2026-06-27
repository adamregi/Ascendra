-- ============================================================================
-- 024_compliance_snapshots.sql — Point-in-time compliance and health scores
-- ============================================================================
-- Immutable log of member compliance scores. Used for trending and AI analysis.
-- Always INSERT, never UPDATE.
--
-- Dependencies: 002_companies.sql, 003_profiles.sql

create table if not exists public.compliance_snapshots (
  id                  uuid primary key default gen_random_uuid(),
  profile_id          uuid not null references public.profiles(id) on delete cascade,
  company_id          uuid not null references public.companies(id) on delete cascade,
  attendance_score    numeric(5,2) not null check (attendance_score >= 0 and attendance_score <= 100),
  task_score          numeric(5,2) not null check (task_score >= 0 and task_score <= 100),
  followup_score      numeric(5,2) not null check (followup_score >= 0 and followup_score <= 100),
  compliance_score    numeric(5,2) not null check (compliance_score >= 0 and compliance_score <= 100),
  member_health_score numeric(5,2) not null check (member_health_score >= 0 and member_health_score <= 100),
  team_health_score   numeric(5,2) check (team_health_score >= 0 and team_health_score <= 100),
  snapshot_date       date not null default current_date,
  created_at          timestamptz not null default now()
);

-- Indexes for querying trends for a member or company
create index if not exists compliance_snapshots_profile_date_idx
  on public.compliance_snapshots (profile_id, snapshot_date desc);

create index if not exists compliance_snapshots_company_date_idx
  on public.compliance_snapshots (company_id, snapshot_date desc);

-- Enable RLS
alter table public.compliance_snapshots enable row level security;

-- Comment
comment on table public.compliance_snapshots is 'Immutable log of calculated point-in-time compliance and health scores for a member.';
