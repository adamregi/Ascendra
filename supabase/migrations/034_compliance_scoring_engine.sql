-- ============================================================================
-- Phase F3A: Compliance Scoring Engine
-- ============================================================================

-- 1. Create member_performance_snapshots table
create table if not exists public.member_performance_snapshots (
  id uuid primary key default gen_random_uuid(),
  company_id uuid references public.companies(id) on delete cascade,
  profile_id uuid references public.profiles(id) on delete cascade,
  
  -- Base metrics
  attendance_score numeric(5,2) not null default 0,
  task_score numeric(5,2) not null default 0,
  followup_score numeric(5,2) not null default 0,
  compliance_score numeric(5,2) not null default 0,
  
  -- F3 Metrics
  activity_trend numeric(5,2) not null default 0,
  recent_participation_score numeric(5,2) not null default 0,
  member_health_score numeric(5,2) not null default 0,
  
  -- Classifications
  risk_level text not null,
  next_recommended_action text not null,
  
  -- Metadata
  last_activity_at timestamptz,
  snapshot_date date not null default current_date,
  created_at timestamptz not null default now(),
  
  unique(profile_id, snapshot_date)
);

create index if not exists member_perf_company_idx on public.member_performance_snapshots(company_id);
create index if not exists member_perf_profile_idx on public.member_performance_snapshots(profile_id);
create index if not exists member_perf_date_idx on public.member_performance_snapshots(snapshot_date);

-- RLS
alter table public.member_performance_snapshots enable row level security;

create policy "Leaders read their company snapshots"
  on public.member_performance_snapshots for select
  using (
    company_id = public.get_user_company_id()
    and exists (
      select 1 from public.profiles
      where auth_user_id = auth.uid()
        and role = 'leader'
        and company_id = public.member_performance_snapshots.company_id
    )
  );

grant select on public.member_performance_snapshots to authenticated;

-- 2. Create the refresh function
create or replace function public.refresh_performance_snapshots()
returns void
language plpgsql
security definer
as $$
declare
  p_record record;
  
  -- Metrics
  v_attendance_pct numeric;
  v_task_pct numeric;
  v_followup_pct numeric;
  
  v_attendance_score numeric;
  v_task_score numeric;
  v_followup_score numeric;
  v_compliance_score numeric;
  
  v_curr_activity integer;
  v_prev_activity integer;
  v_activity_growth numeric;
  v_activity_trend numeric;
  
  v_days_since_activity integer;
  v_recent_participation_score numeric;
  
  v_member_health_score numeric;
  v_risk_level text;
  v_next_action text;
  v_last_activity_at timestamptz;
begin
  -- Note: This assumes standard tables (meeting_attendance, task_assignments, followups).
  -- In a real scenario, the counts would be aggregated from these tables.
  -- For this F3 migration, we build the deterministic formulas that the platform will use.
  
  for p_record in select id, company_id from public.profiles where role != 'admin' loop
    
    -- 1. MOCK QUERY AGGREGATIONS (To be replaced with real table joins)
    -- Assume we have fetched:
    v_attendance_pct := coalesce(random() * 100, 0); -- placeholder for: attended / total
    v_task_pct := coalesce(random() * 100, 0);       -- placeholder for: approved / assigned
    v_followup_pct := coalesce(random() * 100, 0);   -- placeholder for: completed / total
    
    v_curr_activity := floor(random() * 30 + 1); -- Current 30 days activity count
    v_prev_activity := floor(random() * 30 + 1); -- Prev 30 days activity count
    
    v_days_since_activity := floor(random() * 40); -- Days since last activity
    v_last_activity_at := now() - (v_days_since_activity || ' days')::interval;

    -- 2. CALCULATE ATTENDANCE SCORE
    if v_attendance_pct >= 90 then v_attendance_score := 100;
    elsif v_attendance_pct >= 75 then v_attendance_score := 75;
    elsif v_attendance_pct >= 50 then v_attendance_score := 50;
    else v_attendance_score := 0;
    end if;

    -- 3. CALCULATE TASK SCORE
    v_task_score := v_task_pct;

    -- 4. CALCULATE FOLLOWUP SCORE
    v_followup_score := v_followup_pct;

    -- 5. CALCULATE COMPLIANCE SCORE (40 / 40 / 20)
    v_compliance_score := (v_attendance_score * 0.4) + (v_task_score * 0.4) + (v_followup_score * 0.2);

    -- 6. CALCULATE ACTIVITY TREND (Current vs Prev 30 Days)
    if v_prev_activity = 0 then
      v_activity_growth := 100.0; -- Avoid div by zero, treat as 100% growth
    else
      v_activity_growth := ((v_curr_activity - v_prev_activity)::numeric / v_prev_activity::numeric) * 100.0;
    end if;
    
    if v_activity_growth > 20 then v_activity_trend := 100;
    elsif v_activity_growth >= 0 then v_activity_trend := 75;
    elsif v_activity_growth >= -10 then v_activity_trend := 50;
    elsif v_activity_growth >= -30 then v_activity_trend := 25;
    else v_activity_trend := 0;
    end if;

    -- 7. CALCULATE RECENT PARTICIPATION
    if v_days_since_activity <= 3 then v_recent_participation_score := 100;
    elsif v_days_since_activity <= 7 then v_recent_participation_score := 80;
    elsif v_days_since_activity <= 14 then v_recent_participation_score := 60;
    elsif v_days_since_activity <= 21 then v_recent_participation_score := 40;
    elsif v_days_since_activity <= 30 then v_recent_participation_score := 20;
    else v_recent_participation_score := 0;
    end if;

    -- 8. CALCULATE MEMBER HEALTH SCORE (70 / 20 / 10)
    v_member_health_score := (v_compliance_score * 0.70) + (v_activity_trend * 0.20) + (v_recent_participation_score * 0.10);

    -- 9. CALCULATE RISK LEVEL
    if v_member_health_score >= 85 then v_risk_level := 'Excellent';
    elsif v_member_health_score >= 70 then v_risk_level := 'Healthy';
    elsif v_member_health_score >= 50 then v_risk_level := 'Needs Attention';
    elsif v_member_health_score >= 30 then v_risk_level := 'At Risk';
    else v_risk_level := 'Critical';
    end if;

    -- 10. MAP NEXT RECOMMENDED ACTION
    if v_risk_level = 'Critical' then v_next_action := 'Schedule Immediate Followup';
    elsif v_risk_level = 'At Risk' then v_next_action := 'Review Missed Meetings';
    elsif v_risk_level = 'Needs Attention' then v_next_action := 'Assign Coaching Task';
    elsif v_risk_level = 'Healthy' then v_next_action := 'Monitor Progress';
    elsif v_risk_level = 'Excellent' then v_next_action := 'Consider Leadership Promotion';
    end if;

    -- 11. UPSERT SNAPSHOT
    insert into public.member_performance_snapshots (
      company_id, profile_id, attendance_score, task_score, followup_score,
      compliance_score, activity_trend, recent_participation_score,
      member_health_score, risk_level, next_recommended_action,
      last_activity_at, snapshot_date
    ) values (
      p_record.company_id, p_record.id, v_attendance_score, v_task_score, v_followup_score,
      v_compliance_score, v_activity_trend, v_recent_participation_score,
      v_member_health_score, v_risk_level, v_next_action,
      v_last_activity_at, current_date
    )
    on conflict (profile_id, snapshot_date) do update set
      attendance_score = excluded.attendance_score,
      task_score = excluded.task_score,
      followup_score = excluded.followup_score,
      compliance_score = excluded.compliance_score,
      activity_trend = excluded.activity_trend,
      recent_participation_score = excluded.recent_participation_score,
      member_health_score = excluded.member_health_score,
      risk_level = excluded.risk_level,
      next_recommended_action = excluded.next_recommended_action,
      last_activity_at = excluded.last_activity_at;

  end loop;
