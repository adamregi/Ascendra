-- ============================================================================
-- 005_subscription_plans.sql — Plan catalog with feature flags
-- ============================================================================
-- Read-only reference table. Rows added by admin, not by users.
-- No FK dependencies — safe to create early.
--
-- Dependencies: 001_extensions.sql

create table if not exists public.subscription_plans (
  id                 uuid primary key default gen_random_uuid(),
  name               text not null unique check (char_length(trim(name)) > 0),
  member_limit       integer not null check (member_limit > 0),
  ai_enabled         boolean not null default true,
  analytics_enabled  boolean not null default false,
  price              numeric(10, 2) not null check (price >= 0),
  is_active          boolean not null default true,
  created_at         timestamptz not null default now()
);

-- Enable RLS
alter table public.subscription_plans enable row level security;

-- Seed the three standard plans
insert into public.subscription_plans (name, member_limit, ai_enabled, analytics_enabled, price)
values
  ('Starter',    50,  true, false, 0.00),
  ('Pro',        100, true, true,  0.00),
  ('Enterprise', 200, true, true,  0.00)
on conflict (name) do nothing;

-- Comments
comment on table public.subscription_plans is
  'Plan catalog. Starter(50), Pro(100), Enterprise(200). Extensible for custom plans.';
comment on column public.subscription_plans.member_limit is
  'Max members under this plan. Usage = active + invited profiles.';
comment on column public.subscription_plans.price is
  'Monthly price. Set to 0 during beta. Use NUMERIC(10,2) — never float for money.';
comment on column public.subscription_plans.is_active is
  'False = plan is retired and cannot be selected for new subscriptions.';
