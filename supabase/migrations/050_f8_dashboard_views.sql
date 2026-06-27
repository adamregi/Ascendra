-- ============================================================================
-- 050_f8_dashboard_views.sql — Executive Dashboard Materialized Views
-- ============================================================================
-- Architecture Principle: Dashboard views consume ONLY existing MVs,
-- snapshot tables, and recommendation tables. They NEVER query raw
-- operational tables (meetings, tasks, followups, etc.) directly.
-- ============================================================================

-- ============================================================================
-- 1. mv_executive_overview
-- ============================================================================
-- One row per leader. Provides the full executive summary consuming:
--   mv_team_analytics        (F5)
--   mv_growth_analytics      (F7)
--   mv_leadership_pipeline   (F7)
--   mv_top_performers        (F7)
--   member_risk_scores       (F6)
--   leadership_recommendations (F7)
-- ============================================================================

create materialized view if not exists public.mv_executive_overview as
with leader_downline as (
  -- Pre-compute each leader's downline profile_ids
  select
    l.profile_id as leader_id,
    l.company_id,
    array_agg(d.profile_id) as downline_ids
  from public.network_nodes l
  join public.network_nodes d on d.path_ltree <@ l.path_ltree and d.profile_id != l.profile_id
  join public.profiles p on p.id = l.profile_id and p.role = 'leader'
  group by l.profile_id, l.company_id
),
team_stats as (
  select
    ld.leader_id,
    ld.company_id,

    -- Team Health (from mv_team_analytics)
    ta.avg_health_score as team_health_score,
    ta.team_size,
    ta.active_members,
    ta.attendance_rate as team_attendance_rate,
    ta.completion_rate as team_completion_rate,

    -- Risk Distribution (from member_risk_scores)
    count(mrs.profile_id) filter (where mrs.risk_level = 'low') as low_risk_count,
    count(mrs.profile_id) filter (where mrs.risk_level = 'medium') as medium_risk_count,
    count(mrs.profile_id) filter (where mrs.risk_level = 'high') as high_risk_count,
    count(mrs.profile_id) filter (where mrs.risk_level = 'critical') as critical_risk_count,

    -- Leadership Pipeline (from mv_leadership_pipeline)
    count(lp.profile_id) filter (where lp.leadership_band = 'Future Leader') as future_leaders,
    count(lp.profile_id) filter (where lp.leadership_band = 'Emerging Leader') as emerging_leaders,
    count(lp.profile_id) filter (where lp.leadership_band = 'Developing') as developing_members,
    count(lp.profile_id) filter (where lp.leadership_band = 'Needs Development') as needs_development,

    -- Top Performers (from mv_top_performers)
    count(tp.profile_id) as top_performer_count,

    -- Growth (from mv_growth_analytics, aggregated)
    avg(ga.attendance_delta_30d) as avg_attendance_growth_30d,
    avg(ga.task_delta_30d) as avg_task_growth_30d,

    -- Pending Recommendations (from leadership_recommendations)
    count(lr.id) filter (where lr.status = 'pending' and lr.recommendation_type = 'promotion') as pending_promotions,
    count(lr.id) filter (where lr.status = 'pending' and lr.recommendation_type = 'recognition') as pending_recognitions,
    count(lr.id) filter (where lr.status = 'pending' and lr.recommendation_type = 'mentorship') as pending_mentorships,
    count(lr.id) filter (where lr.status = 'pending' and lr.recommendation_type = 'training') as pending_trainings,
    count(lr.id) filter (where lr.status = 'pending' and lr.recommendation_type = 'coaching') as pending_coaching

  from leader_downline ld
  left join public.mv_team_analytics ta on ta.leader_id = ld.leader_id
  left join public.member_risk_scores mrs on mrs.profile_id = any(ld.downline_ids)
  left join public.mv_leadership_pipeline lp on lp.profile_id = any(ld.downline_ids)
  left join public.mv_top_performers tp on tp.profile_id = any(ld.downline_ids)
  left join public.mv_growth_analytics ga on ga.profile_id = any(ld.downline_ids)
  left join public.leadership_recommendations lr on lr.profile_id = any(ld.downline_ids)
  group by ld.leader_id, ld.company_id, ta.avg_health_score, ta.team_size, ta.active_members, ta.attendance_rate, ta.completion_rate
)
select
  leader_id,
  company_id,

  -- Health
  coalesce(team_health_score, 0) as team_health_score,
  team_size,
  active_members,
  coalesce(team_attendance_rate, 0) as team_attendance_rate,
  coalesce(team_completion_rate, 0) as team_completion_rate,

  -- Growth
  coalesce(avg_attendance_growth_30d, 0) as team_growth_score,
  coalesce(avg_task_growth_30d, 0) as task_growth_score,

  -- Risk
  low_risk_count,
  medium_risk_count,
  high_risk_count,
  critical_risk_count,
  case
    when coalesce(team_size, 0) = 0 then 0
    else round(((high_risk_count + critical_risk_count)::numeric / team_size) * 100, 1)
  end as risk_percentage,

  -- Pipeline
  future_leaders,
  emerging_leaders,
  developing_members,
  needs_development,
  top_performer_count,

  -- Recommendations
  pending_promotions,
  pending_recognitions,
  pending_mentorships,
  pending_trainings,
  pending_coaching,
  (pending_promotions + pending_recognitions + pending_mentorships + pending_trainings + pending_coaching) as total_pending_actions,

  now() as generated_at

from team_stats;

create unique index on public.mv_executive_overview (leader_id);

-- ============================================================================
-- 2. mv_recommendation_center
-- ============================================================================
-- Denormalized view of all leadership_recommendations with member name,
-- evidence snapshot, and latest leadership score for the recommendation center.
-- ============================================================================

create materialized view if not exists public.mv_recommendation_center as
select
  lr.id as recommendation_id,
  lr.profile_id,
  lr.company_id,
  p.full_name as member_name,
  lr.recommendation_type,
  lr.recommended_role,
  lr.confidence_score,
  lr.reasoning,
  lr.recommendation_snapshot,
  lr.status,
  lr.created_at,
  lr.updated_at,
  -- Latest leadership score for context
  lsh.leadership_score as current_leadership_score,
  lsh.week_start as score_week,
  -- Risk context
  mrs.risk_score as current_risk_score,
  mrs.risk_level as current_risk_level
from public.leadership_recommendations lr
join public.profiles p on p.id = lr.profile_id
left join lateral (
  select leadership_score, week_start
  from public.leadership_score_history h
  where h.profile_id = lr.profile_id
  order by h.week_start desc limit 1
) lsh on true
left join public.member_risk_scores mrs on mrs.profile_id = lr.profile_id;

create unique index on public.mv_recommendation_center (recommendation_id);
create index on public.mv_recommendation_center (company_id, status);

-- ============================================================================
-- 3. Add new MVs to the daily cron pipeline
-- ============================================================================

do $$
begin
  if exists (select 1 from pg_extension where extname = 'pg_cron') then
    -- Clean up if they already exist
    begin perform cron.unschedule('daily_mv_executive_overview');      exception when others then null; end;
    begin perform cron.unschedule('daily_mv_recommendation_center');   exception when others then null; end;

    -- Schedule after all other MVs (01:24 and 01:27)
    perform cron.schedule('daily_mv_executive_overview',      '24 1 * * *', 'REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_executive_overview');
    perform cron.schedule('daily_mv_recommendation_center',   '27 1 * * *', 'REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_recommendation_center');
  end if;
end
$$;
