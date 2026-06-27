-- ============================================================================
-- Phase F5A: Analytics Layer
-- ============================================================================

-- 1. Create coach_insights table
create table if not exists public.coach_insights (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  profile_id uuid not null references public.profiles(id) on delete cascade,
  skill text not null,
  insight_type text not null,
  severity text not null check (severity in ('high', 'medium', 'low', 'info')),
  title text not null,
  description text not null,
  source_reference jsonb,
  created_at timestamptz not null default now()
);

alter table public.coach_insights enable row level security;

-- 2. Add source_insight_id to ai_recommendations
alter table public.ai_recommendations
add column if not exists source_insight_id uuid references public.coach_insights(id) on delete set null;

-- 3. Materialized View: mv_member_analytics
create materialized view if not exists public.mv_member_analytics as
select
  p.id as profile_id,
  p.company_id,
  
  -- Meetings
  count(ma.id) filter (where m.created_at >= now() - interval '7 days') as meetings_assigned_7d,
  count(ma.id) filter (where ma.attendance_status = 'attended' and m.created_at >= now() - interval '7 days') as meetings_attended_7d,
  
  count(ma.id) filter (where m.created_at >= now() - interval '30 days') as meetings_assigned_30d,
  count(ma.id) filter (where ma.attendance_status = 'attended' and m.created_at >= now() - interval '30 days') as meetings_attended_30d,
  
  count(ma.id) filter (where m.created_at >= now() - interval '90 days') as meetings_assigned_90d,
  count(ma.id) filter (where ma.attendance_status = 'attended' and m.created_at >= now() - interval '90 days') as meetings_attended_90d,
  
  case 
    when count(ma.id) filter (where m.created_at >= now() - interval '30 days') = 0 then 0
    else (count(ma.id) filter (where ma.attendance_status = 'attended' and m.created_at >= now() - interval '30 days')::numeric / count(ma.id) filter (where m.created_at >= now() - interval '30 days')) * 100 
  end as attendance_rate_30d,

  -- Tasks
  count(ta.id) filter (where ta.assigned_at >= now() - interval '7 days') as tasks_assigned_7d,
  count(ta.id) filter (where ta.status = 'approved' and ta.assigned_at >= now() - interval '7 days') as tasks_completed_7d,

  count(ta.id) filter (where ta.assigned_at >= now() - interval '30 days') as tasks_assigned_30d,
  count(ta.id) filter (where ta.status = 'approved' and ta.assigned_at >= now() - interval '30 days') as tasks_completed_30d,

  count(ta.id) filter (where ta.assigned_at >= now() - interval '90 days') as tasks_assigned_90d,
  count(ta.id) filter (where ta.status = 'approved' and ta.assigned_at >= now() - interval '90 days') as tasks_completed_90d,
  
  case 
    when count(ta.id) filter (where ta.assigned_at >= now() - interval '30 days') = 0 then 0
    else (count(ta.id) filter (where ta.status = 'approved' and ta.assigned_at >= now() - interval '30 days')::numeric / count(ta.id) filter (where ta.assigned_at >= now() - interval '30 days')) * 100 
  end as task_completion_rate_30d,

  -- Followups
  count(f.id) filter (where f.status = 'completed' and f.created_at >= now() - interval '30 days') as followups_completed_30d,

  -- Health & Risk (from member_performance_snapshots)
  coalesce((select member_health_score from public.member_performance_snapshots mps where mps.profile_id = p.id order by created_at desc limit 1), 0) as health_score_30d,
  coalesce((select risk_level from public.member_performance_snapshots mps where mps.profile_id = p.id order by created_at desc limit 1), 'low') as risk_level,
  coalesce((select activity_trend from public.member_performance_snapshots mps where mps.profile_id = p.id order by created_at desc limit 1), 50) as activity_trend,

  -- Future proofing
  null::numeric as predicted_risk_score,
  null::numeric as predicted_growth_score,
  
  0 as current_streak_days, -- Placeholder for streak logic
  
  coalesce(
    greatest(
      max(ma.updated_at),
      max(ta.updated_at),
      max(f.updated_at)
    ),
    p.created_at
  ) as last_activity_at,
  
  now() as generated_at

from public.profiles p
left join public.meeting_attendances ma on ma.profile_id = p.id
left join public.meetings m on m.id = ma.meeting_id
left join public.task_assignments ta on ta.member_id = p.id
left join public.followups f on f.member_id = p.id
group by p.id, p.company_id, p.created_at;

create unique index on public.mv_member_analytics (profile_id);

