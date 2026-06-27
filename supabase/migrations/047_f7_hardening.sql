-- ============================================================================
-- 047_f7_hardening.sql — Production Hardening
-- ============================================================================
-- Fixes:
--   1. CONCURRENTLY-in-PL/pgSQL bug (F5 and F7)
--   2. Milestone deduplication
--   3. Cron job idempotency
--   4. Snapshot resiliency for mv_top_performers
--   5. Independent cron jobs with correct execution order
--   6. Weekly intelligence pipeline ordering
-- ============================================================================

-- ============================================================================
-- FIX 1: Remove CONCURRENTLY from all PL/pgSQL wrappers
-- ============================================================================
-- PostgreSQL does not allow REFRESH MATERIALIZED VIEW CONCURRENTLY inside
-- a PL/pgSQL function because functions execute within an implicit
-- transaction block, and CONCURRENTLY requires its own transaction.
--
-- Resolution: The PL/pgSQL wrappers for MV refresh are dropped entirely.
-- pg_cron will invoke REFRESH ... CONCURRENTLY as standalone SQL statements.
-- The original refresh_*() helper functions from 037 are also replaced.
-- ============================================================================

-- Drop the broken wrappers from 046
drop function if exists public.refresh_all_analytics();
drop function if exists public.refresh_growth_intelligence();

-- Drop the broken per-MV wrappers from 037
drop function if exists public.refresh_member_analytics();
drop function if exists public.refresh_team_analytics();
drop function if exists public.refresh_meeting_analytics();
drop function if exists public.refresh_task_analytics();

-- ============================================================================
-- FIX 1b: Create a safe weekly intelligence wrapper
-- ============================================================================
-- This function performs ONLY the row-level calculations (INSERT/UPSERT).
-- It does NOT attempt any MV refresh. MV refreshes are handled by pg_cron
-- as standalone SQL statements scheduled AFTER this function completes.
-- ============================================================================

create or replace function public.refresh_growth_intelligence()
returns void
language plpgsql
security definer
as $$
begin
  -- Step 1: Calculate leadership scores (inserts into leadership_score_history)
  perform public.calculate_leadership_scores();

  -- Step 2: Calculate milestones for recent activity
  perform public.calculate_milestones();

  -- Step 3: Generate leadership recommendations
  -- Note: This reads mv_leadership_pipeline which was refreshed by the
  -- DAILY pipeline earlier. The weekly pipeline refreshes it AGAIN after
  -- this function completes (via pg_cron) to reflect the new scores.
  perform public.generate_leadership_recommendations();
end;
$$;

-- ============================================================================
-- FIX 2: Milestone Deduplication
-- ============================================================================
-- The old constraint unique(profile_id, milestone_type, achieved_at) is
-- useless because achieved_at defaults to now(), making every row unique.
--
-- New design:
--   - Add reference_period (date) to anchor milestones to a calendar period.
--   - For one-time milestones: reference_period = NULL, with a partial unique
--     index on (profile_id, milestone_type) WHERE reference_period IS NULL.
--   - For recurring milestones (e.g., "Monthly Top Performer"):
--     reference_period = date_trunc('month', now())::date, with a unique
--     constraint on (profile_id, milestone_type, reference_period).
-- ============================================================================

-- Add reference_period column
alter table public.leadership_milestones
  add column if not exists reference_period date;

-- Drop the broken constraint
alter table public.leadership_milestones
  drop constraint if exists leadership_milestones_unique;

-- New constraint for recurring milestones (where reference_period is set)
create unique index if not exists leadership_milestones_recurring_uq
  on public.leadership_milestones (profile_id, milestone_type, reference_period)
  where reference_period is not null;

-- New constraint for one-time milestones (where reference_period is null)
create unique index if not exists leadership_milestones_onetime_uq
  on public.leadership_milestones (profile_id, milestone_type)
  where reference_period is null;

-- ============================================================================
-- FIX 2b: Update calculate_milestones() for proper deduplication
-- ============================================================================

create or replace function public.calculate_milestones()
returns void
language plpgsql
security definer
as $$
declare
  v_member record;
  v_current_month date := date_trunc('month', current_date)::date;
begin
  for v_member in (
    select profile_id, company_id, attendance_rate_30d, tasks_completed_30d
    from public.mv_member_analytics
  ) loop

    -- Perfect Attendance (recurring monthly milestone)
    if coalesce(v_member.attendance_rate_30d, 0) = 100 then
      insert into public.leadership_milestones (profile_id, company_id, milestone_type, reference_period)
      values (v_member.profile_id, v_member.company_id, '100% attendance 30 days', v_current_month)
      on conflict do nothing;
    end if;

    -- Task Master (recurring monthly milestone)
    if coalesce(v_member.tasks_completed_30d, 0) >= 10 then
      insert into public.leadership_milestones (profile_id, company_id, milestone_type, reference_period)
      values (v_member.profile_id, v_member.company_id, '10+ tasks completed 30 days', v_current_month)
      on conflict do nothing;
    end if;

  end loop;
end;
$$;

-- ============================================================================
-- FIX 3: Snapshot Resiliency for mv_top_performers
-- ============================================================================
-- The original MV used WHERE snapshot_date = current_date, which returns
-- empty if today's snapshot hasn't been generated yet.
-- Fix: Use DISTINCT ON to get the latest available snapshot per member.
-- ============================================================================

drop materialized view if exists public.mv_promotion_candidates;
drop materialized view if exists public.mv_top_performers;

