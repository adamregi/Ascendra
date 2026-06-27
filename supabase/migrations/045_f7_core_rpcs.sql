-- ============================================================================
-- 045_f7_core_rpcs.sql — Core Growth & Leadership RPCs
-- ============================================================================

-- 1. Calculate Leadership Scores
create or replace function public.calculate_leadership_scores()
returns void
language plpgsql
security definer
as $$
declare
  v_member record;
  v_score numeric;
  v_att numeric;
  v_task numeric;
  v_consistency numeric;
  v_growth numeric;
  v_risk numeric;
  v_week_start date := date_trunc('week', current_date)::date;
begin
  for v_member in (
    select
      p.id as profile_id,
      p.company_id,
      mva.meetings_attended_30d,
      mva.meetings_assigned_30d,
      mva.tasks_completed_30d,
      mva.tasks_assigned_30d,
      ga.attendance_delta_30d,
      ga.task_delta_30d,
      mrs.risk_score
    from public.profiles p
    left join public.mv_member_analytics mva on mva.profile_id = p.id
    left join public.mv_growth_analytics ga on ga.profile_id = p.id
    left join public.member_risk_scores mrs on mrs.profile_id = p.id
    where p.role != 'admin'
  ) loop
    
    -- 1. Attendance Component (25%)
    if coalesce(v_member.meetings_assigned_30d, 0) > 0 then
      v_att := (v_member.meetings_attended_30d::numeric / v_member.meetings_assigned_30d) * 100.0;
    else
      v_att := 50.0; -- Neutral if no meetings
    end if;

    -- 2. Task Component (25%)
    if coalesce(v_member.tasks_assigned_30d, 0) > 0 then
      v_task := (v_member.tasks_completed_30d::numeric / v_member.tasks_assigned_30d) * 100.0;
    else
      v_task := 50.0; -- Neutral if no tasks
    end if;

    -- 3. Consistency Component (20%)
    -- Simplistic approach: if attendance and task > 80%, high consistency
    v_consistency := ((v_att + v_task) / 2.0);

    -- 4. Growth Trend (20%)
    -- Base 50, + delta up to 100
    v_growth := least(greatest(50.0 + coalesce(v_member.attendance_delta_30d, 0) + coalesce(v_member.task_delta_30d, 0), 0.0), 100.0);

    -- 5. Risk History (10%)
    -- Risk score is 0 (best) to 100 (worst). Component should be inverse.
    v_risk := 100.0 - coalesce(v_member.risk_score, 0);

    -- Calculate total
    v_score := (v_att * 0.25) + (v_task * 0.25) + (v_consistency * 0.20) + (v_growth * 0.20) + (v_risk * 0.10);

    insert into public.leadership_score_history (
      profile_id, company_id, week_start, leadership_score, 
      attendance_component, task_component, consistency_component, growth_component, risk_component
    ) values (
      v_member.profile_id, v_member.company_id, v_week_start, v_score,
      v_att, v_task, v_consistency, v_growth, v_risk
    )
    on conflict (profile_id, week_start) do update set
      leadership_score = excluded.leadership_score,
      attendance_component = excluded.attendance_component,
      task_component = excluded.task_component,
      consistency_component = excluded.consistency_component,
      growth_component = excluded.growth_component,
      risk_component = excluded.risk_component;
      
  end loop;
end;
$$;

-- 2. Calculate Milestones
create or replace function public.calculate_milestones()
returns void
language plpgsql
security definer
as $$
declare
  v_member record;
begin
  for v_member in (
    select profile_id, company_id, attendance_rate_30d, tasks_completed_30d
    from public.mv_member_analytics
  ) loop
    -- Perfect Attendance Milestone
    if coalesce(v_member.attendance_rate_30d, 0) = 100 then
      insert into public.leadership_milestones (profile_id, company_id, milestone_type)
      values (v_member.profile_id, v_member.company_id, '100% attendance 30 days')
      on conflict do nothing;
    end if;

    -- Task Master Milestone
    if coalesce(v_member.tasks_completed_30d, 0) >= 10 then
      insert into public.leadership_milestones (profile_id, company_id, milestone_type)
      values (v_member.profile_id, v_member.company_id, '10+ tasks completed 30 days')
      on conflict do nothing;
    end if;
  end loop;
end;
$$;

-- 3. Generate Leadership Recommendations
create or replace function public.generate_leadership_recommendations()
returns void
language plpgsql
security definer
as $$
declare
  v_member record;
