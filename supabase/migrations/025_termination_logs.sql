-- ============================================================================
-- 025_termination_logs.sql — Audit trail for manual profile terminations
-- ============================================================================
-- Tracks when a member is manually terminated by a leader, and the subsequent
-- network tree restructure.
--
-- Dependencies: 002_companies.sql, 003_profiles.sql

create table if not exists public.termination_logs (
  id                    uuid primary key default gen_random_uuid(),
  profile_id            uuid not null references public.profiles(id) on delete cascade,
  company_id            uuid not null references public.companies(id) on delete cascade,
  terminator_id         uuid not null references public.profiles(id) on delete cascade,
  reason                text not null check (char_length(trim(reason)) > 0),
  parent_reassigned_to  uuid references public.profiles(id) on delete set null,
  restructured_at       timestamptz,
  created_at            timestamptz not null default now()
);

-- Indexes for querying terminations
create index if not exists termination_logs_profile_idx
  on public.termination_logs (profile_id);

create index if not exists termination_logs_company_date_idx
  on public.termination_logs (company_id, created_at desc);

-- Enable RLS
alter table public.termination_logs enable row level security;

-- Comment
comment on table public.termination_logs is 'Audit trail of manual profile terminations, including the reassignment of their downline.';