create materialized view public.mv_top_performers as
with latest_snapshots as (
  select distinct on (profile_id)
    profile_id, company_id, member_health_score
  from public.member_performance_snapshots
  order by profile_id, snapshot_date desc
)
select
  profile_id,
  company_id,
  member_health_score,
  percent_rank() over (partition by company_id order by member_health_score desc) as company_percentile,
  now() as generated_at
from latest_snapshots
where member_health_score >= 85;

create unique index on public.mv_top_performers (profile_id);

-- ============================================================================
-- FIX 4: Recreate mv_promotion_candidates (depends on mv_top_performers)
-- ============================================================================
-- Also fixes: the original query referenced ga.attendance_delta_30d in the
-- WHERE clause but that column name is correct in mv_growth_analytics.
-- No column name fix needed, but we must recreate after dropping.
-- ============================================================================

create materialized view public.mv_promotion_candidates as
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
  and (ga.attendance_delta_30d >= 0)
  and (ga.task_delta_30d >= 0);

create unique index on public.mv_promotion_candidates (profile_id);

-- ============================================================================
-- FIX 5: Cron Job Idempotency & Independent Scheduling
-- ============================================================================
-- Unschedule before scheduling to prevent duplicates on migration rerun.
-- All MV refreshes are standalone CONCURRENTLY statements — NOT inside
-- PL/pgSQL functions.
-- ============================================================================

do $$
begin
  if exists (select 1 from pg_extension where extname = 'pg_cron') then

    -- =============================
    -- Clean up any prior jobs
    -- =============================
    begin perform cron.unschedule('daily_mv_member_analytics');        exception when others then null; end;
    begin perform cron.unschedule('daily_mv_team_analytics');          exception when others then null; end;
    begin perform cron.unschedule('daily_mv_meeting_analytics');       exception when others then null; end;
    begin perform cron.unschedule('daily_mv_task_analytics');          exception when others then null; end;
    begin perform cron.unschedule('daily_mv_growth_analytics');        exception when others then null; end;
    begin perform cron.unschedule('daily_mv_top_performers');          exception when others then null; end;
    begin perform cron.unschedule('daily_mv_leadership_pipeline');     exception when others then null; end;
    begin perform cron.unschedule('daily_mv_promotion_candidates');    exception when others then null; end;
    begin perform cron.unschedule('weekly_growth_intelligence');       exception when others then null; end;
    begin perform cron.unschedule('weekly_mv_leadership_pipeline');    exception when others then null; end;
    begin perform cron.unschedule('weekly_mv_promotion_candidates');   exception when others then null; end;
    -- Clean up legacy jobs from 046
    begin perform cron.unschedule('refresh_all_analytics_job');        exception when others then null; end;
    begin perform cron.unschedule('refresh_growth_intelligence_job');  exception when others then null; end;

    -- =============================
    -- DAILY PIPELINE (01:00–01:15)
    -- =============================
    -- F5 Operational MVs
    perform cron.schedule('daily_mv_member_analytics',     '0  1 * * *', 'REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_member_analytics');
    perform cron.schedule('daily_mv_team_analytics',       '3  1 * * *', 'REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_team_analytics');
    perform cron.schedule('daily_mv_meeting_analytics',    '6  1 * * *', 'REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_meeting_analytics');
    perform cron.schedule('daily_mv_task_analytics',       '9  1 * * *', 'REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_task_analytics');

    -- F7 Growth MVs (depend on F5 MVs being fresh, scheduled after)
    perform cron.schedule('daily_mv_growth_analytics',     '12 1 * * *', 'REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_growth_analytics');
    perform cron.schedule('daily_mv_top_performers',       '15 1 * * *', 'REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_top_performers');
    perform cron.schedule('daily_mv_leadership_pipeline',  '18 1 * * *', 'REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_leadership_pipeline');
    perform cron.schedule('daily_mv_promotion_candidates', '21 1 * * *', 'REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_promotion_candidates');

    -- =============================
    -- WEEKLY PIPELINE (Sunday 02:00–02:15)
    -- =============================
    -- Step 1: Run intelligence calculations (writes to tables, not MVs)
    perform cron.schedule('weekly_growth_intelligence',    '0  2 * * 0', 'SELECT public.refresh_growth_intelligence()');

    -- Step 2: Refresh leadership MVs AFTER new scores are written
    perform cron.schedule('weekly_mv_leadership_pipeline', '10 2 * * 0', 'REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_leadership_pipeline');
    perform cron.schedule('weekly_mv_promotion_candidates','13 2 * * 0', 'REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_promotion_candidates');

  end if;
end
$$;

-- ============================================================================
-- FIX 6: Add missing scalability indexes
-- ============================================================================

-- coach_insights: commonly joined on profile_id and filtered by created_at
create index if not exists coach_insights_profile_created_idx
  on public.coach_insights (profile_id, created_at desc);

-- leadership_recommendations: commonly filtered by status + type
create index if not exists leadership_rec_status_type_idx
  on public.leadership_recommendations (status, recommendation_type);

-- member_performance_snapshots: DISTINCT ON queries need this
create index if not exists member_perf_profile_date_desc_idx
  on public.member_performance_snapshots (profile_id, snapshot_date desc);

-- leadership_score_history: DISTINCT ON queries need this
create index if not exists leadership_history_profile_week_desc_idx
  on public.leadership_score_history (profile_id, week_start desc);

-- recognitions: filtered by awarded_at in context builders
create index if not exists recognitions_profile_awarded_idx
  on public.recognitions (profile_id, awarded_at desc);
