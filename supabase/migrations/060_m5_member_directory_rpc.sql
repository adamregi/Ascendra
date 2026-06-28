-- ============================================================================
-- 060_m5_member_directory_rpc.sql — M5 Member Directory RPC
-- ============================================================================

-- Returns a JSON array of members with their directory KPIs.
-- Supports advanced filtering as requested in M5.1.

create or replace function public.get_member_directory(
  p_company_id uuid,
  p_leader_id uuid,
  p_search_query text default null,
  p_status text default null,
  p_leader text default null,
  p_promotion_ready boolean default null,
  p_high_risk boolean default null
)
returns json
language plpgsql
security definer
as $$
declare
  v_result json;
begin
  select coalesce(json_agg(row_to_json(d)), '[]'::json) into v_result
  from (
    select 
      p.id as profile_id,
      p.first_name,
      p.last_name,
      p.avatar_url,
      p.distributor_id,
      p.status,
      coalesce(p.rank, 'Member') as rank,
      lp.parent_id,
      (select first_name || ' ' || last_name from public.profiles where id = lp.parent_id) as leader_name,
      coalesce(mp.meeting_attendance_rate, 0) as meeting_percent,
      coalesce(mp.task_completion_rate, 0) as task_percent,
      coalesce(rs.risk_level, 'low') as risk_level,
      (case when ls.leadership_band in ('Future Leader', 'Emerging Leader') then true else false end) as is_promotion_ready,
      0 as recognition_count
    from public.network_nodes n
    join public.profiles p on p.id = n.profile_id
    left join public.network_nodes lp on lp.profile_id = p.id
    left join public.mv_member_progress mp on mp.profile_id = p.id
    left join public.member_risk_scores rs on rs.profile_id = p.id
    left join public.mv_leadership_pipeline ls on ls.profile_id = p.id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and n.profile_id != p_leader_id
      -- Apply search query
      and (p_search_query is null or (p.first_name ilike '%' || p_search_query || '%' or p.last_name ilike '%' || p_search_query || '%' or p.distributor_id ilike '%' || p_search_query || '%'))
      -- Apply filters
      and (p_status is null or p.status = p_status)
      and (p_promotion_ready is null or p_promotion_ready = false or ls.leadership_band in ('Future Leader', 'Emerging Leader'))
      and (p_high_risk is null or p_high_risk = false or rs.risk_level in ('high', 'critical'))
    order by p.first_name, p.last_name
  ) d;

  return v_result;
end;
$$;
