-- ============================================================================
-- 003_profiles.sql — User identity within the organization
-- ============================================================================
-- Maps 1:1 to auth.users AFTER onboarding is complete.
-- Invited profiles exist BEFORE the auth user is created.
-- auth_user_id is nullable because invited profiles don't have one yet.
--
-- Dependencies: 001_extensions.sql, 002_companies.sql
-- Resolves: circular FK between companies ↔ profiles

create table if not exists public.profiles (
  id              uuid primary key default gen_random_uuid(),
  auth_user_id    uuid unique references auth.users(id) on delete set null,
  company_id      uuid not null,  -- FK to companies (deferred, added below)
  distributor_id  text not null check (char_length(trim(distributor_id)) > 0),
  full_name       text not null check (char_length(trim(full_name)) > 0),
  phone           text not null check (char_length(trim(phone)) > 0),
  email           text check (email is null or email ~* '^[^@\s]+@[^@\s]+\.[^@\s]+$'),
  avatar_url      text,
  role            text not null check (role in ('leader', 'member')),
  status          text not null default 'invited'
                  check (status in ('invited', 'active', 'warned', 'suspended', 'terminated')),
  warned_at       timestamptz,
  suspended_at    timestamptz,
  terminated_at   timestamptz,
  created_at      timestamptz not null default now(),
  updated_at      timestamptz not null default now()
);

-- ============================================================================
-- Indexes
-- ============================================================================

-- Distributor ID must be unique within a company
create unique index if not exists profiles_company_distributor_unique_idx
  on public.profiles (company_id, lower(distributor_id));

-- Phone must be globally unique (one phone = one person across all companies)
create unique index if not exists profiles_phone_unique_idx
  on public.profiles (phone);

-- FK index: company_id (PostgreSQL does NOT auto-index FKs)
create index if not exists profiles_company_id_idx
  on public.profiles (company_id);

-- Composite index for dashboard queries: "show me active leaders in company X"
create index if not exists profiles_company_role_status_idx
  on public.profiles (company_id, role, status);

-- Index for auth user lookup (login flow)
-- Partial index: only index non-null values to save space
create index if not exists profiles_auth_user_id_idx
  on public.profiles (auth_user_id)
  where auth_user_id is not null;

-- ============================================================================
-- Circular FK Resolution: companies ↔ profiles
-- ============================================================================
-- Both FKs use DEFERRABLE INITIALLY DEFERRED so they are checked at
-- transaction commit, not at statement execution. This allows
-- create_company_atomic() to insert both records in one transaction.

-- FK: profiles.company_id → companies.id
alter table public.profiles
  add constraint profiles_company_id_fkey
  foreign key (company_id) references public.companies(id) on delete restrict
  deferrable initially deferred;

-- FK: companies.owner_id → profiles.id
alter table public.companies
  add constraint companies_owner_id_fkey
  foreign key (owner_id) references public.profiles(id) on delete restrict
  deferrable initially deferred;

-- ============================================================================
-- RLS
-- ============================================================================

alter table public.profiles enable row level security;

-- ============================================================================
-- Comments
-- ============================================================================

comment on table public.profiles is
  'User identity. Exists before auth user for invited members.';
comment on column public.profiles.id is
  'Profile UUID — NOT the same as auth.users.id for invited profiles.';
comment on column public.profiles.auth_user_id is
  'Linked after member completes onboarding. NULL for invited profiles.';
comment on column public.profiles.distributor_id is
  'Business identity (like employee number). Unique per company.';
comment on column public.profiles.phone is
  'Globally unique. Used for OTP verification. One phone = one person.';
comment on column public.profiles.status is
  'Lifecycle: invited → active → warned → suspended → terminated';
