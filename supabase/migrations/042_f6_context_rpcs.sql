-- ============================================================================
-- 042_f6_context_rpcs.sql — F6 Intelligence RPCs and Risk Engine
-- ============================================================================

-- 1. Entity Resolver
create or replace function public.resolve_member_reference(
  p_leader_id uuid,
  p_query text
)
returns json
language plpgsql
security definer
as $$
declare
  v_candidates json;
  v_count int;
begin
  -- Search for matching members in the leader's downline
  with downline as (
    select n.profile_id
    from public.network_nodes n
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and n.profile_id != p_leader_id
  ),
  matches as (
    select 
      p.id as profile_id,
      p.first_name || ' ' || p.last_name as full_name
    from downline d
    join public.profiles p on p.id = d.profile_id
    where p.first_name ilike '%' || p_query || '%'
       or p.last_name ilike '%' || p_query || '%'
       or (p.first_name || ' ' || p.last_name) ilike '%' || p_query || '%'
  )
  select count(*), coalesce(json_agg(row_to_json(m)), '[]'::json)
  into v_count, v_candidates
  from matches m;

  return json_build_object(
    'needs_clarification', (v_count > 1 or v_count = 0),
    'count', v_count,
    'candidates', v_candidates
  );
end;
$$;

-- 2. Calculate Member Risks
create or replace function public.calculate_member_risks()
returns void
language plpgsql
security definer
as $$
declare
  v_config record;
  v_member record;
  v_risk_score numeric;
  v_risk_level text;
  v_att_trend numeric;
  v_task_trend numeric;
begin
  -- Retrieve the active risk configuration
  select * into v_config from public.risk_configuration where is_active = true limit 1;
  if not found then
    return; -- No active config
  end if;

  -- Iterate through profiles
  for v_member in (
    select 
      p.id as profile_id, 
      p.company_id,
      mps.attendance_score,
      mps.task_score,
      mps.compliance_score,
      mps.activity_trend
    from public.profiles p
    left join public.member_performance_snapshots mps on mps.profile_id = p.id and mps.snapshot_date = current_date
    where p.role != 'admin'
  ) loop
    -- Use scores as trends for now (could be derived by comparing snapshots)
    v_att_trend := coalesce(v_member.attendance_score, 0);
    v_task_trend := coalesce(v_member.task_score, 0);

    -- Calculate risk score: 100 is critical risk, 0 is no risk. 
    -- If score is high, risk is low. So risk_score = 100 - weighted average.
    v_risk_score := 100.0 - (
      (v_att_trend * (v_config.attendance_weight / 100.0)) +
      (v_task_trend * (v_config.task_weight / 100.0)) +
      (coalesce(v_member.compliance_score, 0) * (v_config.compliance_weight / 100.0)) +
      (coalesce(v_member.activity_trend, 0) * (v_config.activity_weight / 100.0))
    );

    if v_risk_score >= 75 then v_risk_level := 'critical';
    elsif v_risk_score >= 50 then v_risk_level := 'high';
    elsif v_risk_score >= 25 then v_risk_level := 'medium';
    else v_risk_level := 'low';
    end if;

    -- Upsert risk scores
    insert into public.member_risk_scores (
      profile_id, company_id, attendance_trend, task_trend, compliance_trend, activity_trend, risk_score, risk_level
    ) values (
      v_member.profile_id, v_member.company_id, v_att_trend, v_task_trend, coalesce(v_member.compliance_score, 0), coalesce(v_member.activity_trend, 0), v_risk_score, v_risk_level
    )
    on conflict (profile_id) do update set
      attendance_trend = excluded.attendance_trend,
      task_trend = excluded.task_trend,
      compliance_trend = excluded.compliance_trend,
      activity_trend = excluded.activity_trend,
      risk_score = excluded.risk_score,
      risk_level = excluded.risk_level,
      last_calculated_at = now();

    -- Generate insights for high/critical risks
    if v_risk_level in ('high', 'critical') then
      -- Avoid duplicates within same week
      if not exists (
        select 1 from public.coach_insights 
        where profile_id = v_member.profile_id 
          and insight_type = 'retention_risk' 
          and created_at >= now() - interval '7 days'
      ) then
        insert into public.coach_insights (company_id, profile_id, skill, insight_type, severity, title, description)
        values (v_member.company_id, v_member.profile_id, 'retention_risk', 'retention_risk', v_risk_level, 
                'Elevated Retention Risk', 
                'Member risk score reached ' || round(v_risk_score, 0) || '.');
      end if;
    end if;

  end loop;
