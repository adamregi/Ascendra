-- ============================================================================
-- 002_companies.sql — The root tenant entity
-- ============================================================================
-- Every record in the system belongs to a company.
-- The owner_id FK to profiles is added in 003_profiles.sql as DEFERRABLE
-- because creating a company and its leader profile is a chicken-and-egg problem.
--
-- Dependencies: 001_extensions.sql

create table if not exists public.companies (
  id         uuid primary key default gen_random_uuid(),
  name       text not null check (char_length(trim(name)) > 0),
  slug       text not null
             check (char_length(trim(slug)) > 0)
             check (slug ~ '^[a-z0-9]([a-z0-9-]*[a-z0-9])?$'),
  owner_id   uuid not null,  -- FK added in 003_profiles.sql (circular dependency)
  logo_url   text,
  settings   jsonb not null default '{}'::jsonb
             check (jsonb_typeof(settings) = 'object'),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Slug must be unique (case-insensitive)
create unique index if not exists companies_slug_unique_idx
  on public.companies (lower(slug));

-- FK index: owner_id (PostgreSQL does NOT auto-index FKs)
create index if not exists companies_owner_id_idx
  on public.companies (owner_id);

-- ============================================================================
-- Table: company_settings
-- ============================================================================
create table if not exists public.company_settings (
  id                                uuid primary key default gen_random_uuid(),
  company_id                        uuid not null references public.companies(id) on delete cascade,
  auto_terminate                    boolean not null default true,
  meeting_reminder_minutes          integer not null default 15 check (meeting_reminder_minutes >= 0),
  default_meeting_duration_minutes  integer not null default 60 check (default_meeting_duration_minutes >= 0),
  max_tree_depth                    integer not null default 50 check (max_tree_depth > 0),
  allow_member_invites              boolean not null default false,
  timezone                          text not null default 'UTC' check (char_length(trim(timezone)) > 0),
  minimum_attended_percentage       integer not null default 90 check (minimum_attended_percentage between 0 and 100),
  minimum_partial_percentage        integer not null default 75 check (minimum_partial_percentage between 0 and 100),
  created_at                        timestamptz not null default now(),
  updated_at                        timestamptz not null default now(),
  constraint company_settings_company_unique unique (company_id),
  constraint company_settings_thresholds_check check (minimum_partial_percentage <= minimum_attended_percentage)
);

-- FK index: company_id
create index if not exists company_settings_company_id_idx
  on public.company_settings (company_id);

-- Enable RLS
alter table public.companies enable row level security;
alter table public.company_settings enable row level security;

-- Comments
comment on table public.companies is
  'Root tenant entity. All data is scoped to a company.';
comment on column public.companies.owner_id is
  'The leader who created this company. FK deferred for circular insert.';
comment on column public.companies.slug is
  'URL-safe identifier. Lowercase alphanumeric + hyphens only. Unique (case-insensitive).';
comment on column public.companies.settings is
  'Company-level configuration (JSON object). Structured settings in company_settings table.';
comment on table public.company_settings is
  'Per-company settings and business configuration parameters.';
