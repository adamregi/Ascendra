-- ============================================================================
-- 054_f9_notification_pipeline.sql — Notification & Escalation Pipeline
-- ============================================================================

-- Function to handle escalation of unread alerts
create or replace function public.run_escalation_engine()
returns void
language plpgsql
security definer
as $$
declare
    v_escalated integer;
begin
    -- Escalate Critical alerts unread for 48 hours
    update public.alerts
    set status = 'Actioned',
        metadata = jsonb_set(metadata, '{escalated}', 'true'::jsonb)
    where severity = 'Critical'
      and status = 'Unread'
      and created_at < now() - interval '48 hours';
      
    get diagnostics v_escalated = row_count;
    
    if v_escalated > 0 then
        -- We could insert a reminder alert or trigger an email here
        insert into public.automation_logs (company_id, trigger_source, action_taken, result_status)
        values ((select id from public.companies limit 1), 'Escalation Engine', 'Escalated ' || v_escalated || ' critical alerts', 'Success');
    end if;
end;
$$;

-- Function to queue alert deliveries (simulates batching for edge functions)
create or replace function public.queue_alert_deliveries()
returns void
language plpgsql
security definer
as $$
begin
    -- In a real environment, we might use pg_net to invoke an Edge Function.
    -- Here we simulate inserting pending deliveries for unread alerts that haven't been delivered yet.
    insert into public.alert_deliveries (alert_id, channel, status)
    select a.id, pref.channel, 'Pending'
    from public.alerts a
    join public.alert_preferences pref on pref.profile_id = (
        -- Find the leader to notify. Usually the company owner.
        select owner_id from public.companies where id = a.company_id
    )
    where a.status = 'Unread'
      and pref.enabled = true
      and (pref.alert_type = 'All' or pref.alert_type = a.type)
      and not exists (
          select 1 from public.alert_deliveries ad 
          where ad.alert_id = a.id and ad.channel = pref.channel
      );
end;
$$;

-- Note: The actual dispatch would happen via Edge Functions listening to alert_deliveries changes or polling via cron.

-- Schedule the F9 Pipeline via pg_cron
do $$
begin
  if exists (select 1 from pg_extension where extname = 'pg_cron') then
    -- Analytics Refresh is already at 01:00-01:27 from previous migrations
    
    -- 01:30: Decision Engine (Rules Evaluation)
    perform cron.schedule('daily_decision_engine', '30 1 * * *', 'SELECT public.run_decision_engine()');
    
    -- 01:33: Notification Pipeline & Queueing
    perform cron.schedule('daily_notification_queue', '33 1 * * *', 'SELECT public.queue_alert_deliveries()');
    
    -- 01:40: Escalation Engine
    perform cron.schedule('daily_escalation_engine', '40 1 * * *', 'SELECT public.run_escalation_engine()');
  end if;
end
$$;
