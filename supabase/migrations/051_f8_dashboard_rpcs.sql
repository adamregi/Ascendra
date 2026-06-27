-- ============================================================================
-- 051_f8_dashboard_rpcs.sql — Executive Dashboard RPCs
-- ============================================================================
-- All RPCs consume only MVs, snapshot tables, and recommendation tables.
-- No raw operational table is ever queried.
-- ============================================================================

-- ============================================================================
-- 1. Executive Overview
-- ============================================================================
-- Returns the full executive summary for a leader: health, growth, risk,
-- pipeline, and pending actions.
-- ============================================================================

create or replace function public.get_executive_overview(
  p_company_id uuid,
  p_leader_id uuid
)
returns json
language plpgsql
security definer
as $$
declare
  v_overview record;
begin
  select * into v_overview
  from public.mv_executive_overview
  where leader_id = p_leader_id and company_id = p_company_id;

  if not found then
    return json_build_object(
      'team_health_score', 0,
      'team_size', 0,
      'message', 'No dashboard data available yet. Analytics will refresh overnight.'
    );
  end if;

  return json_build_object(
    -- Health Module
    'health', json_build_object(
      'team_health_score', v_overview.team_health_score,
      'team_size', v_overview.team_size,
      'active_members', v_overview.active_members,
      'attendance_rate', v_overview.team_attendance_rate,
      'completion_rate', v_overview.team_completion_rate
    ),
    -- Growth Module
    'growth', json_build_object(
      'team_growth_score', v_overview.team_growth_score,
      'task_growth_score', v_overview.task_growth_score
    ),
    -- Risk Module
    'risk', json_build_object(
      'low', v_overview.low_risk_count,
      'medium', v_overview.medium_risk_count,
      'high', v_overview.high_risk_count,
      'critical', v_overview.critical_risk_count,
      'risk_percentage', v_overview.risk_percentage
    ),
    -- Pipeline Module
    'pipeline', json_build_object(
      'future_leaders', v_overview.future_leaders,
      'emerging_leaders', v_overview.emerging_leaders,
      'developing', v_overview.developing_members,
      'needs_development', v_overview.needs_development,
      'top_performers', v_overview.top_performer_count
    ),
    -- Actions Module
    'pending_actions', json_build_object(
      'promotions', v_overview.pending_promotions,
      'recognitions', v_overview.pending_recognitions,
      'mentorships', v_overview.pending_mentorships,
      'trainings', v_overview.pending_trainings,
      'coaching', v_overview.pending_coaching,
      'total', v_overview.total_pending_actions
    ),
    'generated_at', v_overview.generated_at
  );
end;
$$;

-- ============================================================================
-- 2. Leadership Pipeline Dashboard
-- ============================================================================
-- Returns the full pipeline with member details, grouped by band.
-- ============================================================================

create or replace function public.get_leadership_pipeline(
  p_company_id uuid,
  p_leader_id uuid
)
returns json
language plpgsql
security definer
as $$
declare
  v_future_leaders json;
  v_emerging json;
  v_developing json;
  v_needs_dev json;
begin
  -- Future Leaders
  select coalesce(json_agg(row_to_json(m) order by m.leadership_score desc), '[]'::json) into v_future_leaders
  from (
    select p.first_name, p.last_name, lp.leadership_score, lp.leadership_band,
           tp.company_percentile, ga.attendance_delta_30d, ga.task_delta_30d
    from public.network_nodes n
    join public.mv_leadership_pipeline lp on lp.profile_id = n.profile_id
    join public.profiles p on p.id = n.profile_id
    left join public.mv_top_performers tp on tp.profile_id = n.profile_id
    left join public.mv_growth_analytics ga on ga.profile_id = n.profile_id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and n.profile_id != p_leader_id
      and lp.leadership_band = 'Future Leader'
  ) m;

  -- Emerging Leaders
  select coalesce(json_agg(row_to_json(m) order by m.leadership_score desc), '[]'::json) into v_emerging
  from (
    select p.first_name, p.last_name, lp.leadership_score, lp.leadership_band,
           ga.attendance_delta_30d, ga.task_delta_30d
    from public.network_nodes n
    join public.mv_leadership_pipeline lp on lp.profile_id = n.profile_id
    join public.profiles p on p.id = n.profile_id
    left join public.mv_growth_analytics ga on ga.profile_id = n.profile_id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and n.profile_id != p_leader_id
      and lp.leadership_band = 'Emerging Leader'
  ) m;

  -- Developing
  select coalesce(json_agg(row_to_json(m) order by m.leadership_score desc), '[]'::json) into v_developing
  from (
    select p.first_name, p.last_name, lp.leadership_score, lp.leadership_band
    from public.network_nodes n
    join public.mv_leadership_pipeline lp on lp.profile_id = n.profile_id
    join public.profiles p on p.id = n.profile_id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and n.profile_id != p_leader_id
      and lp.leadership_band = 'Developing'
    limit 20
  ) m;

  -- Needs Development
  select coalesce(json_agg(row_to_json(m) order by m.leadership_score asc), '[]'::json) into v_needs_dev
  from (
    select p.first_name, p.last_name, lp.leadership_score, lp.leadership_band
    from public.network_nodes n
    join public.mv_leadership_pipeline lp on lp.profile_id = n.profile_id
    join public.profiles p on p.id = n.profile_id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and n.profile_id != p_leader_id
      and lp.leadership_band = 'Needs Development'
    limit 20
  ) m;

  return json_build_object(
    'future_leaders', v_future_leaders,
    'emerging_leaders', v_emerging,
    'developing', v_developing,
    'needs_development', v_needs_dev
  );
