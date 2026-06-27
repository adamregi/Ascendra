-- ============================================================================
-- 046_f7_growth_jobs.sql — Growth Intelligence Jobs
-- ============================================================================

-- 1. Update existing daily refresh wrapper
create or replace function public.refresh_all_analytics()
returns void
language plpgsql
security definer
as $$
begin
  -- Existing operational layers
  perform public.refresh_member_analytics();
  perform public.refresh_team_analytics();
  perform public.refresh_meeting_analytics();
  perform public.refresh_task_analytics();
  
  -- F7 Growth Layers (Daily MVs)
  refresh materialized view concurrently public.mv_growth_analytics;
  refresh materialized view concurrently public.mv_leadership_pipeline;
  refresh materialized view concurrently public.mv_top_performers;
  refresh materialized view concurrently public.mv_promotion_candidates;
end;
$$;

-- 2. Create Weekly Growth Intelligence Wrapper
create or replace function public.refresh_growth_intelligence()
returns void
language plpgsql
security definer
as $$
begin
  -- Step 1: Calculate leadership scores (inserts into history)
  perform public.calculate_leadership_scores();
  
  -- Step 2: Calculate milestones for recent activity
  perform public.calculate_milestones();
  
  -- Step 3: Refresh the MVs immediately so recommendations use fresh data
  refresh materialized view concurrently public.mv_leadership_pipeline;
  refresh materialized view concurrently public.mv_promotion_candidates;
  
  -- Step 4: Generate Recommendations
  perform public.generate_leadership_recommendations();
end;
$$;

-- Enable pg_cron (if not already enabled) and schedule jobs
-- Note: actual scheduling would depend on the pg_cron extension being available.
-- Assuming pg_cron is enabled:
do $$
begin
  if exists (select 1 from pg_extension where extname = 'pg_cron') then
    -- Schedule Daily Analytics Refresh at 1:00 AM
    perform cron.schedule('refresh_all_analytics_job', '0 1 * * *', 'select public.refresh_all_analytics()');
    
    -- Schedule Weekly Growth Intelligence at 2:00 AM on Sunday
    perform cron.schedule('refresh_growth_intelligence_job', '0 2 * * 0', 'select public.refresh_growth_intelligence()');
  end if;
end
$$;
