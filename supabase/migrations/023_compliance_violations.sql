-- ============================================================================
-- 023_compliance_violations.sql — Compliance violations log
-- ============================================================================
-- Open or resolved compliance violations.
--
-- Dependencies: 002_companies.sql, 003_profiles.sql, 021_compliance_rules.sql

create table if not exists public.compliance_violations (
  id          uuid primary key default gen_random_uuid(),
  profile_id  uuid not null references public.profiles(id) on delete cascade,
  company_id  uuid not null references public.companies(id) on delete cascade,
  rule_id     uuid not null references public.compliance_rules(id) on delete cascade,
  severity    text not null check (severity in ('low', 'medium', 'high', 'critical')),
  status      text not null default 'open' check (status in ('open', 'acknowledged', 'resolved')),
  details     text,
  created_at  timestamptz not null default now(),
  resolved_at timestamptz
);

-- Index for scanning violations for members
create index if not exists compliance_violations_profile_status_idx
  on public.compliance_violations (profile_id, status);

-- Enable RLS
alter table public.compliance_violations enable row level security;

-- Comment
comment on table public.compliance_violations is 'Compliance violations logged for members breaching company rules.';

-- ============================================================================
-- Table: restructure_logs (audit log for network node reorganizations)
-- ============================================================================
create table if not exists public.restructure_logs (
  id                     uuid primary key default gen_random_uuid(),
  company_id             uuid not null references public.companies(id) on delete cascade,
  terminated_profile_id  uuid not null references public.profiles(id) on delete cascade,
  new_parent_id          uuid references public.profiles(id) on delete set null,
  children_moved         integer not null default 0 check (children_moved >= 0),
  before_tree            jsonb not null default '[]'::jsonb
                         check (jsonb_typeof(before_tree) = 'array'),
  after_tree             jsonb not null default '[]'::jsonb
                         check (jsonb_typeof(after_tree) = 'array'),
  created_at             timestamptz not null default now()
);

-- FK indexes: restructure_logs
create index if not exists restructure_logs_company_id_idx
  on public.restructure_logs (company_id);

create index if not exists restructure_logs_terminated_profile_id_idx
  on public.restructure_logs (terminated_profile_id);

create index if not exists restructure_logs_new_parent_id_idx
  on public.restructure_logs (new_parent_id);

alter table public.restructure_logs enable row level security;

-- ============================================================================
-- Table: audit_logs (generalized tenant-scoped action audit trail)
-- ============================================================================
create table if not exists public.audit_logs (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  actor_id    uuid references public.profiles(id) on delete set null,
  target_id   uuid,
  action      text not null check (char_length(trim(action)) > 0),
  entity_type text not null check (char_length(trim(entity_type)) > 0),
  before_data jsonb check (before_data is null or jsonb_typeof(before_data) = 'object'),
  after_data  jsonb check (after_data is null or jsonb_typeof(after_data) = 'object'),
  ip_address  inet,
  user_agent  text check (user_agent is null or char_length(trim(user_agent)) > 0),
  created_at  timestamptz not null default now()
);

-- FK & audit indexes: audit_logs
create index if not exists audit_logs_company_created_idx
  on public.audit_logs (company_id, created_at desc);

create index if not exists audit_logs_actor_created_idx
  on public.audit_logs (actor_id, created_at desc);

create index if not exists audit_logs_entity_action_idx
  on public.audit_logs (entity_type, action, created_at desc);

alter table public.audit_logs enable row level security;

