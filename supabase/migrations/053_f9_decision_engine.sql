-- ============================================================================
-- 053_f9_decision_engine.sql — Intelligence Decision Engine
-- ============================================================================

-- Function to evaluate dynamic rules and insert deterministic alerts
create or replace function public.run_decision_engine()
returns void
language plpgsql
security definer
as $$
declare
    v_rule record;
    v_inserted_count integer := 0;
    v_hash text;
    v_period text := to_char(current_date, 'IYYY-IW'); -- Weekly period hash by default (e.g. 2026-27)
begin
    -- Mark expired alerts
    update public.alerts 
    set status = 'Expired'
    where status = 'Unread' and valid_until < now();

    -- Loop over all enabled rules
    for v_rule in 
        select * from public.alert_rules 
        where enabled = true 
          and (company_id is null or company_id in (select id from public.companies))
    loop
        -- High Risk Rule Evaluation
        if v_rule.metric = 'risk_score' then
            insert into public.alerts (company_id, profile_id, rule_id, alert_hash, type, severity, title, description, valid_until)
            select 
                r.company_id, 
                r.profile_id, 
                v_rule.id, 
                md5(r.company_id::text || r.profile_id::text || v_rule.id::text || v_period), -- deterministic hash
                v_rule.rule_type,
                v_rule.severity,
                'Risk Alert: ' || p.full_name,
                'Risk score is ' || r.risk_score,
                now() + (v_rule.valid_for_days || ' days')::interval
            from public.member_risk_scores r
            join public.profiles p on p.id = r.profile_id
            where r.risk_score is not null
              and (
                  (v_rule.operator = '>' and r.risk_score > v_rule.threshold) or
                  (v_rule.operator = '>=' and r.risk_score >= v_rule.threshold)
              )
            on conflict (alert_hash) do nothing;
            
            get diagnostics v_inserted_count = row_count;

        -- Promotion Rule Evaluation
        elsif v_rule.metric = 'leadership_score' then
            insert into public.alerts (company_id, profile_id, rule_id, alert_hash, type, severity, title, description, valid_until)
            select 
                l.company_id, 
                l.profile_id, 
                v_rule.id, 
                md5(l.company_id::text || l.profile_id::text || v_rule.id::text || v_period),
                v_rule.rule_type,
                v_rule.severity,
                'Promotion Candidate: ' || p.full_name,
                'Leadership score reached ' || l.leadership_score,
                now() + (v_rule.valid_for_days || ' days')::interval
            from public.mv_leadership_pipeline l
            join public.profiles p on p.id = l.profile_id
            where l.leadership_score is not null
              and (
                  (v_rule.operator = '>' and l.leadership_score > v_rule.threshold) or
                  (v_rule.operator = '>=' and l.leadership_score >= v_rule.threshold)
              )
            on conflict (alert_hash) do nothing;
            
            get diagnostics v_inserted_count = row_count;

        -- Growth Highlight Rule Evaluation
        elsif v_rule.metric = 'attendance_growth' then
            insert into public.alerts (company_id, profile_id, rule_id, alert_hash, type, severity, title, description, valid_until)
            select 
                a.company_id, 
                a.profile_id, 
                v_rule.id, 
                md5(a.company_id::text || a.profile_id::text || v_rule.id::text || v_period),
                v_rule.rule_type,
                v_rule.severity,
                'Growth Highlight: ' || p.full_name,
                'Attendance improved by ' || a.attendance_delta_30d || '%',
                now() + (v_rule.valid_for_days || ' days')::interval
            from public.mv_growth_analytics a
            join public.profiles p on p.id = a.profile_id
            where a.attendance_delta_30d is not null
              and (
                  (v_rule.operator = '>' and a.attendance_delta_30d > v_rule.threshold) or
                  (v_rule.operator = '>=' and a.attendance_delta_30d >= v_rule.threshold)
              )
            on conflict (alert_hash) do nothing;
            
            get diagnostics v_inserted_count = row_count;
            
        -- Retention Warning Evaluation
        elsif v_rule.metric = 'health_drop' then
            -- Assumes attendance_delta_30d or some health_drop field, using attendance drop here as proxy
            insert into public.alerts (company_id, profile_id, rule_id, alert_hash, type, severity, title, description, valid_until)
            select 
                a.company_id, 
                a.profile_id, 
                v_rule.id, 
                md5(a.company_id::text || a.profile_id::text || v_rule.id::text || v_period),
                v_rule.rule_type,
                v_rule.severity,
                'Retention Warning: ' || p.full_name,
                'Health score dropped significantly.',
                now() + (v_rule.valid_for_days || ' days')::interval
            from public.mv_growth_analytics a
            join public.profiles p on p.id = a.profile_id
            where a.attendance_delta_30d is not null
              and a.attendance_delta_30d < 0 -- negative means drop
              and (
                  (v_rule.operator = '>' and abs(a.attendance_delta_30d) > v_rule.threshold) or
                  (v_rule.operator = '>=' and abs(a.attendance_delta_30d) >= v_rule.threshold)
              )
            on conflict (alert_hash) do nothing;
            
            get diagnostics v_inserted_count = row_count;
        end if;
        
        -- Log the evaluation pass if it generated alerts
        if v_inserted_count > 0 then
            insert into public.automation_logs (company_id, rule_id, trigger_source, action_taken, result_status)
            -- We just pick the first company_id for the log if it's a global rule
            values ((select id from public.companies limit 1), v_rule.id, 'Decision Engine', 'Generated ' || v_inserted_count || ' alerts', 'Success');
        end if;
        
    end loop;
end;
$$;
