-- ============================================================================
-- 008_meetings.sql — Meetings table definition
-- ============================================================================
-- Video meetings powered by 100ms.
--
-- Dependencies: 002_companies.sql, 003_profiles.sql

-- Helper function to generate a unique 8-character alphanumeric meeting code
create or replace function public.generate_meeting_code()
returns text
language plpgsql
volatile
as $$
declare
  v_chars text := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  v_code text;
  v_ok boolean := false;
begin
  while not v_ok loop
    v_code := '';
    for i in 1..8 loop
      v_code := v_code || substr(v_chars, floor(random() * 36)::integer + 1, 1);
    end loop;
    select not exists (
      select 1 from public.meetings where meeting_code = v_code
    ) into v_ok;
  end loop;
  return v_code;
end;
$$;

create table if not exists public.meetings (
  id                        uuid primary key default gen_random_uuid(),
  company_id                uuid not null references public.companies(id) on delete cascade,
  leader_id                 uuid not null references public.profiles(id) on delete cascade,
  meeting_code              text not null unique default public.generate_meeting_code(),
  title                     text not null check (char_length(trim(title)) > 0),
  description               text check (description is null or char_length(trim(description)) > 0),
  agenda                    text check (agenda is null or char_length(trim(agenda)) > 0),
  meeting_url               text check (meeting_url is null or char_length(trim(meeting_url)) > 0),
  room_id                   text check (room_id is null or char_length(trim(room_id)) > 0),
  meeting_status            text not null default 'scheduled'
                            check (meeting_status in ('scheduled', 'live', 'completed', 'cancelled')),
  scheduled_at              timestamptz not null,
  started_at                timestamptz,
  ended_at                  timestamptz,
  duration_minutes          integer check (duration_minutes is null or duration_minutes >= 0),
  recording_enabled         boolean not null default false,
  recording_url             text check (recording_url is null or char_length(trim(recording_url)) > 0),
  late_join_allowed         boolean not null default true,
  late_join_cutoff_minutes  integer check (late_join_cutoff_minutes is null or late_join_cutoff_minutes >= 0),
  max_participants          integer check (max_participants is null or max_participants > 0),
  created_at                timestamptz not null default now(),
  updated_at                timestamptz not null default now(),
  -- Integrity constraint: started_at and ended_at consistency
  check (started_at is null or ended_at is null or started_at <= ended_at)
);

-- ============================================================================
-- Indexes
-- ============================================================================

-- FK index: company_id
create index if not exists meetings_company_id_idx
  on public.meetings (company_id);

-- FK index: leader_id
create index if not exists meetings_leader_id_idx
  on public.meetings (leader_id);

-- Dashboard query: "upcoming/scheduled meetings for my company"
create index if not exists meetings_company_status_scheduled_idx
  on public.meetings (company_id, meeting_status, scheduled_at desc);

-- Leader's meeting list filtered by status
create index if not exists meetings_leader_status_idx
  on public.meetings (leader_id, meeting_status);

-- Enable RLS
alter table public.meetings enable row level security;

-- ============================================================================
-- Triggers
-- ============================================================================

-- Trigger function for meeting status state machine
create or replace function public.validate_meeting_status_transition()
returns trigger
language plpgsql
as $$
begin
  if OLD.meeting_status <> NEW.meeting_status then
    -- Allowed transitions:
    -- scheduled -> live
    -- live -> completed
    -- scheduled -> cancelled
    if not (
      (OLD.meeting_status = 'scheduled' and NEW.meeting_status = 'live') or
      (OLD.meeting_status = 'live' and NEW.meeting_status = 'completed') or
      (OLD.meeting_status = 'scheduled' and NEW.meeting_status = 'cancelled')
    ) then
      raise exception 'Invalid meeting status transition from % to %', OLD.meeting_status, NEW.meeting_status;
    end if;
  end if;
  return NEW;
end;
$$;

drop trigger if exists check_meeting_status_transition on public.meetings;
create trigger check_meeting_status_transition
  before update on public.meetings
  for each row
  execute function public.validate_meeting_status_transition();

-- ============================================================================
-- Comments
-- ============================================================================

comment on table public.meetings is
  'Video meetings hosted by leaders, powered by 100ms.';
comment on column public.meetings.leader_id is
  'The leader/host profile of the meeting.';
comment on column public.meetings.room_id is
  '100ms Room ID. Null if HMS room creation failed or not initiated.';
comment on column public.meetings.recording_url is
  'URL to the meeting replay. Typically expires after 2 days per 100ms policy.';
