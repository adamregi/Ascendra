-- ============================================================================
-- 044_f7_growth_analytics.sql — Growth Materialized Views
-- ============================================================================

-- 1. mv_growth_analytics
create materialized view if not exists public.mv_growth_analytics as
with latest_snapshots as (
  select distinct on (profile_id) *
  from public.member_performance_snapshots
  order by profile_id, snapshot_date desc
),
prev_30d_snapshots as (
  select distinct on (profile_id) *
  from public.member_performance_snapshots
  where snapshot_date <= current_date - interval '30 days'
  order by profile_id, snapshot_date desc
),
prev_60d_snapshots as (
  select distinct on (profile_id) *
  from public.member_performance_snapshots
  where snapshot_date <= current_date - interval '60 days'
  order by profile_id, snapshot_date desc
)
select
  curr.profile_id,
  curr.company_id,
  
  -- Current values
  curr.attendance_score as current_attendance,
  curr.task_score as current_tasks,
  curr.risk_level as current_risk,
  
  -- 30 Day Deltas
  curr.attendance_score - coalesce(p30.attendance_score, curr.attendance_score) as attendance_delta_30d,
  curr.task_score - coalesce(p30.task_score, curr.task_score) as task_delta_30d,
  
  -- 60 Day Deltas
  curr.attendance_score - coalesce(p60.attendance_score, curr.attendance_score) as attendance_delta_60d,
  curr.task_score - coalesce(p60.task_score, curr.task_score) as task_delta_60d,
  
  -- Trends
  case 
    when (curr.attendance_score - coalesce(p30.attendance_score, curr.attendance_score)) > 10 then 'Strong Positive'
    when (curr.attendance_score - coalesce(p30.attendance_score, curr.attendance_score)) > 0 then 'Positive'
    when (curr.attendance_score - coalesce(p30.attendance_score, curr.attendance_score)) < -10 then 'Strong Negative'
    when (curr.attendance_score - coalesce(p30.attendance_score, curr.attendance_score)) < 0 then 'Negative'
    else 'Stable'
  end as attendance_trend_text,
  
  now() as generated_at
from latest_snapshots curr
left join prev_30d_snapshots p30 on p30.profile_id = curr.profile_id
left join prev_60d_snapshots p60 on p60.profile_id = curr.profile_id;

create unique index on public.mv_growth_analytics (profile_id);

-- 2. mv_leadership_pipeline
create materialized view if not exists public.mv_leadership_pipeline as
with latest_scores as (
  select distinct on (profile_id) *
  from public.leadership_score_history
  order by profile_id, week_start desc
)
select
  profile_id,
  company_id,
  leadership_score,
  case 
    when leadership_score >= 90 then 'Future Leader'
    when leadership_score >= 75 then 'Emerging Leader'
    when leadership_score >= 60 then 'Developing'
    else 'Needs Development'
  end as leadership_band,
  now() as generated_at
from latest_scores;

create unique index on public.mv_leadership_pipeline (profile_id);

-- 3. mv_top_performers
create materialized view if not exists public.mv_top_performers as
with active_members as (
  select profile_id, company_id, member_health_score
  from public.member_performance_snapshots
  where snapshot_date = current_date
)
select
  profile_id,
  company_id,
  member_health_score,
  percent_rank() over (partition by company_id order by member_health_score desc) as company_percentile,
  now() as generated_at
from active_members
where member_health_score >= 85;

create unique index on public.mv_top_performers (profile_id);

-- 4. mv_promotion_candidates
create materialized view if not exists public.mv_promotion_candidates as
select
  lp.profile_id,
  lp.company_id,
  lp.leadership_score,
  lp.leadership_band,
  ga.attendance_delta_60d,
  ga.task_delta_60d,
  tp.company_percentile,
  now() as generated_at
from public.mv_leadership_pipeline lp
join public.mv_growth_analytics ga on ga.profile_id = lp.profile_id
left join public.mv_top_performers tp on tp.profile_id = lp.profile_id
where lp.leadership_band in ('Future Leader', 'Emerging Leader')
  and (ga.attendance_delta_30d >= 0) -- Sustained or improving
  and (ga.task_delta_30d >= 0);

create unique index on public.mv_promotion_candidates (profile_id);
