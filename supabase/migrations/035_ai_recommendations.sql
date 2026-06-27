-- ============================================================================
-- Phase F3D: AI Recommendations Engine
-- ============================================================================

create table if not exists public.ai_recommendations (
  id uuid primary key default gen_random_uuid(),
  company_id uuid references public.companies(id) on delete cascade,
  profile_id uuid references public.profiles(id) on delete cascade,
  skill text not null,
  priority text not null check (priority in ('High', 'Medium', 'Low', 'None')),
  title text not null,
  description text not null,
  status text not null default 'pending' check (status in ('pending', 'resolved', 'dismissed')),
  created_at timestamptz not null default now(),
  resolved_at timestamptz
);

create index if not exists ai_recommendations_company_idx on public.ai_recommendations(company_id);
create index if not exists ai_recommendations_profile_idx on public.ai_recommendations(profile_id);
create index if not exists ai_recommendations_status_idx on public.ai_recommendations(status);

-- RLS
alter table public.ai_recommendations enable row level security;

create policy "Leaders read their company recommendations"
  on public.ai_recommendations for select
  using (
    company_id = public.get_user_company_id()
    and exists (
      select 1 from public.profiles
      where auth_user_id = auth.uid()
        and role = 'leader'
        and company_id = public.ai_recommendations.company_id
    )
  );

create policy "Leaders update their company recommendations"
  on public.ai_recommendations for update
  using (
    company_id = public.get_user_company_id()
    and exists (
      select 1 from public.profiles
      where auth_user_id = auth.uid()
        and role = 'leader'
        and company_id = public.ai_recommendations.company_id
    )
  );

grant select, update on public.ai_recommendations to authenticated;
