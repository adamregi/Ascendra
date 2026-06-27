-- ============================================================================
-- 010_meeting_questions.sql — Meeting Q&A questions
-- ============================================================================
-- Allows meeting participants to submit questions during live or recorded meetings.
--
-- Dependencies: 003_profiles.sql, 008_meetings.sql

create table if not exists public.meeting_questions (
  id           uuid primary key default gen_random_uuid(),
  meeting_id   uuid not null references public.meetings(id) on delete cascade,
  profile_id   uuid not null references public.profiles(id) on delete cascade,
  content      text not null check (char_length(trim(content)) > 0),
  is_anonymous boolean not null default false,
  created_at   timestamptz not null default now(),
  updated_at   timestamptz not null default now()
);

-- ============================================================================
-- Indexes
-- ============================================================================

-- FK index: meeting_id (frequent retrieval of all questions in a meeting)
create index if not exists meeting_questions_meeting_id_idx
  on public.meeting_questions (meeting_id);

-- FK index: profile_id (retrieval of questions asked by a specific participant)
create index if not exists meeting_questions_profile_id_idx
  on public.meeting_questions (profile_id);

-- Enable RLS
alter table public.meeting_questions enable row level security;

-- ============================================================================
-- Comments
-- ============================================================================

comment on table public.meeting_questions is
  'Q&A questions asked by meeting participants.';
comment on column public.meeting_questions.is_anonymous is
  'If true, the asker profile name is hidden in public views (though audited in DB).';
comment on column public.meeting_questions.profile_id is
  'The profile ID of the participant who asked the question.';
