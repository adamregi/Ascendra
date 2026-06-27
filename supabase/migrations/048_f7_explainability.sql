-- ============================================================================
-- 048_f7_explainability.sql — Recommendation Explainability Layer
-- ============================================================================
-- Every AI recommendation must be auditable. When a user asks:
--   "Why was John recommended for promotion 4 months ago?"
-- the system must return the EXACT historical state of the member at the
-- moment the recommendation was generated — not the current analytics.
-- ============================================================================

-- ============================================================================
-- 1. Add recommendation_snapshot to leadership_recommendations
-- ============================================================================
-- This column captures a full frozen snapshot of the member's metrics at the
-- exact moment the recommendation was generated. It is immutable once written.
-- ============================================================================

alter table public.leadership_recommendations
  add column if not exists recommendation_snapshot jsonb;

comment on column public.leadership_recommendations.recommendation_snapshot is
  'Immutable frozen snapshot of member metrics at recommendation creation time. '
  'Contains leadership_score breakdown, attendance/task rates, growth deltas, '
  'and risk level as they existed when this recommendation was generated. '
  'Used for historical explainability — never overwritten.';

-- ============================================================================
-- 2. Rebuild generate_leadership_recommendations() with full evidence
-- ============================================================================

create or replace function public.generate_leadership_recommendations()
returns void
language plpgsql
security definer
as $$
declare
  v_member record;
  v_snapshot jsonb;
begin
  for v_member in (
    select
      lp.profile_id,
      lp.company_id,
      lp.leadership_score,
      lp.leadership_band,
      -- Leadership score components from history
      lsh.attendance_component,
      lsh.task_component,
      lsh.consistency_component,
      lsh.growth_component,
      lsh.risk_component,
      -- Growth analytics
      ga.current_attendance,
      ga.current_tasks,
      ga.current_risk,
      ga.attendance_delta_30d,
      ga.task_delta_30d,
      ga.attendance_delta_60d,
      ga.task_delta_60d,
      ga.attendance_trend_text,
      -- Risk
      mrs.risk_score,
      mrs.risk_level as member_risk_level,
      -- Top performer percentile
      tp.company_percentile
    from public.mv_leadership_pipeline lp
    left join lateral (
      select * from public.leadership_score_history h
      where h.profile_id = lp.profile_id
      order by h.week_start desc limit 1
    ) lsh on true
    left join public.mv_growth_analytics ga on ga.profile_id = lp.profile_id
    left join public.member_risk_scores mrs on mrs.profile_id = lp.profile_id
    left join public.mv_top_performers tp on tp.profile_id = lp.profile_id
    where lp.leadership_band = 'Future Leader'
  ) loop

    -- Skip if a pending promotion already exists for this member
    if exists (
      select 1 from public.leadership_recommendations
      where profile_id = v_member.profile_id
        and recommendation_type = 'promotion'
        and status = 'pending'
    ) then
      continue;
    end if;

    -- Build the immutable evidence snapshot
    v_snapshot := jsonb_build_object(
      -- Leadership score breakdown
      'leadership_score', v_member.leadership_score,
      'attendance_component', v_member.attendance_component,
      'task_component', v_member.task_component,
      'consistency_component', v_member.consistency_component,
      'growth_component', v_member.growth_component,
      'risk_component', v_member.risk_component,
      -- Current operational metrics
      'current_attendance_score', v_member.current_attendance,
      'current_task_score', v_member.current_tasks,
      'current_risk_level', v_member.current_risk,
      -- Trend data
      'attendance_delta_30d', v_member.attendance_delta_30d,
      'task_delta_30d', v_member.task_delta_30d,
      'attendance_delta_60d', v_member.attendance_delta_60d,
      'task_delta_60d', v_member.task_delta_60d,
      'attendance_trend', v_member.attendance_trend_text,
      -- Risk data
      'risk_score', v_member.risk_score,
      'member_risk_level', v_member.member_risk_level,
      -- Ranking
      'company_percentile', v_member.company_percentile,
      -- Metadata
      'snapshot_taken_at', now(),
      'leadership_band', v_member.leadership_band
    );

    insert into public.leadership_recommendations (
      profile_id, company_id, recommendation_type, recommended_role,
      confidence_score, reasoning, recommendation_snapshot
    ) values (
      v_member.profile_id,
      v_member.company_id,
      'promotion',
      'Sub-Leader',
      v_member.leadership_score,
      jsonb_build_array(
        'Leadership score: ' || round(v_member.leadership_score, 0),
        'Leadership band: ' || v_member.leadership_band,
        'Attendance trend: ' || coalesce(v_member.attendance_trend_text, 'N/A'),
        'Attendance delta (30d): ' || coalesce(round(v_member.attendance_delta_30d, 1)::text, 'N/A'),
        'Task delta (30d): ' || coalesce(round(v_member.task_delta_30d, 1)::text, 'N/A'),
        'Company percentile: ' || coalesce(round(v_member.company_percentile::numeric * 100, 1)::text, 'N/A') || '%'
      ),
      v_snapshot
    );
  end loop;
end;
$$;

-- ============================================================================
-- 3. Update promotion advisor context to surface explainability data
-- ============================================================================

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

  -- Include the full recommendation_snapshot for explainability
  select coalesce(json_agg(row_to_json(r)), '[]'::json) into v_recommendations
  from (
    select
      p.first_name, p.last_name,
      lr.recommended_role, lr.confidence_score, lr.reasoning,
      lr.recommendation_snapshot,
      lr.created_at
    from public.network_nodes n
    join public.leadership_recommendations lr on lr.profile_id = n.profile_id
    join public.profiles p on p.id = n.profile_id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and n.profile_id != p_leader_id
      and lr.status = 'pending' and lr.recommendation_type = 'promotion'
    order by lr.created_at desc limit 10
  ) r;

  return json_build_object('promotion_candidates', v_candidates, 'pending_recommendations', v_recommendations);
end;
$$;
