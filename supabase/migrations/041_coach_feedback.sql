-- ============================================================================
-- 041_coach_feedback.sql — RLHF for AI Coach
-- ============================================================================

create table if not exists public.coach_feedback (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  profile_id uuid not null references public.profiles(id) on delete cascade,
  insight_id uuid references public.coach_insights(id) on delete cascade,
  recommendation_id uuid references public.ai_recommendations(id) on delete cascade,
  feedback_type text not null check (feedback_type in ('helpful', 'not_helpful', 'dismissed', 'completed')),
  created_at timestamptz not null default now()
);

create index if not exists coach_feedback_rec_idx on public.coach_feedback(recommendation_id);
create index if not exists coach_feedback_profile_idx on public.coach_feedback(profile_id);

alter table public.coach_feedback enable row level security;
