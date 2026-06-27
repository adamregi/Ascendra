-- ============================================================================
-- 007_invitations.sql — Leader invites member
-- ============================================================================
-- The entry point for every new member.
--
-- Two-phase design:
--   Phase A (invitation created):
--     Leader fills in distributor_id, full_name, phone.
--     A profile (status='invited') is created alongside the invitation.
--     The profile_id links to the pre-created profile.
--
--   Phase B (invitation accepted):
--     Member opens link → verifies OTP → sets password.
--     Supabase auth user is created.
--     Profile auth_user_id is linked, status → active.
--     Invitation status → accepted.
--
-- The distributor_id, full_name, phone columns on this table are the
-- leader's ORIGINAL input. They are copied to the profile at creation.
-- If the profile is later updated, the invitation retains the original values
-- (audit trail of what the leader actually submitted).
--
-- Dependencies: 002_companies.sql, 003_profiles.sql

create table if not exists public.invitations (
  id              uuid primary key default gen_random_uuid(),
  inviter_id      uuid not null references public.profiles(id) on delete cascade,
  profile_id      uuid not null references public.profiles(id) on delete cascade,
  company_id      uuid not null references public.companies(id) on delete cascade,
  distributor_id  text not null check (char_length(trim(distributor_id)) > 0),
  full_name       text not null check (char_length(trim(full_name)) > 0),
  phone           text not null check (char_length(trim(phone)) > 0),
  status          text not null default 'pending'
                  check (status in ('pending', 'accepted', 'expired', 'cancelled')),
  invited_at      timestamptz not null default now(),
  expires_at      timestamptz,
  accepted_at     timestamptz,
  cancelled_at    timestamptz
);

-- ============================================================================
-- Indexes
-- ============================================================================

-- FK indexes
create index if not exists invitations_inviter_id_idx
  on public.invitations (inviter_id);

create index if not exists invitations_profile_id_idx
  on public.invitations (profile_id);

create index if not exists invitations_company_id_idx
  on public.invitations (company_id);

-- Index for finding pending invitations (plan usage calculation)
create index if not exists invitations_company_status_idx
  on public.invitations (company_id, status)
  where status = 'pending';

-- Index for expiry cron job
create index if not exists invitations_status_expires_idx
  on public.invitations (status, expires_at)
  where status = 'pending' and expires_at is not null;

-- ============================================================================
-- RLS
-- ============================================================================

alter table public.invitations enable row level security;

-- ============================================================================
-- Comments
-- ============================================================================

comment on table public.invitations is
  'Leader-to-member invitation. Creates an invited profile alongside.';
comment on column public.invitations.profile_id is
  'The pre-created profile (status=invited) for the prospective member.';
comment on column public.invitations.inviter_id is
  'The leader who created this invitation.';
comment on column public.invitations.distributor_id is
  'Original distributor ID submitted by the leader. Copied to profiles at creation.';
comment on column public.invitations.full_name is
  'Original member name submitted by the leader. Copied to profiles at creation.';
comment on column public.invitations.phone is
  'Original phone submitted by the leader. Used for OTP verification.';

-- Why ON DELETE CASCADE for inviter_id and profile_id:
-- If the leader or invited profile is deleted, the invitation is meaningless.
