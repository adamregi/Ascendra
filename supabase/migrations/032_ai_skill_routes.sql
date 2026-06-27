-- Phase F1: Skill Router & Context Builder

-- 1A. Upgrade ai_context_logs
alter table public.ai_context_logs
  drop constraint if exists ai_context_logs_skill_check;

alter table public.ai_context_logs
  add constraint ai_context_logs_skill_check
  check (skill is null or skill in (
    'team_performance', 'compliance_coach', 'meeting_coach',
    'task_coach', 'member_success', 'knowledge_assistant',
    'leadership_advisor', 'retention_risk', 'growth_opportunity',
    'system_assistant'
  ));

alter table public.ai_context_logs
  add column if not exists routing_reason       text,
  add column if not exists retrieval_latency_ms integer check (retrieval_latency_ms is null or retrieval_latency_ms >= 0),
  add column if not exists context_latency_ms   integer check (context_latency_ms is null or context_latency_ms >= 0),
  add column if not exists gemini_latency_ms    integer check (gemini_latency_ms is null or gemini_latency_ms >= 0),
  add column if not exists retrieval_strategy   text default 'vector' check (retrieval_strategy in ('vector', 'keyword', 'hybrid'));

comment on column public.ai_context_logs.retrieval_strategy is 'Future-proofing for F3/F4 when hybrid search is introduced.';

-- 1B. ai_skill_patterns
create table if not exists public.ai_skill_patterns (
  id           uuid primary key default gen_random_uuid(),
  company_id   uuid references public.companies(id) on delete cascade,
  skill        text not null check (skill in (
                 'team_performance', 'compliance_coach', 'meeting_coach',
                 'task_coach', 'member_success', 'knowledge_assistant',
                 'leadership_advisor', 'retention_risk', 'growth_opportunity',
                 'system_assistant'
               )),
  pattern_type text not null default 'regex' check (pattern_type in ('regex', 'keyword', 'phrase', 'semantic')),
  pattern      text not null check (char_length(trim(pattern)) > 0),
  weight       integer not null default 1 check (weight > 0),
  created_at   timestamptz not null default now()
);

create index if not exists ai_skill_patterns_company_idx
  on public.ai_skill_patterns (company_id);

-- 1C. context_cache
create table if not exists public.context_cache (
  company_id     uuid not null references public.companies(id) on delete cascade,
  profile_id     uuid not null references public.profiles(id) on delete cascade,
  skill          text not null check (skill in (
                   'team_performance', 'compliance_coach', 'meeting_coach',
                   'task_coach', 'member_success', 'knowledge_assistant',
                   'leadership_advisor', 'retention_risk', 'growth_opportunity',
                   'system_assistant'
                 )),
  question_hash  text not null check (char_length(question_hash) = 32),
  payload        jsonb not null default '{}'::jsonb,
  expires_at     timestamptz not null,
  created_at     timestamptz not null default now(),
  primary key (company_id, profile_id, skill, question_hash)
);

create index if not exists context_cache_expires_at_idx
  on public.context_cache (expires_at);

-- 1D. ai_skill_routes
create table if not exists public.ai_skill_routes (
  id              uuid primary key default gen_random_uuid(),
  company_id      uuid not null references public.companies(id) on delete cascade,
  profile_id      uuid not null references public.profiles(id) on delete cascade,
  question        text not null check (char_length(trim(question)) > 0),
  skill           text not null check (skill in (
                    'team_performance', 'compliance_coach', 'meeting_coach',
                    'task_coach', 'member_success', 'knowledge_assistant',
                    'leadership_advisor', 'retention_risk', 'growth_opportunity',
                    'system_assistant'
                  )),
  confidence      numeric(3,2) not null check (confidence >= 0.00 and confidence <= 1.00),
  routing_reason  text,
  alternatives    text[] not null default '{}',
  needs_clarification boolean not null default false,
  created_at      timestamptz not null default now()
);

create index if not exists ai_skill_routes_company_created_idx
  on public.ai_skill_routes (company_id, created_at desc);

create index if not exists ai_skill_routes_skill_created_idx
  on public.ai_skill_routes (skill, created_at desc);

-- 1E. RLS, Grants, Comments
alter table public.ai_skill_patterns enable row level security;
alter table public.context_cache enable row level security;
alter table public.ai_skill_routes enable row level security;

create policy "Anyone read skill patterns"
  on public.ai_skill_patterns for select using (true);

-- Leaders read routes for their company
create policy "Leaders read company ai_skill_routes"
  on public.ai_skill_routes for select
  using (
    company_id = public.get_user_company_id()
    and exists (
      select 1 from public.profiles
      where auth_user_id = auth.uid()
        and role = 'leader'
        and company_id = public.ai_skill_routes.company_id
    )
  );

