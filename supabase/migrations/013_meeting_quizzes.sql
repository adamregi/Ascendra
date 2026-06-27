-- ============================================================================
-- 012_meeting_quizzes.sql — Post-meeting quizzes, questions, and responses
-- ============================================================================
-- Allows leaders to create multi-choice quizzes for meetings to assess
-- member understanding, and tracks member score submissions.
--
-- Dependencies: 003_profiles.sql, 008_meetings.sql

-- ============================================================================
-- Table: meeting_quizzes
-- ============================================================================
create table if not exists public.meeting_quizzes (
  id                uuid primary key default gen_random_uuid(),
  meeting_id        uuid not null references public.meetings(id) on delete cascade,
  title             text not null check (char_length(trim(title)) > 0),
  description       text check (description is null or char_length(trim(description)) > 0),
  passing_score_pct integer not null default 60
                    check (passing_score_pct >= 0 and passing_score_pct <= 100),
  created_at        timestamptz not null default now(),
  updated_at        timestamptz not null default now()
);

-- ============================================================================
-- Table: quiz_questions
-- ============================================================================
create table if not exists public.quiz_questions (
  id                   uuid primary key default gen_random_uuid(),
  quiz_id              uuid not null references public.meeting_quizzes(id) on delete cascade,
  question_text        text not null check (char_length(trim(question_text)) > 0),
  options              jsonb not null check (jsonb_typeof(options) = 'array'),
  correct_option_index integer not null check (correct_option_index >= 0),
  points               integer not null default 1 check (points >= 0),
  created_at           timestamptz not null default now(),
  updated_at           timestamptz not null default now()
);

-- ============================================================================
-- Table: quiz_responses
-- ============================================================================
create table if not exists public.quiz_responses (
  id           uuid primary key default gen_random_uuid(),
  quiz_id      uuid not null references public.meeting_quizzes(id) on delete cascade,
  profile_id   uuid not null references public.profiles(id) on delete cascade,
  answers      jsonb not null check (jsonb_typeof(answers) = 'object'),
  score_pct    numeric(5, 2) not null check (score_pct >= 0.00 and score_pct <= 100.00),
  passed       boolean not null,
  submitted_at timestamptz not null default now(),
  -- Enforce only one response attempt per member per quiz
  constraint quiz_responses_unique_user unique (quiz_id, profile_id)
);

-- ============================================================================
-- Indexes
-- ============================================================================

-- FK index on meeting_quizzes
create index if not exists meeting_quizzes_meeting_id_idx
  on public.meeting_quizzes (meeting_id);

-- FK index on quiz_questions
create index if not exists quiz_questions_quiz_id_idx
  on public.quiz_questions (quiz_id);

-- FK indexes on quiz_responses
create index if not exists quiz_responses_quiz_id_idx
  on public.quiz_responses (quiz_id);

create index if not exists quiz_responses_profile_id_idx
  on public.quiz_responses (profile_id);

-- Enable RLS
alter table public.meeting_quizzes enable row level security;
alter table public.quiz_questions enable row level security;
alter table public.quiz_responses enable row level security;

-- ============================================================================
-- Comments
-- ============================================================================

comment on table public.meeting_quizzes is
  'Quizzes created by leaders for meetings to test member comprehension.';
comment on table public.quiz_questions is
  'Multiple-choice questions linked to a specific quiz.';
comment on column public.quiz_questions.options is
  'JSONB array of option text strings, e.g. ["Option A", "Option B"].';
comment on table public.quiz_responses is
  'Member quiz submission records containing answers, score, and pass/fail result.';
comment on column public.quiz_responses.answers is
  'JSONB object mapping quiz_question.id (as key) to selected_option_index (as integer).';