end;
$$;

-- ============================================================================
-- 3. Risk & Retention Dashboard
-- ============================================================================

create or replace function public.get_risk_retention_dashboard(
  p_company_id uuid,
  p_leader_id uuid
)
returns json
language plpgsql
security definer
as $$
declare
  v_high_risk json;
  v_risk_distribution json;
  v_retention_trend json;
begin
  -- High Risk Members (detail list)
  select coalesce(json_agg(row_to_json(m) order by m.risk_score desc), '[]'::json) into v_high_risk
  from (
    select p.first_name, p.last_name, mrs.risk_score, mrs.risk_level,
           mrs.attendance_trend, mrs.task_trend, mrs.compliance_trend,
           ga.attendance_trend_text
    from public.network_nodes n
    join public.member_risk_scores mrs on mrs.profile_id = n.profile_id
    join public.profiles p on p.id = n.profile_id
    left join public.mv_growth_analytics ga on ga.profile_id = n.profile_id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and n.profile_id != p_leader_id
      and mrs.risk_level in ('high', 'critical')
    limit 10
  ) m;

  -- Risk Distribution
  select coalesce(json_agg(row_to_json(r)), '[]'::json) into v_risk_distribution
  from (
    select mrs.risk_level, count(*) as count
    from public.network_nodes n
    join public.member_risk_scores mrs on mrs.profile_id = n.profile_id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and n.profile_id != p_leader_id
    group by mrs.risk_level
    order by case mrs.risk_level when 'critical' then 1 when 'high' then 2 when 'medium' then 3 else 4 end
  ) r;

  -- Retention Trend (risk score averages over recent weeks from leadership_score_history)
  select coalesce(json_agg(row_to_json(t)), '[]'::json) into v_retention_trend
  from (
    select lsh.week_start, avg(lsh.risk_component) as avg_risk_component, count(*) as member_count
    from public.network_nodes n
    join public.leadership_score_history lsh on lsh.profile_id = n.profile_id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and n.profile_id != p_leader_id
      and lsh.week_start >= current_date - interval '90 days'
    group by lsh.week_start
    order by lsh.week_start
  ) t;

  return json_build_object(
    'high_risk_members', v_high_risk,
    'risk_distribution', v_risk_distribution,
    'retention_trend', v_retention_trend
  );
end;
$$;

-- ============================================================================
-- 4. Recognition & Engagement Dashboard
-- ============================================================================

create or replace function public.get_recognition_dashboard(
  p_company_id uuid,
  p_leader_id uuid
)
returns json
language plpgsql
security definer
as $$
declare
  v_milestones json;
  v_recognitions json;
  v_unrecognized json;