-- 4. Materialized View: mv_team_analytics (Leader Scoped)
create materialized view if not exists public.mv_team_analytics as
with leader_nodes as (
  select profile_id, company_id, path_ltree 
  from public.network_nodes
)
select
  l.profile_id as leader_id,
  l.company_id,
  
  count(d.profile_id) as team_size,
  count(d.profile_id) filter (where p.status = 'active') as active_members,
  count(d.profile_id) filter (where p.status = 'warned') as warned_members,
  count(d.profile_id) filter (where p.status = 'suspended') as suspended_members,
  count(d.profile_id) filter (where p.status = 'terminated') as terminated_members,
  
  avg(ma.health_score_30d) as avg_health_score,
  count(d.profile_id) filter (where ma.risk_level = 'high') as high_risk_members,
  
  avg(ma.attendance_rate_30d) as attendance_rate,
  avg(ma.task_completion_rate_30d) as completion_rate,
  
  now() as generated_at
from leader_nodes l
join public.network_nodes d on d.path_ltree <@ l.path_ltree and d.profile_id != l.profile_id
join public.profiles p on p.id = d.profile_id
left join public.mv_member_analytics ma on ma.profile_id = d.profile_id
group by l.profile_id, l.company_id;

create unique index on public.mv_team_analytics (leader_id);

-- 5. Materialized View: mv_meeting_analytics
create materialized view if not exists public.mv_meeting_analytics as
select
  m.id as meeting_id,
  m.company_id,
  count(ma.id) as total_invitees,
  count(ma.id) filter (where ma.attendance_status = 'attended') as total_attended,
  
  case 
    when count(ma.id) = 0 then 0
    else (count(ma.id) filter (where ma.attendance_status = 'attended')::numeric / count(ma.id)) * 100 
  end as attendance_rate,

  avg(extract(epoch from (ma.first_joined_at - m.started_at))/60) filter (where ma.first_joined_at > m.started_at) as avg_join_delay_minutes,
  avg(extract(epoch from (m.ended_at - ma.last_left_at))/60) filter (where ma.last_left_at < m.ended_at) as avg_leave_early_minutes,
  
  avg(ma.attendance_percentage) as completion_percentage,
  
  count(ma.id) filter (where ma.first_joined_at > (m.started_at + interval '5 minutes')) as late_join_count,
  count(ma.id) filter (where ma.last_left_at < (m.ended_at - interval '5 minutes')) as early_leave_count,
  
  (avg(ma.attendance_percentage) * 0.7 + 
   (count(ma.id) filter (where ma.attendance_status = 'attended')::numeric / greatest(count(ma.id), 1)) * 30) as engagement_score,

  now() as generated_at
from public.meetings m
left join public.meeting_attendances ma on ma.meeting_id = m.id
group by m.id, m.company_id;

create unique index on public.mv_meeting_analytics (meeting_id);

-- 6. Materialized View: mv_task_analytics
create materialized view if not exists public.mv_task_analytics as
select
  t.id as task_id,
  t.company_id,
  count(ta.id) as assigned_count,
  count(ta.id) filter (where ta.status = 'approved') as completed_count,
  
  case 
    when count(ta.id) = 0 then 0
    else (count(ta.id) filter (where ta.status = 'approved')::numeric / count(ta.id)) * 100
  end as approval_rate,

  case 
    when count(ta.id) = 0 then 0
    else (count(ta.id) filter (where ta.status = 'overdue')::numeric / count(ta.id)) * 100
  end as overdue_rate,

  avg(extract(epoch from (ta.submitted_at - ta.assigned_at))/3600) filter (where ta.submitted_at is not null) as avg_completion_hours,
  avg(extract(epoch from (ta.reviewed_at - ta.submitted_at))/3600) filter (where ta.reviewed_at is not null and ta.submitted_at is not null) as avg_review_hours,

  now() as generated_at
from public.tasks t
left join public.task_assignments ta on ta.task_id = t.id
group by t.id, t.company_id;

create unique index on public.mv_task_analytics (task_id);

-- 7. Refresh Functions
create or replace function public.refresh_member_analytics() returns void language plpgsql security definer as $$
begin
  refresh materialized view concurrently public.mv_member_analytics;
end;
$$;

create or replace function public.refresh_team_analytics() returns void language plpgsql security definer as $$
begin
  refresh materialized view concurrently public.mv_team_analytics;
end;
$$;

create or replace function public.refresh_meeting_analytics() returns void language plpgsql security definer as $$
begin
  refresh materialized view concurrently public.mv_meeting_analytics;
end;
$$;

create or replace function public.refresh_task_analytics() returns void language plpgsql security definer as $$
begin
  refresh materialized view concurrently public.mv_task_analytics;
end;
$$;

create or replace function public.refresh_all_analytics() returns void language plpgsql security definer as $$
begin
  perform public.refresh_member_analytics();
  perform public.refresh_team_analytics();
  perform public.refresh_meeting_analytics();
  perform public.refresh_task_analytics();
end;
$$;