-- Members read their own routes
create policy "Members read own ai_skill_routes"
  on public.ai_skill_routes for select
  using (
    profile_id in (
      select id from public.profiles
      where auth_user_id = auth.uid()
    )
  );

grant select on public.ai_skill_patterns to authenticated;
grant select on public.ai_skill_routes to authenticated;

comment on table public.ai_skill_patterns is 'Weighted keyword patterns for AI skill classification. NULL company_id = global. UUID = company override.';
comment on table public.context_cache is 'Short-lived cache (5 min TTL) for context builder payloads. Key: company + profile + skill + normalized question hash.';
comment on table public.ai_skill_routes is 'Analytics log for AI skill classification decisions. Stores alternatives and clarification flags.';
comment on column public.ai_context_logs.routing_reason is 'Human-readable explanation of why the skill router selected this skill.';

-- 1F. Seed Global Patterns
insert into public.ai_skill_patterns (company_id, skill, pattern_type, pattern, weight) values
  -- team_performance
  (null, 'team_performance', 'regex', 'team.*performance', 10),
  (null, 'team_performance', 'regex', 'performance.*team', 10),
  (null, 'team_performance', 'regex', 'show.*team', 8),
  (null, 'team_performance', 'regex', 'team summary', 5),
  (null, 'team_performance', 'regex', 'who needs attention', 5),
  -- compliance_coach
  (null, 'compliance_coach', 'regex', 'missed.*meeting', 10),
  (null, 'compliance_coach', 'regex', 'meeting.*missed', 10),
  (null, 'compliance_coach', 'regex', 'who missed', 10),
  (null, 'compliance_coach', 'regex', 'who is missing.*meeting', 10),
  (null, 'compliance_coach', 'regex', 'violation', 5),
  (null, 'compliance_coach', 'regex', 'warned', 5),
  (null, 'compliance_coach', 'regex', 'suspended', 5),
  (null, 'compliance_coach', 'regex', 'terminated', 5),
  (null, 'compliance_coach', 'regex', 'compliance', 5),
  -- meeting_coach
  (null, 'meeting_coach', 'regex', 'attendance.*report', 8),
  (null, 'meeting_coach', 'regex', 'meeting.*performance', 8),
  (null, 'meeting_coach', 'regex', 'engagement.*report', 8),
  (null, 'meeting_coach', 'regex', 'meeting', 3),
  (null, 'meeting_coach', 'regex', 'attendance', 3),
  (null, 'meeting_coach', 'regex', 'session', 2),
  (null, 'meeting_coach', 'regex', 'duration', 2),
  -- task_coach
  (null, 'task_coach', 'regex', 'task.*report', 8),
  (null, 'task_coach', 'regex', 'overdue.*task', 8),
  (null, 'task_coach', 'regex', 'assignment.*completion', 8),
  (null, 'task_coach', 'regex', 'task', 3),
  (null, 'task_coach', 'regex', 'assignment', 3),
  (null, 'task_coach', 'regex', 'proof', 3),
  (null, 'task_coach', 'regex', 'overdue', 3),
  (null, 'task_coach', 'regex', 'productivity', 3),
  -- member_success
  (null, 'member_success', 'regex', 'help.*member', 10),
  (null, 'member_success', 'regex', 'how.*can.*help', 8),
  (null, 'member_success', 'regex', 'struggling', 8),
  (null, 'member_success', 'regex', 'improve.*member', 8),
  (null, 'member_success', 'regex', 'what.*should.*improve', 5),
  -- knowledge_assistant
  (null, 'knowledge_assistant', 'regex', 'compensation.*plan', 10),
  (null, 'knowledge_assistant', 'regex', 'explain.*product', 10),
  (null, 'knowledge_assistant', 'regex', 'document', 5),
  (null, 'knowledge_assistant', 'regex', 'policy', 5),
  (null, 'knowledge_assistant', 'regex', 'manual', 5),
  (null, 'knowledge_assistant', 'regex', 'faq', 5),
  (null, 'knowledge_assistant', 'regex', 'success.*stor', 5),
  -- leadership_advisor
  (null, 'leadership_advisor', 'regex', 'improve.*leadership', 10),
  (null, 'leadership_advisor', 'regex', 'leadership.*advice', 10),
  (null, 'leadership_advisor', 'regex', 'how.*to.*lead', 10),
  (null, 'leadership_advisor', 'regex', 'what.*focus.*on', 5),
  (null, 'leadership_advisor', 'regex', 'weekly.*priorit', 5),
  (null, 'leadership_advisor', 'regex', 'my.*priorit', 5),
  -- retention_risk
  (null, 'retention_risk', 'regex', 'inactive', 10),
  (null, 'retention_risk', 'regex', 'might.*quit', 10),
  (null, 'retention_risk', 'regex', 'disengaged', 10),
  (null, 'retention_risk', 'regex', 'retention', 10),
  (null, 'retention_risk', 'regex', 'at.*risk', 8),
  (null, 'retention_risk', 'regex', 'engagement.*drop', 8),
  -- growth_opportunity
  (null, 'growth_opportunity', 'regex', 'who.*can.*become.*leader', 10),
  (null, 'growth_opportunity', 'regex', 'growth.*opportunit', 10),
  (null, 'growth_opportunity', 'regex', 'team.*expansion', 8),
  (null, 'growth_opportunity', 'regex', 'who.*should.*promote', 8),
  (null, 'growth_opportunity', 'regex', 'top.*performer', 5),
  (null, 'growth_opportunity', 'regex', 'recruit', 5),
  -- system_assistant
  (null, 'system_assistant', 'regex', 'how.*invite.*member', 10),
  (null, 'system_assistant', 'regex', 'upgrade.*plan', 10),
  (null, 'system_assistant', 'regex', 'where.*find.*recording', 10),
  (null, 'system_assistant', 'regex', 'how.*do.*i', 5),
  (null, 'system_assistant', 'regex', 'where.*can.*i', 5);