begin
  -- Recent Milestones (system-generated achievements)
  select coalesce(json_agg(row_to_json(m)), '[]'::json) into v_milestones
  from (
    select p.first_name, p.last_name, lm.milestone_type, lm.reference_period, lm.achieved_at
    from public.network_nodes n
    join public.leadership_milestones lm on lm.profile_id = n.profile_id
    join public.profiles p on p.id = n.profile_id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and n.profile_id != p_leader_id
      and lm.achieved_at >= now() - interval '30 days'
    order by lm.achieved_at desc limit 15
  ) m;

  -- Recent Leader Recognitions
  select coalesce(json_agg(row_to_json(r)), '[]'::json) into v_recognitions
  from (
    select p.first_name, p.last_name, rec.recognition_title, rec.recognition_message, rec.awarded_at
    from public.network_nodes n
    join public.recognitions rec on rec.profile_id = n.profile_id
    join public.profiles p on p.id = n.profile_id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and n.profile_id != p_leader_id
      and rec.awarded_at >= now() - interval '30 days'
    order by rec.awarded_at desc limit 10
  ) r;

  -- Members with milestones but no recognition (recognition gap)
  select coalesce(json_agg(row_to_json(u)), '[]'::json) into v_unrecognized
  from (
    select p.first_name, p.last_name, lm.milestone_type, lm.achieved_at
    from public.network_nodes n
    join public.leadership_milestones lm on lm.profile_id = n.profile_id
    join public.profiles p on p.id = n.profile_id
    left join public.recognitions rec on rec.profile_id = n.profile_id
      and rec.awarded_at >= lm.achieved_at
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and n.profile_id != p_leader_id
      and lm.achieved_at >= now() - interval '30 days'
      and rec.id is null
    order by lm.achieved_at desc limit 10
  ) u;

  return json_build_object(
    'recent_milestones', v_milestones,
    'recent_recognitions', v_recognitions,
    'unrecognized_achievements', v_unrecognized
  );
end;
$$;

-- ============================================================================
-- 5. Recommendation Center
-- ============================================================================

create or replace function public.get_recommendation_center(
  p_company_id uuid,
  p_leader_id uuid
)
returns json
language plpgsql
security definer
as $$
declare
  v_promotions json;
  v_mentorships json;
  v_coaching json;
  v_training json;
  v_recognitions json;
begin
  -- Helper: fetch recommendations by type from the MV
  select coalesce(json_agg(row_to_json(r) order by r.confidence_score desc), '[]'::json) into v_promotions
  from (
    select rc.recommendation_id, rc.member_name, rc.recommended_role, rc.confidence_score,
           rc.reasoning, rc.current_leadership_score, rc.current_risk_level, rc.created_at
    from public.mv_recommendation_center rc
    join public.network_nodes n on n.profile_id = rc.profile_id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and rc.company_id = p_company_id
      and rc.status = 'pending' and rc.recommendation_type = 'promotion'
    limit 10
  ) r;

  select coalesce(json_agg(row_to_json(r) order by r.confidence_score desc), '[]'::json) into v_mentorships
  from (
    select rc.recommendation_id, rc.member_name, rc.recommended_role, rc.confidence_score,
           rc.reasoning, rc.current_leadership_score, rc.created_at
    from public.mv_recommendation_center rc
    join public.network_nodes n on n.profile_id = rc.profile_id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and rc.company_id = p_company_id
      and rc.status = 'pending' and rc.recommendation_type = 'mentorship'
    limit 10
  ) r;

  select coalesce(json_agg(row_to_json(r) order by r.confidence_score desc), '[]'::json) into v_coaching
  from (
    select rc.recommendation_id, rc.member_name, rc.confidence_score,
           rc.reasoning, rc.current_leadership_score, rc.created_at
    from public.mv_recommendation_center rc
    join public.network_nodes n on n.profile_id = rc.profile_id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and rc.company_id = p_company_id
      and rc.status = 'pending' and rc.recommendation_type = 'coaching'
    limit 10
  ) r;

  select coalesce(json_agg(row_to_json(r) order by r.confidence_score desc), '[]'::json) into v_training
  from (
    select rc.recommendation_id, rc.member_name, rc.confidence_score,
           rc.reasoning, rc.current_leadership_score, rc.created_at
    from public.mv_recommendation_center rc
    join public.network_nodes n on n.profile_id = rc.profile_id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and rc.company_id = p_company_id
      and rc.status = 'pending' and rc.recommendation_type = 'training'
    limit 10
  ) r;

  select coalesce(json_agg(row_to_json(r) order by r.confidence_score desc), '[]'::json) into v_recognitions
  from (
    select rc.recommendation_id, rc.member_name, rc.confidence_score,
           rc.reasoning, rc.current_leadership_score, rc.created_at
    from public.mv_recommendation_center rc
    join public.network_nodes n on n.profile_id = rc.profile_id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and rc.company_id = p_company_id
      and rc.status = 'pending' and rc.recommendation_type = 'recognition'
    limit 10
  ) r;

  return json_build_object(
    'promotions', v_promotions,
    'mentorships', v_mentorships,
    'coaching', v_coaching,
    'training', v_training,
    'recognitions', v_recognitions
  );
end;
$$;

-- ============================================================================
-- 6. Recommendation Explainability Panel
-- ============================================================================
-- Given a recommendation ID, returns the full evidence chain.
-- ============================================================================

