-- ============================================================================
-- 010_meeting_sessions.sql — Meeting rejoin and session tracking
-- ============================================================================
-- Tracks individual join and leave segments per participant.
-- Calculates aggregated duration/percentage at the database level.
--
-- Dependencies: 009_meeting_attendances.sql

create table if not exists public.meeting_sessions (
  id                uuid primary key default gen_random_uuid(),
  attendance_id     uuid not null references public.meeting_attendances(id) on delete cascade,
  joined_at         timestamptz not null default now(),
  left_at           timestamptz,
  duration_minutes  integer check (duration_minutes is null or duration_minutes >= 0),
  join_source       text not null default 'mobile' check (join_source in ('mobile', 'web', 'desktop')),
  created_at        timestamptz not null default now(),
  -- Integrity constraint: joined_at must be before or equal to left_at
  check (left_at is null or joined_at <= left_at)
);

-- ============================================================================
-- Indexes
-- ============================================================================

-- FK index
create index if not exists meeting_sessions_attendance_id_idx
  on public.meeting_sessions (attendance_id);

-- Enable RLS
alter table public.meeting_sessions enable row level security;

grant select on public.meeting_sessions to authenticated;


-- ============================================================================
-- Triggers & Calculation Logic
-- ============================================================================

-- 1. BEFORE UPDATE Trigger on Sessions: set session duration
create or replace function public.calculate_session_duration()
returns trigger
language plpgsql
as $$
begin
  if NEW.left_at is not null then
    NEW.duration_minutes := coalesce(
      round(extract(epoch from (NEW.left_at - NEW.joined_at)) / 60.0)::integer,
      0
    );
    if NEW.duration_minutes < 0 then
      NEW.duration_minutes := 0;
    end if;
  else
    NEW.duration_minutes := null;
  end if;
  return NEW;
end;
$$;

drop trigger if exists set_session_duration on public.meeting_sessions;
create trigger set_session_duration
  before update on public.meeting_sessions
  for each row
  execute function public.calculate_session_duration();

-- 2. AFTER INSERT OR UPDATE Trigger on Sessions: update parent stats
create or replace function public.update_attendance_stats()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  v_attendance record;
  v_meeting record;
  v_total_dur integer;
  v_first_join timestamptz;
  v_last_leave timestamptz;
  v_elapsed_minutes numeric;
  v_percentage numeric;
  v_attended_threshold integer;
  v_partial_threshold integer;
  v_new_status text;
begin
  -- Lock parent attendance row
  select * into v_attendance
  from public.meeting_attendances
  where id = NEW.attendance_id
  for update;

  -- Fetch meeting details
  select * into v_meeting
  from public.meetings
  where id = v_attendance.meeting_id;

  -- Calculate aggregate session times
  select
    coalesce(sum(duration_minutes), 0)::integer,
    min(joined_at),
    max(left_at)
  into
    v_total_dur,
    v_first_join,
    v_last_leave
  from public.meeting_sessions
  where attendance_id = NEW.attendance_id;

  -- Calculate actual meeting duration
  v_elapsed_minutes := 0;
  if v_meeting.meeting_status = 'completed' and v_meeting.started_at is not null and v_meeting.ended_at is not null then
    v_elapsed_minutes := extract(epoch from (v_meeting.ended_at - v_meeting.started_at)) / 60.0;
  elsif v_meeting.meeting_status = 'live' and v_meeting.started_at is not null then
    v_elapsed_minutes := extract(epoch from (now() - v_meeting.started_at)) / 60.0;
  end if;

  -- Calculate percentage
  v_percentage := 0;
  if v_elapsed_minutes > 0 then
    v_percentage := round(((v_total_dur::numeric / v_elapsed_minutes) * 100.0), 2);
    if v_percentage > 100.00 then
      v_percentage := 100.00;
    end if;
  end if;

  -- Look up company thresholds
  select
    minimum_attended_percentage,
    minimum_partial_percentage
  into
    v_attended_threshold,
    v_partial_threshold
  from public.company_settings
  where company_id = v_meeting.company_id;

  if v_attended_threshold is null then
    v_attended_threshold := 90;
  end if;
  if v_partial_threshold is null then
    v_partial_threshold := 75;
  end if;

  -- Determine new status if not excused
  v_new_status := v_attendance.attendance_status;
  if v_attendance.attendance_status <> 'excused' then
    if v_percentage >= v_attended_threshold then
      v_new_status := 'attended';
    elsif v_percentage >= v_partial_threshold then
      v_new_status := 'partial';
    else
      v_new_status := 'absent';
    end if;
  end if;

  -- Update parent attendance record
  update public.meeting_attendances
  set
    first_joined_at = v_first_join,
    last_left_at = v_last_leave,
    total_duration_minutes = v_total_dur,
    attendance_percentage = v_percentage,
    attendance_status = v_new_status,
    updated_at = now()
  where id = NEW.attendance_id;

  return null;
end;
$$;

drop trigger if exists recalculate_attendance_stats on public.meeting_sessions;
create trigger recalculate_attendance_stats
  after insert or update on public.meeting_sessions
  for each row
  execute function public.update_attendance_stats();

-- 3. AFTER UPDATE Trigger on Meetings: handle meeting completion and recalculate final stats
create or replace function public.handle_meeting_completion()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  v_attended_threshold integer;
  v_partial_threshold integer;
  v_meeting_duration numeric;
  v_att record;
begin
  if OLD.meeting_status <> NEW.meeting_status and NEW.meeting_status = 'completed' then
    -- Calculate actual meeting duration
    v_meeting_duration := 0;
    if NEW.started_at is not null and NEW.ended_at is not null then
      v_meeting_duration := extract(epoch from (NEW.ended_at - NEW.started_at)) / 60.0;
    end if;

    -- Get company thresholds
    select
      minimum_attended_percentage,
      minimum_partial_percentage
    into
      v_attended_threshold,
      v_partial_threshold
    from public.company_settings
    where company_id = NEW.company_id;

    if v_attended_threshold is null then
      v_attended_threshold := 90;
    end if;
    if v_partial_threshold is null then
      v_partial_threshold := 75;
    end if;

    -- Update registered members to absent
    update public.meeting_attendances
    set attendance_status = 'absent',
        updated_at = now()
    where meeting_id = NEW.id
      and attendance_status = 'registered';

    -- Re-evaluate and update stats for all members who did join
    for v_att in
      select * from public.meeting_attendances
      where meeting_id = NEW.id
        and attendance_status <> 'excused'
        and attendance_status <> 'registered'
    loop
      declare
        v_total_dur integer;
        v_percentage numeric := 0;
        v_new_status text;
      begin
        select coalesce(sum(duration_minutes), 0)::integer
        into v_total_dur
        from public.meeting_sessions
        where attendance_id = v_att.id;

        if v_meeting_duration > 0 then
          v_percentage := round(((v_total_dur::numeric / v_meeting_duration) * 100.0), 2);
          if v_percentage > 100.00 then
            v_percentage := 100.00;
          end if;
        end if;

        if v_percentage >= v_attended_threshold then
          v_new_status := 'attended';
        elsif v_percentage >= v_partial_threshold then
          v_new_status := 'partial';
        else
          v_new_status := 'absent';
        end if;

        update public.meeting_attendances
        set
          attendance_percentage = v_percentage,
          attendance_status = v_new_status,
          updated_at = now()
        where id = v_att.id;
      end;
    end loop;
  end if;
  return NEW;
end;
$$;

drop trigger if exists on_meeting_completion on public.meetings;
create trigger on_meeting_completion
  after update on public.meetings
  for each row
  execute function public.handle_meeting_completion();
