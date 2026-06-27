-- ============================================================================
-- 011_meeting_answers.sql — Meeting Q&A answers
-- ============================================================================
-- Allows meeting hosts/leaders or allowed participants to answer submitted questions.
--
-- Dependencies: 003_profiles.sql, 010_meeting_questions.sql

create table if not exists public.meeting_answers (
  id          uuid primary key default gen_random_uuid(),
  question_id uuid not null references public.meeting_questions(id) on delete cascade,
  profile_id  uuid not null references public.profiles(id) on delete cascade,
  content     text not null check (char_length(trim(content)) > 0),
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);

-- ============================================================================
-- Indexes
-- ============================================================================

-- FK index: question_id (retrieve answers for a specific question)
create index if not exists meeting_answers_question_id_idx
  on public.meeting_answers (question_id);

-- FK index: profile_id (retrieve answers by a specific responder)
create index if not exists meeting_answers_profile_id_idx
  on public.meeting_answers (profile_id);

-- Enable RLS
alter table public.meeting_answers enable row level security;

-- ============================================================================
-- Comments
-- ============================================================================

comment on table public.meeting_answers is
  'Answers given to Q&A questions asked during meetings.';
comment on column public.meeting_answers.question_id is
  'The question this record answers.';
comment on column public.meeting_answers.profile_id is
  'The profile ID of the responder (typically a host/leader).';