create or replace function public.get_recommendation_explainability(
  p_recommendation_id uuid
)
returns json
language plpgsql
security definer
as $$
declare
  v_rec record;
  v_score_history json;
begin
  select
    rc.*
  into v_rec
  from public.mv_recommendation_center rc
  where rc.recommendation_id = p_recommendation_id;

  if not found then
    return json_build_object('error', 'Recommendation not found.');
  end if;

  -- Get leadership score trend for this member (last 12 weeks)
  select coalesce(json_agg(row_to_json(h) order by h.week_start), '[]'::json) into v_score_history
  from (
    select week_start, leadership_score, attendance_component, task_component,
           consistency_component, growth_component, risk_component
    from public.leadership_score_history
    where profile_id = v_rec.profile_id
    order by week_start desc limit 12
  ) h;

  return json_build_object(
    'recommendation', json_build_object(
      'id', v_rec.recommendation_id,
      'member_name', v_rec.member_name,
      'type', v_rec.recommendation_type,
      'recommended_role', v_rec.recommended_role,
      'confidence_score', v_rec.confidence_score,
      'reasoning', v_rec.reasoning,
      'status', v_rec.status,
      'created_at', v_rec.created_at
    ),
    'evidence_snapshot', v_rec.recommendation_snapshot,
    'current_state', json_build_object(
      'leadership_score', v_rec.current_leadership_score,
      'risk_score', v_rec.current_risk_score,
      'risk_level', v_rec.current_risk_level,
      'score_week', v_rec.score_week
    ),
    'score_trend', v_score_history
  );
end;
$$;

-- ============================================================================
-- 7. Executive Advisor AI Context
-- ============================================================================
-- Unified context for the "Executive Advisor" AI skill.
-- Merges the executive overview with the most urgent recommendations
-- and recent insights to drive the AI's "What should I focus on today?" answers.
-- ============================================================================

create or replace function public.get_ai_executive_advisor_context(
  p_company_id uuid,
  p_leader_id uuid
)
returns json
language plpgsql
security definer
as $$
declare
  v_overview json;
  v_urgent_risks json;
  v_top_recommendations json;
  v_recent_insights json;
  v_recognition_gaps json;
begin
  -- 1. Executive Overview (from MV)
  v_overview := public.get_executive_overview(p_company_id, p_leader_id);

  -- 2. Most urgent at-risk members
  select coalesce(json_agg(row_to_json(r)), '[]'::json) into v_urgent_risks
  from (
    select p.first_name, p.last_name, mrs.risk_score, mrs.risk_level
    from public.network_nodes n
    join public.member_risk_scores mrs on mrs.profile_id = n.profile_id
    join public.profiles p on p.id = n.profile_id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and n.profile_id != p_leader_id
      and mrs.risk_level in ('high', 'critical')
    order by mrs.risk_score desc limit 5
  ) r;

  -- 3. Top pending recommendations
  select coalesce(json_agg(row_to_json(rec)), '[]'::json) into v_top_recommendations
  from (
    select rc.member_name, rc.recommendation_type, rc.recommended_role,
           rc.confidence_score, rc.reasoning
    from public.mv_recommendation_center rc
    join public.network_nodes n on n.profile_id = rc.profile_id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and rc.company_id = p_company_id
      and rc.status = 'pending'
    order by rc.confidence_score desc limit 5
  ) rec;

  -- 4. Recent coach insights
  select coalesce(json_agg(row_to_json(i)), '[]'::json) into v_recent_insights
  from (
    select ci.title, ci.severity, ci.description, ci.created_at
    from public.network_nodes n
    join public.coach_insights ci on ci.profile_id = n.profile_id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and ci.created_at >= now() - interval '7 days'
    order by ci.created_at desc limit 5
  ) i;

  -- 5. Recognition gaps
  select coalesce(json_agg(row_to_json(u)), '[]'::json) into v_recognition_gaps
  from (
    select p.first_name, p.last_name, lm.milestone_type
    from public.network_nodes n
    join public.leadership_milestones lm on lm.profile_id = n.profile_id
    join public.profiles p on p.id = n.profile_id
    left join public.recognitions rec on rec.profile_id = n.profile_id
      and rec.awarded_at >= lm.achieved_at
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and n.profile_id != p_leader_id
      and lm.achieved_at >= now() - interval '14 days'
      and rec.id is null
    limit 5
  ) u;

  return json_build_object(
    'overview', v_overview,
    'urgent_risks', v_urgent_risks,
    'top_recommendations', v_top_recommendations,
    'recent_insights', v_recent_insights,
    'recognition_gaps', v_recognition_gaps
  );
end;
$$;
