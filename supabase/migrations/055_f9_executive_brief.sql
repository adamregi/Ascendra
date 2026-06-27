-- ============================================================================
-- 055_f9_executive_brief.sql — Executive Brief & AI Skill Updates
-- ============================================================================

-- Function to generate deterministic executive brief data
create or replace function public.get_executive_brief_data(p_company_id uuid)
returns json
language plpgsql
security definer
as $$
declare
    v_top_alerts json;
    v_stats json;
begin
    -- 1. Top 5 Alerts
    select json_agg(row_to_json(t)) into v_top_alerts
    from (
        select id, type, severity, title, created_at
        from public.alerts
        where company_id = p_company_id
          and status = 'Unread'
        order by 
            case severity
                when 'Critical' then 1
                when 'High' then 2
                when 'Medium' then 3
                when 'Low' then 4
                else 5
            end asc,
            created_at desc
        limit 5
    ) t;

    -- 2. Brief Stats
    select row_to_json(s) into v_stats
    from (
        select
            count(*) filter (where type = 'High Risk' and status = 'Unread') as high_risk_count,
            count(*) filter (where type = 'Promotion' and status = 'Unread') as promotion_count,
            count(*) filter (where type = 'Recognition' and status = 'Unread') as recognition_count
        from public.alerts
        where company_id = p_company_id
    ) s;

    return json_build_object(
        'top_alerts', coalesce(v_top_alerts, '[]'::json),
        'stats', coalesce(v_stats, '{}'::json)
    );
end;
$$;

-- Schedule Executive Brief generation
do $$
begin
  if exists (select 1 from pg_extension where extname = 'pg_cron') then
    -- 01:36: Executive Brief Generation (we might just call this RPC from an edge function)
    -- Here we log it as a scheduled system event
    perform cron.schedule('daily_executive_brief', '36 1 * * *', 'SELECT public.get_executive_brief_data((select id from public.companies limit 1))');
  end if;
end
$$;

-- AI Skill Patterns Update
-- First, update the check constraint to allow the new skills
alter table public.ai_skill_patterns drop constraint if exists ai_skill_patterns_skill_check;
alter table public.ai_skill_patterns add constraint ai_skill_patterns_skill_check check (
  skill in (
    'team_performance', 'compliance_coach', 'meeting_coach', 'task_coach', 
    'member_success', 'knowledge_assistant', 'leadership_advisor', 
    'retention_risk', 'growth_opportunity', 'system_assistant',
    'executive_briefing', 'decision_advisor', 'action_planner'
  )
);

-- Remove old placeholder skills if any exist, and insert new ones
delete from public.ai_skill_patterns 
where skill in ('executive_briefing', 'decision_advisor', 'action_planner', 'alert_analyst', 'automation_assistant');

insert into public.ai_skill_patterns (company_id, skill, pattern_type, pattern, weight) values
  -- executive_briefing
  (null, 'executive_briefing', 'regex', 'what.*changed.*overnight', 10),
  (null, 'executive_briefing', 'regex', 'needs.*attention.*today', 10),
  (null, 'executive_briefing', 'regex', 'executive.*brief', 8),
  (null, 'executive_briefing', 'regex', 'daily.*summary', 8),
  
  -- decision_advisor
  (null, 'decision_advisor', 'regex', 'what.*decisions.*make', 10),
  (null, 'decision_advisor', 'regex', 'what.*should.*i.*do.*first', 10),
  (null, 'decision_advisor', 'regex', 'prioritize.*alerts', 8),
  (null, 'decision_advisor', 'regex', 'what.*can.*wait', 8),
  
  -- action_planner
  (null, 'action_planner', 'regex', 'resolve.*multiple.*alerts', 10),
  (null, 'action_planner', 'regex', 'action.*plan', 10),
  (null, 'action_planner', 'regex', 'biggest.*impact', 8),
  (null, 'action_planner', 'regex', 'who.*deserves.*recognition', 8);