end;
$$;

-- 3. AI Context RPC
create or replace function public.get_ai_team_performance_context(p_company_id uuid, p_leader_id uuid)
returns json
language plpgsql
security definer
as $$
declare
  v_result json;
begin
  with leader_node as (
    select path from public.network_nodes where profile_id = p_leader_id and company_id = p_company_id limit 1
  ),
  team_snapshots as (
    select s.*, p.first_name, p.last_name
    from public.member_performance_snapshots s
    join public.network_nodes n on n.profile_id = s.profile_id
    join public.profiles p on p.id = s.profile_id
    cross join leader_node l
    where s.company_id = p_company_id
      and s.snapshot_date = current_date
      and n.path <@ l.path
  )
  select json_build_object(
    'team_size', (select count(*) from team_snapshots),
    'active_members', (select count(*) from team_snapshots where last_activity_at >= now() - interval '30 days'),
    'needs_attention_members', (select count(*) from team_snapshots where risk_level = 'Needs Attention'),
    'at_risk_members', (select count(*) from team_snapshots where risk_level = 'At Risk'),
    'critical_members', (select count(*) from team_snapshots where risk_level = 'Critical'),
    'top_performers', coalesce((
      select json_agg(json_build_object('name', first_name || ' ' || last_name, 'health_score', member_health_score, 'trend', activity_trend))
      from (select * from team_snapshots order by member_health_score desc limit 5) t
    ), '[]'::json),
    'at_risk_list', coalesce((
      select json_agg(json_build_object('name', first_name || ' ' || last_name, 'health_score', member_health_score, 'risk_level', risk_level, 'action', next_recommended_action))
      from (select * from team_snapshots where risk_level in ('At Risk', 'Critical', 'Needs Attention') order by member_health_score asc limit 5) t
    ), '[]'::json)
  ) into v_result;

  return v_result;
end;
$$;

create or replace function public.get_ai_compliance_context(p_company_id uuid, p_leader_id uuid)
returns json
language plpgsql
security definer
as $$
declare
  v_result json;
begin
  with leader_node as (
    select path from public.network_nodes where profile_id = p_leader_id and company_id = p_company_id limit 1
  ),
  team_snapshots as (
    select s.*, p.first_name, p.last_name
    from public.member_performance_snapshots s
    join public.network_nodes n on n.profile_id = s.profile_id
    join public.profiles p on p.id = s.profile_id
    cross join leader_node l
    where s.company_id = p_company_id
      and s.snapshot_date = current_date
      and n.path <@ l.path
  )
  select json_build_object(
    'team_size', (select count(*) from team_snapshots),
    'warned_members', coalesce((
      select json_agg(json_build_object('name', first_name || ' ' || last_name, 'health_score', member_health_score, 'action', next_recommended_action))
      from (select * from team_snapshots where risk_level = 'Needs Attention' limit 5) t
    ), '[]'::json),
    'suspended_members', coalesce((
      select json_agg(json_build_object('name', first_name || ' ' || last_name, 'health_score', member_health_score, 'action', next_recommended_action))
      from (select * from team_snapshots where risk_level = 'At Risk' limit 5) t
    ), '[]'::json),
    'terminated_members', coalesce((
      select json_agg(json_build_object('name', first_name || ' ' || last_name, 'health_score', member_health_score, 'action', next_recommended_action))
      from (select * from team_snapshots where risk_level = 'Critical' limit 5) t
    ), '[]'::json)
  ) into v_result;

  return v_result;
end;
$$;
