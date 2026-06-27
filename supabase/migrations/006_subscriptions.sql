-- ============================================================================
-- 006_subscriptions.sql — Leader ↔ Plan binding
-- ============================================================================
-- Business rules:
--   1. One leader = ONE active subscription (enforced by partial unique index)
--   2. Upgrade allowed (higher member_limit)
--   3. Downgrade blocked (enforced in application layer)
--   4. Expired subscription: user can login but cannot use business features
--   5. leader_id must reference a profile with role='leader'
--      (enforced by validate_subscription_leader trigger in 017_triggers.sql)
--
-- Dependencies: 003_profiles.sql, 005_subscription_plans.sql

create table if not exists public.subscriptions (
  id           uuid primary key default gen_random_uuid(),
  leader_id    uuid not null references public.profiles(id) on delete cascade,
  plan_id      uuid not null references public.subscription_plans(id) on delete restrict,
  status       text not null default 'active'
               check (status in ('active', 'expired', 'cancelled')),
  started_at   timestamptz not null default now(),
  expires_at   timestamptz not null,
  renewed_at   timestamptz,
  cancelled_at timestamptz,
  created_at   timestamptz not null default now(),
  updated_at   timestamptz not null default now()
);

-- ============================================================================
-- Indexes
-- ============================================================================

-- One active subscription per leader (partial unique index)
-- This is the database-level enforcement of the "one active sub" rule.
create unique index if not exists subscriptions_leader_active_unique_idx
  on public.subscriptions (leader_id)
  where status = 'active';

-- FK index: leader_id
create index if not exists subscriptions_leader_id_idx
  on public.subscriptions (leader_id);

-- FK index: plan_id
create index if not exists subscriptions_plan_id_idx
  on public.subscriptions (plan_id);

-- Index for finding expired subscriptions (cron job)
create index if not exists subscriptions_status_expires_idx
  on public.subscriptions (status, expires_at)
  where status = 'active';

-- ============================================================================
-- RLS
-- ============================================================================

alter table public.subscriptions enable row level security;

-- ============================================================================
-- Comments
-- ============================================================================

comment on table public.subscriptions is
  'Leader subscription. One active per leader. Controls feature access.';
comment on column public.subscriptions.leader_id is
  'Must reference a leader-role profile. Enforced by validate_subscription_leader trigger.';
comment on column public.subscriptions.status is
  'active=paid, expired=billing ended, cancelled=leader cancelled. Separate from profile status.';
comment on column public.subscriptions.expires_at is
  'End of billing period. Cron job marks as expired when past.';

-- Why ON DELETE RESTRICT for plan_id:
-- Never delete a plan that has active subscriptions.
-- Retire plans by setting is_active = false instead.