end;
$$;

-- 3. Generate Recommendations
create or replace function public.generate_recommendations()
returns void
language plpgsql
security definer
as $$
declare
  v_insight record;
  v_rec_id uuid;
begin
  -- Find insights that don't have recommendations yet
  for v_insight in (
    select ci.* from public.coach_insights ci
    left join public.ai_recommendations ar on ar.source_insight_id = ci.id
    where ar.id is null
  ) loop
    insert into public.ai_recommendations (company_id, profile_id, title, description, recommendation_type, severity, source_insight_id)
    values (v_insight.company_id, v_insight.profile_id, 
            'Review Risk for ' || v_insight.title,
            'Generated from AI Insight: ' || v_insight.description,
            v_insight.insight_type, v_insight.severity, v_insight.id);
  end loop;
end;
$$;

-- 4. Leadership Advisor Context
create or replace function public.get_ai_leadership_advisor_context(
  p_company_id uuid,
  p_leader_id uuid
)
returns json
language plpgsql
security definer
as $$
declare
  v_team_analytics record;
  v_risk_summary json;
  v_insights json;
  v_recommendations json;
begin
  select * into v_team_analytics from public.mv_team_analytics where leader_id = p_leader_id and company_id = p_company_id;

  select json_agg(row_to_json(r)) into v_risk_summary
  from (
    select risk_level, count(*) as count
    from public.network_nodes n
    join public.member_risk_scores mrs on mrs.profile_id = n.profile_id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and n.profile_id != p_leader_id
    group by risk_level
  ) r;

  select coalesce(json_agg(row_to_json(i)), '[]'::json) into v_insights
  from (
    select ci.title, ci.severity, ci.created_at
    from public.network_nodes n
    join public.coach_insights ci on ci.profile_id = n.profile_id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
    order by ci.created_at desc limit 10
  ) i;

  select coalesce(json_agg(row_to_json(a)), '[]'::json) into v_recommendations
  from (
    select ar.title, ar.severity, ar.status, ar.created_at
    from public.network_nodes n
    join public.ai_recommendations ar on ar.profile_id = n.profile_id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and ar.status = 'pending'
    order by ar.created_at desc limit 10
  ) a;

  return json_build_object(
    'team_analytics', coalesce(row_to_json(v_team_analytics), '{}'::json),
    'risk_summary', coalesce(v_risk_summary, '[]'::json),
    'recent_insights', v_insights,
    'pending_recommendations', v_recommendations
  );
end;
$$;

-- 5. Member Success Context
create or replace function public.get_ai_member_success_context(
  p_company_id uuid,
  p_leader_id uuid,
  p_target_profile_id uuid
)
returns json
language plpgsql
security definer
as $$
declare
  v_member_analytics record;
  v_risk record;
  v_insights json;
begin
  select * into v_member_analytics from public.mv_member_analytics where profile_id = p_target_profile_id and company_id = p_company_id;
  select * into v_risk from public.member_risk_scores where profile_id = p_target_profile_id;

  select coalesce(json_agg(row_to_json(i)), '[]'::json) into v_insights
  from (
    select ci.title, ci.severity, ci.created_at
    from public.coach_insights ci
    where ci.profile_id = p_target_profile_id
    order by ci.created_at desc limit 10
  ) i;

  return json_build_object(
    'analytics', coalesce(row_to_json(v_member_analytics), '{}'::json),
    'risk_score', coalesce(row_to_json(v_risk), '{}'::json),
    'insights', v_insights
  );
end;
$$;

-- 6. Retention Risk Context
create or replace function public.get_ai_retention_risk_context(
  p_company_id uuid,
  p_leader_id uuid,
  p_target_profile_id uuid default null
)
returns json
language plpgsql
security definer
as $$
declare
  v_context json;
begin
  if p_target_profile_id is not null then
    -- Return specific member risk
    return public.get_ai_member_success_context(p_company_id, p_leader_id, p_target_profile_id);
  else
    -- Return top at risk members
    select coalesce(json_agg(row_to_json(r)), '[]'::json) into v_context
    from (
      select p.first_name, p.last_name, mrs.risk_score, mrs.risk_level, mrs.attendance_trend, mrs.task_trend
      from public.network_nodes n
      join public.profiles p on p.id = n.profile_id
      join public.member_risk_scores mrs on mrs.profile_id = n.profile_id
      where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
        and n.profile_id != p_leader_id
      order by mrs.risk_score desc
      limit 10
    ) r;
    return json_build_object('high_risk_members', v_context);
  end if;
end;
$$;
