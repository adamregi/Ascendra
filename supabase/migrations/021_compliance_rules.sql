-- ============================================================================
-- 021_compliance_rules.sql — Compliance rule definitions
-- ============================================================================
-- Company-specific policy definitions for member evaluations.
--
-- Dependencies: 002_companies.sql

create table if not exists public.compliance_rules (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  rule_type   text not null check (rule_type in ('attendance_percentage', 'overdue_tasks', 'inactive_days', 'open_followups')),
  threshold   integer not null check (threshold >= 0),
  severity    text not null check (severity in ('low', 'medium', 'high', 'critical')),
  enabled     boolean not null default true,
  description text,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now(),
  unique (company_id, rule_type)
);

-- Enable RLS
alter table public.compliance_rules enable row level security;

-- Comment
comment on table public.compliance_rules is 'Parameters governing membership compliance evaluations.';
