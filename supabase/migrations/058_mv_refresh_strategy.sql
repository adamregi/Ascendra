-- ============================================================================
-- 058_mv_refresh_strategy.sql — Materialized View Refresh Telemetry & Strategy
-- ============================================================================
-- This migration implements database-level tracking for materialized view
-- refreshes, ensuring that background workers have a unified telemetry layer
-- to monitor view staleness and refresh costs.

-- 1. Materialized View Refresh Logs Table
create table if not exists public.mv_refresh_logs (
  id uuid primary key default gen_random_uuid(),
  view_name text not null unique,
  refresh_policy text not null check (refresh_policy in ('Event-driven', '5 min', '30 min', 'Hourly')),
  last_refreshed_at timestamp with time zone,
  last_refresh_duration_ms integer,
  status text check (status in ('success', 'failed')),
  error_message text,
  updated_at timestamp with time zone default now()
);

-- Apply RLS
alter table public.mv_refresh_logs enable row level security;

-- Policies: Read-only for authenticated users (dashboards check latency), modifications only by service role
create policy "Users can view refresh strategy logs"
  on public.mv_refresh_logs
  for select
  using (true);

-- 2. Stored Procedure: Tracked concurrent refresh execution
create or replace function public.refresh_materialized_view_tracked(p_view_name text)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_start_time timestamp;
  v_end_time timestamp;
  v_duration_ms integer;
  v_policy text;
begin
  -- Validate target view exists in strategy log
  select refresh_policy into v_policy
  from public.mv_refresh_logs
  where view_name = p_view_name;

  if not found then
    return jsonb_build_object(
      'success', false,
      'error', format('Materialized view %s is not registered in mv_refresh_logs strategy catalog.', p_view_name)
    );
  end if;

  v_start_time := clock_timestamp();

  -- Execute view refresh based on sanitized name matching
  begin
    case p_view_name
      when 'mv_member_progress' then
        refresh materialized view concurrently public.mv_member_progress;
      when 'mv_company_dashboard_stats' then
        refresh materialized view concurrently public.mv_company_dashboard_stats;
      when 'mv_growth_analytics' then
        refresh materialized view concurrently public.mv_growth_analytics;
      when 'mv_leadership_pipeline' then
        refresh materialized view concurrently public.mv_leadership_pipeline;
      when 'mv_recommendation_center' then
        refresh materialized view concurrently public.mv_recommendation_center;
      else
        raise exception 'Invalid or unsupported materialized view name: %', p_view_name;
    end case;
    
    v_end_time := clock_timestamp();
    v_duration_ms := extract(epoch from (v_end_time - v_start_time)) * 1000;

    -- Update log with success telemetry
    update public.mv_refresh_logs
    set last_refreshed_at = v_end_time,
        last_refresh_duration_ms = v_duration_ms,
        status = 'success',
        error_message = null,
        updated_at = now()
    where view_name = p_view_name;

    return jsonb_build_object(
      'success', true,
      'view_name', p_view_name,
      'duration_ms', v_duration_ms,
      'refreshed_at', v_end_time
    );

  exception when others then
    v_end_time := clock_timestamp();
    v_duration_ms := extract(epoch from (v_end_time - v_start_time)) * 1000;

    -- Update log with failure context
    update public.mv_refresh_logs
    set last_refreshed_at = v_end_time,
        last_refresh_duration_ms = v_duration_ms,
        status = 'failed',
        error_message = SQLERRM,
        updated_at = now()
    where view_name = p_view_name;

    return jsonb_build_object(
      'success', false,
      'view_name', p_view_name,
      'duration_ms', v_duration_ms,
      'error', SQLERRM
    );
  end;
end;
$$;

-- 3. Seed strategies catalog
insert into public.mv_refresh_logs (view_name, refresh_policy)
values
  ('mv_member_progress', 'Event-driven'),
  ('mv_company_dashboard_stats', '5 min'),
  ('mv_growth_analytics', '30 min'),
  ('mv_leadership_pipeline', '30 min'),
  ('mv_recommendation_center', 'Hourly')
on conflict (view_name) do update
set refresh_policy = excluded.refresh_policy;
