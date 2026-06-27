-- ============================================================================
-- Phase F5B & F5C: Meeting and Task Coach RPCs
-- ============================================================================

-- 1. Meeting Coach Context
create or replace function public.get_ai_meeting_coach_context(
  p_company_id uuid,
  p_leader_id uuid
)
returns json
language plpgsql
security definer
as $$
declare
  v_team_analytics record;
  v_member_analytics json;
begin
  -- Get team level rollups from mv_team_analytics
  select * into v_team_analytics
  from public.mv_team_analytics
  where leader_id = p_leader_id and company_id = p_company_id;

  -- Get worst offenders for meetings (lowest attendance, highest missed)
  select json_agg(row_to_json(ma)) into v_member_analytics
  from (
    select
      p.first_name,
      p.last_name,
      mva.attendance_rate_30d,
      mva.meetings_assigned_30d,
      mva.meetings_attended_30d,
      mva.meetings_assigned_7d,
      mva.meetings_attended_7d
    from public.network_nodes n
    join public.mv_member_analytics mva on mva.profile_id = n.profile_id
    join public.profiles p on p.id = n.profile_id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and n.profile_id != p_leader_id
    order by mva.attendance_rate_30d asc nulls last
    limit 10
  ) ma;

  return json_build_object(
    'team_attendance_rate_30d', coalesce(v_team_analytics.attendance_rate, 0),
    'team_size', coalesce(v_team_analytics.team_size, 0),
    'members_needing_attendance_coaching', coalesce(v_member_analytics, '[]'::json)
  );
end;
$$;

-- 2. Task Coach Context
create or replace function public.get_ai_task_coach_context(
  p_company_id uuid,
  p_leader_id uuid
)
returns json
language plpgsql
security definer
as $$
declare
  v_team_analytics record;
  v_member_analytics json;
begin
  -- Get team level rollups from mv_team_analytics
  select * into v_team_analytics
  from public.mv_team_analytics
  where leader_id = p_leader_id and company_id = p_company_id;

  -- Get worst offenders for tasks
  select json_agg(row_to_json(ta)) into v_member_analytics
  from (
    select
      p.first_name,
      p.last_name,
      mva.task_completion_rate_30d,
      mva.tasks_assigned_30d,
      mva.tasks_completed_30d,
      mva.tasks_assigned_7d,
      mva.tasks_completed_7d
    from public.network_nodes n
    join public.mv_member_analytics mva on mva.profile_id = n.profile_id
    join public.profiles p on p.id = n.profile_id
    where n.path_ltree <@ (select path_ltree from public.network_nodes where profile_id = p_leader_id)
      and n.profile_id != p_leader_id
    order by mva.task_completion_rate_30d asc nulls last
    limit 10
  ) ta;

  return json_build_object(
    'team_task_completion_rate_30d', coalesce(v_team_analytics.completion_rate, 0),
    'team_size', coalesce(v_team_analytics.team_size, 0),
    'members_needing_task_coaching', coalesce(v_member_analytics, '[]'::json)
  );
end;
$$;