-- 1G. route_skill
create or replace function public.route_skill(p_company_id uuid, p_question text)
returns json
language plpgsql
security definer
set search_path = public
as $$
declare
  v_question    text := lower(trim(p_question));
  v_skill       text;
  v_confidence  numeric(3,2);
  v_reason      text;
  v_alternatives text[] := '{}';
  v_top_score   numeric;
  v_second_score numeric;
  v_needs_clarification boolean := false;
begin
  with effective_patterns as (
    -- Override logic: If company patterns exist for a skill, use them exclusively.
    select sp.skill, sp.pattern, sp.weight
    from public.ai_skill_patterns sp
    where sp.company_id = p_company_id
      and sp.pattern_type = 'regex'
      and v_question ~* sp.pattern
    union all
    select sp.skill, sp.pattern, sp.weight
    from public.ai_skill_patterns sp
    where sp.company_id is null
      and sp.pattern_type = 'regex'
      and v_question ~* sp.pattern
      and sp.skill not in (
        select distinct sp2.skill
        from public.ai_skill_patterns sp2
        where sp2.company_id = p_company_id
      )
  ),
  scored as (
    select
      ep.skill,
      sum(ep.weight) as total_score,
      string_agg(ep.pattern || ' (' || ep.weight || ')', ', ') as matched,
      case ep.skill
        when 'compliance_coach' then 100
        when 'retention_risk' then 90
        when 'team_performance' then 80
        when 'meeting_coach' then 70
        when 'task_coach' then 70
        when 'leadership_advisor' then 60
        when 'member_success' then 60
        when 'growth_opportunity' then 60
        when 'system_assistant' then 50
        when 'knowledge_assistant' then 50
        else 0
      end as priority
    from effective_patterns ep
    group by ep.skill
  ),
  ranked as (
    select skill, total_score, matched, priority,
      row_number() over (order by total_score desc, priority desc, skill asc) as rn
    from scored
  )
  select skill, total_score, matched into v_skill, v_top_score, v_reason
  from ranked where rn = 1;

  select total_score into v_second_score
  from ranked where rn = 2;

  if v_skill is null then
    -- Safe fallback
    v_skill := 'knowledge_assistant';
    v_confidence := 0.50;
    v_reason := 'No operational keywords matched. Defaulting to knowledge_assistant.';
  else
    v_second_score := coalesce(v_second_score, 0);
    v_confidence := least(0.99, (v_top_score / (v_top_score + v_second_score))::numeric(3,2));
    v_reason := 'Matched: ' || v_reason;

    if v_second_score > 0 and (v_top_score - v_second_score) <= 2 then
      v_needs_clarification := true;
    end if;

    select array_agg(skill order by total_score desc, priority desc)
    into v_alternatives
    from ranked where rn > 1 and rn <= 3;
  end if;

  return json_build_object(
    'skill', v_skill,
    'primary', coalesce(v_skill, 'knowledge_assistant'),
    'confidence', v_confidence,
    'routing_reason', v_reason,
    'alternatives', coalesce(v_alternatives, '{}'),
    'needs_clarification', v_needs_clarification
  );
end;
$$;

-- 1H. Cache Cleanup Function
create or replace function public.cleanup_expired_context_cache()
returns integer
language plpgsql
security definer
set search_path = public
as $$
declare
  v_deleted integer;
begin
  delete from public.context_cache where expires_at < now();
  get diagnostics v_deleted = row_count;
  return v_deleted;
end;
$$;

comment on function public.cleanup_expired_context_cache() is 'Removes expired context cache entries. Run daily via pg_cron or scheduled edge function.';
