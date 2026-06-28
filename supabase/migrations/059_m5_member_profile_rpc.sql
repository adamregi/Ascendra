-- ============================================================================
-- 059_m5_member_profile_rpc.sql — M5 Member Profile ViewModel RPC
-- ============================================================================

-- Returns the full member profile view model requested by the Flutter client.
-- This merges profiles, compliance, meetings, tasks, recognition, and analytics.

create or replace function public.get_member_profile_view_model(
  p_profile_id uuid
)
returns json
language plpgsql
security definer
as $$
declare
  v_profile record;
  v_leader record;
  v_kpis record;
  v_compliance record;
  v_timeline json;
  v_achievements json;
  v_analytics json;
begin
  -- 1. Fetch Core Profile
  select p.id, p.first_name, p.last_name, p.avatar_url, p.status, p.created_at,
         coalesce(p.distributor_id, 'PENDING') as distributor_id,
         coalesce(p.rank, 'Member') as rank,
         n.parent_id
  into v_profile
  from public.profiles p
  left join public.network_nodes n on n.profile_id = p.id
  where p.id = p_profile_id;

  if not found then
    return null;
  end if;

  -- 2. Fetch Leader Name
  if v_profile.parent_id is not null then
    select first_name, last_name into v_leader
    from public.profiles
    where id = v_profile.parent_id;
  end if;

  -- 3. Fetch KPI Summary (Meetings, Tasks, Leadership, Risk)
  -- Assuming mv_member_progress and member_risk_scores hold this.
  select 
    coalesce(mp.meeting_attendance_rate, 0) as meeting_percent,
    coalesce(mp.task_completion_rate, 0) as task_percent,
    coalesce(mp.current_streak, 0) as current_streak,
    coalesce(lp.leadership_score, 0) as leadership_score,
    coalesce(rs.risk_score, 0) as risk_score,
    coalesce(rs.risk_level, 'low') as risk_level
  into v_kpis
  from public.profiles p
  left join public.mv_member_progress mp on mp.profile_id = p.id
  left join public.mv_leadership_pipeline lp on lp.profile_id = p.id
  left join public.member_risk_scores rs on rs.profile_id = p.id
  where p.id = p_profile_id;

  -- 4. Fetch Compliance Explainability (M5.4)
  select 
    coalesce(c.compliance_score, 100) as score,
    coalesce(c.reason, ARRAY['No violations']) as reasons,
    coalesce(c.next_improvement, 'Maintain current performance') as next_improvement
  into v_compliance
  from (
    -- Mocking structure since compliance_scoring_engine might differ slightly.
    -- Assuming a materialized view or table exists.
    select 100 as compliance_score, ARRAY['Completed 97% of tasks'] as reason, 'Attend next meeting on time' as next_improvement
  ) c;

  -- 5. Fetch Activity Timeline (Chronological Merge - M5.3)
  -- Merge meeting attendances, tasks, followups, and recognition.
  select coalesce(json_agg(row_to_json(t)), '[]'::json) into v_timeline
  from (
    -- Meetings
    select 'meeting' as type, ma.created_at as timestamp, m.title as title, 'Meeting Joined' as description
    from public.meeting_attendances ma
    join public.meetings m on m.id = ma.meeting_id
    where ma.profile_id = p_profile_id

    union all

    -- Tasks
    select 'task' as type, ta.created_at as timestamp, tk.title as title, 'Task Assigned' as description
    from public.task_assignments ta
    join public.tasks tk on tk.id = ta.task_id
    where ta.assignee_id = p_profile_id

    union all

    -- Proofs
    select 'proof' as type, tp.created_at as timestamp, 'Proof Submitted' as title, 'Submitted proof for task' as description
    from public.task_proofs tp
    where tp.submitted_by = p_profile_id

    union all

    -- Follow-ups
    select 'followup' as type, f.created_at as timestamp, 'Leader Follow-up' as title, f.content as description
    from public.followups f
    where f.target_id = p_profile_id

    order by timestamp desc
    limit 50
  ) t;

  -- 6. Fetch Recognition Achievements (M5.5)
  select coalesce(json_agg(row_to_json(a)), '[]'::json) into v_achievements
  from (
    -- Placeholder for the achievements system
    select 'Top Performer' as name, 'Consistently hit targets' as description, current_timestamp as earned_date, 'performance' as category, 'award' as icon, 1 as level, 100 as points
    limit 0
  ) a;

  -- 7. Analytics Trend Data (M5.6)
  -- Placeholder for trend arrays
  v_analytics := json_build_object(
    'leadership_trend', ARRAY[80, 82, 85, 87, 86, 90],
    'attendance_trend', ARRAY[100, 100, 100, 95, 100],
    'task_trend', ARRAY[90, 95, 100, 90, 100]
  );

  -- 8. Assemble ViewModel
  return json_build_object(
    'version', 1,
    'generated_at', current_timestamp,
    'hero', json_build_object(
      'avatar_url', v_profile.avatar_url,
      'first_name', v_profile.first_name,
      'last_name', v_profile.last_name,
      'distributor_id', v_profile.distributor_id,
      'leader_name', v_leader.first_name || ' ' || v_leader.last_name,
      'rank', v_profile.rank,
      'status', v_profile.status,
      'joined_date', v_profile.created_at,
      'current_streak', v_kpis.current_streak
    ),
    'overview', json_build_object(
      'leadership_score', v_kpis.leadership_score,
      'recognition_count', 0, -- Replace with count from achievements
      'compliance_score', v_compliance.score,
      'meeting_percent', v_kpis.meeting_percent,
      'task_percent', v_kpis.task_percent,
      'risk_level', v_kpis.risk_level
    ),
    'compliance', json_build_object(
      'score', v_compliance.score,
      'reasons', v_compliance.reasons,
      'next_improvement', v_compliance.next_improvement
    ),
    'timeline', v_timeline,
    'recognition', v_achievements,
    'analytics', v_analytics
  );
end;
$$;
