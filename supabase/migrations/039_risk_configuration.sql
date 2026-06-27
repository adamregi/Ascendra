-- ============================================================================
-- 039_risk_configuration.sql — Risk weight configuration
-- ============================================================================

create table if not exists public.risk_configuration (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  attendance_weight numeric(5,2) not null default 35.0,
  task_weight numeric(5,2) not null default 25.0,
  compliance_weight numeric(5,2) not null default 25.0,
  activity_weight numeric(5,2) not null default 15.0,
  is_active boolean not null default true,
  effective_from timestamptz not null default now(),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Index for querying active config
create index if not exists risk_config_company_active_idx on public.risk_configuration(company_id, is_active);

-- Enable RLS
alter table public.risk_configuration enable row level security;
