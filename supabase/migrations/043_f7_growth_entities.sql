-- ============================================================================
-- 043_f7_growth_entities.sql — Growth, Leadership, and Recognition Tables
-- ============================================================================

-- 1. Leadership Score History
create table if not exists public.leadership_score_history (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles(id) on delete cascade,
  company_id uuid not null references public.companies(id) on delete cascade,
  
  week_start date not null,
  
  leadership_score numeric(5,2) not null check (leadership_score between 0 and 100),
  
  -- Components for granular historical tracking
  attendance_component numeric(5,2) not null,
  task_component numeric(5,2) not null,
  consistency_component numeric(5,2) not null,
  growth_component numeric(5,2) not null,
  risk_component numeric(5,2) not null,
  
  created_at timestamptz not null default now(),
  
  constraint leadership_score_history_unique unique (profile_id, week_start)
);

create index if not exists leadership_history_profile_idx on public.leadership_score_history(profile_id);
create index if not exists leadership_history_week_idx on public.leadership_score_history(week_start);
alter table public.leadership_score_history enable row level security;

-- 2. Leadership Recommendations (Replaces promotion_recommendations)
create table if not exists public.leadership_recommendations (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles(id) on delete cascade,
  company_id uuid not null references public.companies(id) on delete cascade,
  
  recommendation_type text not null check (recommendation_type in ('promotion', 'recognition', 'mentorship', 'training', 'coaching')),
  recommended_role text, -- e.g., 'Sub-Leader', 'Mentor'
  
  confidence_score numeric(5,2),
  reasoning jsonb not null default '[]'::jsonb, -- Array of reasons
  
  status text not null default 'pending' check (status in ('pending', 'accepted', 'rejected', 'expired')),
  
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists leadership_rec_profile_idx on public.leadership_recommendations(profile_id);
create index if not exists leadership_rec_company_idx on public.leadership_recommendations(company_id, status);
alter table public.leadership_recommendations enable row level security;

-- 3. Leadership Milestones (System Generated)
create table if not exists public.leadership_milestones (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles(id) on delete cascade,
  company_id uuid not null references public.companies(id) on delete cascade,
  
  milestone_type text not null, -- e.g., '100% attendance 30 days', '10 tasks approved'
  achieved_at timestamptz not null default now(),
  
  constraint leadership_milestones_unique unique (profile_id, milestone_type, achieved_at)
);

create index if not exists leadership_milestones_profile_idx on public.leadership_milestones(profile_id);
alter table public.leadership_milestones enable row level security;

-- 4. Recognitions (Leader Generated)
create table if not exists public.recognitions (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  leader_id uuid not null references public.profiles(id) on delete cascade,
  profile_id uuid not null references public.profiles(id) on delete cascade,
  
  recognition_title text not null, -- e.g., 'Top Performer of the Month'
  recognition_message text,
  
  awarded_at timestamptz not null default now()
);

create index if not exists recognitions_profile_idx on public.recognitions(profile_id);
create index if not exists recognitions_leader_idx on public.recognitions(leader_id);
alter table public.recognitions enable row level security;