begin
  -- Identify candidates for promotion recommendations
  for v_member in (
    select lp.profile_id, lp.company_id, lp.leadership_score, lp.leadership_band
    from public.mv_leadership_pipeline lp
    where lp.leadership_band = 'Future Leader'
  ) loop
    -- Insert if no pending promotion exists
    if not exists (
      select 1 from public.leadership_recommendations
      where profile_id = v_member.profile_id 
        and recommendation_type = 'promotion'
        and status = 'pending'
    ) then
      insert into public.leadership_recommendations (
        profile_id, company_id, recommendation_type, recommended_role, confidence_score, reasoning
      ) values (
        v_member.profile_id, v_member.company_id, 'promotion', 'Sub-Leader', 
        v_member.leadership_score, 
        jsonb_build_array('Leadership score ' || round(v_member.leadership_score, 0), 'Maintained Future Leader band')
      );
    end if;
  end loop;
end;
$$;

-- 4. Context Builder RPC: Growth Opportunity
create or replace function public.get_ai_growth_opportunity_context(
  p_company_id uuid,
  p_leader_id uuid
)
returns json
language plpgsql
security definer
as $$
declare
  v_growth json;
  v_top json;
begin
  select coalesce(json_agg(row_to_json(g)), '[]'::json) into v_growth
  from (
    select p.first_name, p.last_name, ga.attendance_delta_30d, ga.task_delta_30d, ga.attendance_trend_text
    from public.network_nodes n
    join public.mv_growth_analytics ga on ga.profile_id = n.profile_id
    join public.profiles p on p.id = n.profile_id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and n.profile_id != p_leader_id
      and (ga.attendance_delta_30d > 10 or ga.task_delta_30d > 10)
    order by ga.attendance_delta_30d desc limit 5
  ) g;

  select coalesce(json_agg(row_to_json(t)), '[]'::json) into v_top
  from (
    select p.first_name, p.last_name, tp.member_health_score, tp.company_percentile
    from public.network_nodes n
    join public.mv_top_performers tp on tp.profile_id = n.profile_id
    join public.profiles p on p.id = n.profile_id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and n.profile_id != p_leader_id
    order by tp.member_health_score desc limit 5
  ) t;

  return json_build_object('fastest_growing', v_growth, 'top_performers', v_top);
end;
$$;

-- 5. Context Builder RPC: Promotion Advisor
create or replace function public.get_ai_promotion_advisor_context(
  p_company_id uuid,
  p_leader_id uuid
)
returns json
language plpgsql
security definer
as $$
declare
  v_candidates json;
  v_recommendations json;
begin
  select coalesce(json_agg(row_to_json(c)), '[]'::json) into v_candidates
  from (
    select p.first_name, p.last_name, pc.leadership_score, pc.leadership_band, pc.company_percentile
    from public.network_nodes n
    join public.mv_promotion_candidates pc on pc.profile_id = n.profile_id
    join public.profiles p on p.id = n.profile_id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and n.profile_id != p_leader_id
    order by pc.leadership_score desc limit 5
  ) c;

  select coalesce(json_agg(row_to_json(r)), '[]'::json) into v_recommendations
  from (
    select p.first_name, p.last_name, lr.recommended_role, lr.confidence_score, lr.reasoning
    from public.network_nodes n
    join public.leadership_recommendations lr on lr.profile_id = n.profile_id
    join public.profiles p on p.id = n.profile_id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and n.profile_id != p_leader_id
      and lr.status = 'pending' and lr.recommendation_type = 'promotion'
  ) r;

  return json_build_object('promotion_candidates', v_candidates, 'pending_recommendations', v_recommendations);
end;
$$;

-- 6. Context Builder RPC: Recognition Coach
create or replace function public.get_ai_recognition_coach_context(
  p_company_id uuid,
  p_leader_id uuid
)
returns json
language plpgsql
security definer
as $$
declare
  v_milestones json;
  v_recent_recognitions json;
begin
  select coalesce(json_agg(row_to_json(m)), '[]'::json) into v_milestones
  from (
    select p.first_name, p.last_name, lm.milestone_type, lm.achieved_at
    from public.network_nodes n
    join public.leadership_milestones lm on lm.profile_id = n.profile_id
    join public.profiles p on p.id = n.profile_id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and n.profile_id != p_leader_id
      and lm.achieved_at >= now() - interval '14 days'
    order by lm.achieved_at desc limit 10
  ) m;

  select coalesce(json_agg(row_to_json(r)), '[]'::json) into v_recent_recognitions
  from (
    select p.first_name, p.last_name, rec.recognition_title, rec.awarded_at
    from public.network_nodes n
    join public.recognitions rec on rec.profile_id = n.profile_id
    join public.profiles p on p.id = n.profile_id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and n.profile_id != p_leader_id
      and rec.awarded_at >= now() - interval '30 days'
    order by rec.awarded_at desc limit 5
  ) r;

  return json_build_object('recent_milestones', v_milestones, 'recent_leader_recognitions', v_recent_recognitions);
end;
$$;
