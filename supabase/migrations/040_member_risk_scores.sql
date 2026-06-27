-- ============================================================================
-- 040_member_risk_scores.sql — Current member risk scores
-- ============================================================================

create table if not exists public.member_risk_scores (
  profile_id uuid primary key references public.profiles(id) on delete cascade,
  company_id uuid not null references public.companies(id) on delete cascade,
  
  attendance_trend numeric(5,2),
  task_trend numeric(5,2),
  compliance_trend numeric(5,2),
  activity_trend numeric(5,2),
  
  risk_score numeric(5,2),
  risk_level text check (risk_level in ('low', 'medium', 'high', 'critical')),
  
  last_calculated_at timestamptz not null default now()
);

create index if not exists member_risk_company_level_idx on public.member_risk_scores(company_id, risk_level);

alter table public.member_risk_scores enable row level security;
