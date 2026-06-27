-- ============================================================================
-- 009_meeting_attendances.sql — Meeting attendance tracking
-- ============================================================================
-- Scopes registrations and session summaries per participant per meeting.
--
-- Dependencies: 003_profiles.sql, 008_meetings.sql

create table if not exists public.meeting_attendances (
  id                      uuid primary key default gen_random_uuid(),
  meeting_id              uuid not null references public.meetings(id) on delete cascade,
  profile_id              uuid not null references public.profiles(id) on delete cascade,
  first_joined_at         timestamptz,
  last_left_at            timestamptz,
  total_duration_minutes  integer not null default 0 check (total_duration_minutes >= 0),
  attendance_percentage   numeric(5,2) not null default 0 check (attendance_percentage between 0 and 100),
  attendance_status       text not null default 'registered'
                          check (attendance_status in ('registered', 'attended', 'partial', 'absent', 'excused')),
  created_at              timestamptz not null default now(),
  updated_at              timestamptz not null default now(),
  -- Ensure only one attendance record per profile per meeting
  constraint meeting_attendances_unique unique (meeting_id, profile_id)
);

-- ============================================================================
-- Indexes
-- ============================================================================

-- FK index: meeting_id
create index if not exists meeting_attendances_meeting_id_idx
  on public.meeting_attendances (meeting_id);

-- FK index: profile_id
create index if not exists meeting_attendances_profile_id_idx
  on public.meeting_attendances (profile_id);

-- Query index for dashboard attendance status lookup
create index if not exists meeting_attendances_meeting_status_idx
  on public.meeting_attendances (meeting_id, attendance_status);

-- Enable RLS
alter table public.meeting_attendances enable row level security;
