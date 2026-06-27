-- ============================================================================
-- 022_rls_policies.sql — Materialized Views, Grants, and RLS policies
-- ============================================================================
-- Creates analytics views, defines security access controls, and enforces
-- strict multi-tenant isolation.
--
-- Dependencies: All prior tables and functions

-- ============================================================================
-- Materialized Views
-- ============================================================================

-- Company Dashboard Stats
create materialized view if not exists public.mv_company_dashboard_stats as
select
  c.id as company_id,
  c.name as company_name,
  count(distinct p.id) filter (where p.status = 'active') as active_members,
  count(distinct p.id) filter (where p.status = 'warned') as warned_members,
  count(distinct p.id) filter (where p.status = 'terminated') as terminated_members,
  count(distinct p.id) as total_members,
  count(distinct m.id) as total_meetings,
  count(distinct m.id) filter (
    where m.scheduled_at >= date_trunc('month', now())
  ) as meetings_this_month,
  count(distinct ma.id) as total_attendance_records,
  coalesce(avg(ma.total_duration_minutes), 0)::integer as avg_attendance_duration_minutes
from public.companies c
left join public.profiles p on p.company_id = c.id
left join public.meetings m on m.company_id = c.id
left join public.meeting_attendances ma on ma.meeting_id = m.id
group by c.id, c.name;

create unique index if not exists mv_company_dashboard_stats_company_idx
  on public.mv_company_dashboard_stats (company_id);

-- Monthly Compliance Summary (Temporarily commented out for Phase D1)
-- create materialized view if not exists public.mv_monthly_compliance_summary as
-- select
--   cs.company_id,
--   cs.period_start,
--   cs.period_end,
--   count(*) as total_evaluated,
--   count(*) filter (where cs.status = 'compliant') as compliant_count,
--   count(*) filter (where cs.status = 'warned') as warned_count,
--   count(*) filter (where cs.status = 'at_risk') as at_risk_count,
--   count(*) filter (where cs.status = 'terminated') as terminated_count,
--   case
--     when count(*) > 0
--     then round(
--       (count(*) filter (where cs.status = 'compliant'))::numeric / count(*)::numeric * 100,
--       2
--     )
--     else 0
--   end as compliance_rate_pct
-- from public.compliance_snapshots cs
-- group by cs.company_id, cs.period_start, cs.period_end;
-- 
-- create unique index if not exists mv_monthly_compliance_company_period_idx
--   on public.mv_monthly_compliance_summary (company_id, period_start, period_end);

-- Member Progress Materialized View
create materialized view if not exists public.mv_member_progress as
select
  p.company_id,
  p.id as profile_id,
  p.full_name,
  p.role,
  p.status,
  -- Attendance metrics
  count(distinct ma.meeting_id) as meetings_attended,
  coalesce(sum(ma.total_duration_minutes), 0)::integer as total_attendance_duration_minutes,
  -- Task metrics
  count(distinct ta.id) as total_tasks_assigned,
  count(distinct ta.id) filter (where ta.status = 'approved') as tasks_completed,
  case
    when count(distinct ta.id) > 0
    then round(
      (count(distinct ta.id) filter (where ta.status = 'approved'))::numeric / count(distinct ta.id)::numeric * 100,
      2
    )
    else 100.00
  end as task_completion_rate_pct,
  -- Quiz metrics
  count(distinct qr.id) as quizzes_taken,
  count(distinct qr.id) filter (where qr.passed = true) as quizzes_passed,
  case
    when count(distinct qr.id) > 0
    then round(
      (count(distinct qr.id) filter (where qr.passed = true))::numeric / count(distinct qr.id)::numeric * 100,
      2
    )
    else 100.00
  end as quiz_pass_rate_pct
from public.profiles p
left join public.meeting_attendances ma on ma.profile_id = p.id
left join public.task_assignments ta on ta.member_id = p.id
left join public.quiz_responses qr on qr.profile_id = p.id
group by p.company_id, p.id, p.full_name, p.role, p.status;

create unique index if not exists mv_member_progress_profile_idx
  on public.mv_member_progress (profile_id);

-- ============================================================================
-- Refresh Function
-- ============================================================================
create or replace function public.refresh_analytics_views()
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  refresh materialized view concurrently public.mv_company_dashboard_stats;
  -- refresh materialized view concurrently public.mv_monthly_compliance_summary;
  refresh materialized view concurrently public.mv_member_progress;
end;
$$;

-- ============================================================================
-- Grants
-- ============================================================================
grant select on public.companies to authenticated;
grant select on public.company_settings to authenticated;
grant select on public.profiles to authenticated;
grant select on public.network_nodes to authenticated;
grant select on public.subscription_plans to authenticated;
grant select on public.subscriptions to authenticated;
grant select on public.invitations to authenticated;
grant select, insert, update, delete on public.meetings to authenticated;
grant select, insert, update, delete on public.meeting_attendances to authenticated;
grant select, insert, update, delete on public.meeting_sessions to authenticated;
grant select on public.meeting_questions to authenticated;
grant select on public.meeting_answers to authenticated;
grant select on public.meeting_recordings to authenticated;
grant select on public.meeting_quizzes to authenticated;
grant select on public.quiz_questions to authenticated;
grant select on public.quiz_responses to authenticated;
grant select on public.tasks to authenticated;
grant select on public.task_assignments to authenticated;
grant select on public.task_proofs to authenticated;
grant select on public.followups to authenticated;
grant select on public.notifications to authenticated;
grant select on public.documents to authenticated;
grant select on public.document_chunks to authenticated;
grant select on public.products to authenticated;
grant select on public.product_faqs to authenticated;
grant select on public.success_stories to authenticated;
grant select on public.ai_conversations to authenticated;
grant select on public.ai_messages to authenticated;
grant select on public.ai_usage_logs to authenticated;
grant select on public.compliance_rules to authenticated;
grant select on public.compliance_events to authenticated;
-- grant select on public.compliance_snapshots to authenticated;
grant select on public.compliance_violations to authenticated;
-- grant select on public.termination_logs to authenticated;
grant select on public.restructure_logs to authenticated;
grant select on public.audit_logs to authenticated;

grant select on public.mv_company_dashboard_stats to authenticated;
-- grant select on public.mv_monthly_compliance_summary to authenticated;
grant select on public.mv_member_progress to authenticated;

-- ============================================================================
-- Row Level Security (RLS) Policies
-- ============================================================================

-- ── COMPANIES ──
drop policy if exists "Users can view own company" on public.companies;
create policy "Users can view own company"
  on public.companies for select
  using (id = public.get_user_company_id());

-- ── COMPANY SETTINGS ──
drop policy if exists "Users can view company settings" on public.company_settings;
create policy "Users can view company settings"
  on public.company_settings for select
  using (company_id = public.get_user_company_id());

-- ── PROFILES ──
drop policy if exists "Users can view company profiles" on public.profiles;
create policy "Users can view company profiles"
  on public.profiles for select
  using (
    public.can_view_profile(auth.uid(), id)
  );

drop policy if exists "Users can update own profile" on public.profiles;
create policy "Users can update own profile"
  on public.profiles for update
  using (auth_user_id = auth.uid())
  with check (auth_user_id = auth.uid());

-- ── NETWORK NODES ──
drop policy if exists "Users can view company network" on public.network_nodes;
create policy "Users can view company network"
  on public.network_nodes for select
  using (company_id = public.get_user_company_id());

-- ── SUBSCRIPTION PLANS ──
drop policy if exists "Users can view active subscription plans" on public.subscription_plans;
create policy "Users can view active subscription plans"
  on public.subscription_plans for select
  using (is_active = true);

-- ── SUBSCRIPTIONS ──
grant update on public.subscriptions to authenticated;

drop policy if exists "Leaders can view own subscription" on public.subscriptions;
create policy "Leaders can view own subscription"
  on public.subscriptions for select
  using (
    leader_id in (select id from public.profiles where auth_user_id = auth.uid())
  );

drop policy if exists "Leaders can update own subscription" on public.subscriptions;
create policy "Leaders can update own subscription"
  on public.subscriptions for update
  using (
    leader_id in (select id from public.profiles where auth_user_id = auth.uid())
  )
  with check (
    leader_id in (select id from public.profiles where auth_user_id = auth.uid())
  );

-- ── INVITATIONS ──
drop policy if exists "Users can view company invitations" on public.invitations;
create policy "Users can view company invitations"
  on public.invitations for select
  using (company_id = public.get_user_company_id());

-- ── MEETINGS ──
drop policy if exists "Users can view company meetings" on public.meetings;
create policy "Users can view company meetings"
  on public.meetings for select
  using (company_id = public.get_user_company_id());

drop policy if exists "Leaders can insert company meetings" on public.meetings;
create policy "Leaders can insert company meetings"
  on public.meetings for insert
  with check (
    company_id = public.get_user_company_id()
    and exists (
      select 1 from public.profiles
      where auth_user_id = auth.uid()
        and role = 'leader'
    )
  );

drop policy if exists "Leaders can update company meetings" on public.meetings;
create policy "Leaders can update company meetings"
  on public.meetings for update
  using (
    company_id = public.get_user_company_id()
    and exists (
      select 1 from public.profiles
      where auth_user_id = auth.uid()
        and role = 'leader'
    )
  )
  with check (
    company_id = public.get_user_company_id()
    and exists (
      select 1 from public.profiles
      where auth_user_id = auth.uid()
        and role = 'leader'
    )
  );

-- ── MEETING ATTENDANCES ──
drop policy if exists "Users can view company meeting attendances" on public.meeting_attendances;
create policy "Users can view company meeting attendances"
  on public.meeting_attendances for select
  using (
    exists (
      select 1 from public.meetings m
      where m.id = meeting_attendances.meeting_id
        and m.company_id = public.get_user_company_id()
    )
  );

drop policy if exists "Leaders can insert company meeting attendances" on public.meeting_attendances;
create policy "Leaders can insert company meeting attendances"
  on public.meeting_attendances for insert
  with check (
    exists (
      select 1 from public.meetings m
      where m.id = meeting_attendances.meeting_id
        and m.company_id = public.get_user_company_id()
    )
    and exists (
      select 1 from public.profiles
      where auth_user_id = auth.uid()
        and role = 'leader'
    )
  );

drop policy if exists "Leaders can update company meeting attendances" on public.meeting_attendances;
create policy "Leaders can update company meeting attendances"
  on public.meeting_attendances for update
  using (
    exists (
      select 1 from public.meetings m
      where m.id = meeting_attendances.meeting_id
        and m.company_id = public.get_user_company_id()
    )
    and exists (
      select 1 from public.profiles
      where auth_user_id = auth.uid()
        and role = 'leader'
    )
  )
  with check (
    exists (
      select 1 from public.meetings m
      where m.id = meeting_attendances.meeting_id
        and m.company_id = public.get_user_company_id()
    )
    and exists (
      select 1 from public.profiles
      where auth_user_id = auth.uid()
        and role = 'leader'
    )
  );

-- ── MEETING SESSIONS ──
drop policy if exists "Users can view company meeting sessions" on public.meeting_sessions;
create policy "Users can view company meeting sessions"
  on public.meeting_sessions for select
  using (
    exists (
      select 1 from public.meeting_attendances ma
      join public.meetings m on m.id = ma.meeting_id
      where ma.id = meeting_sessions.attendance_id
        and m.company_id = public.get_user_company_id()
    )
  );

-- ── MEETING QUESTIONS ──
drop policy if exists "Users can view company meeting questions" on public.meeting_questions;
create policy "Users can view company meeting questions"
  on public.meeting_questions for select
  using (
    exists (
      select 1 from public.meetings m
      where m.id = meeting_questions.meeting_id
        and m.company_id = public.get_user_company_id()
    )
  );

-- ── MEETING ANSWERS ──
drop policy if exists "Users can view company meeting answers" on public.meeting_answers;
create policy "Users can view company meeting answers"
  on public.meeting_answers for select
  using (
    exists (
      select 1 from public.meeting_questions mq
      join public.meetings m on mq.meeting_id = m.id
      where mq.id = meeting_answers.question_id
        and m.company_id = public.get_user_company_id()
    )
  );

-- ── MEETING RECORDINGS ──
drop policy if exists "Users can view company meeting recordings" on public.meeting_recordings;
create policy "Users can view company meeting recordings"
  on public.meeting_recordings for select
  using (
    exists (
      select 1 from public.meetings m
      where m.id = meeting_recordings.meeting_id
        and m.company_id = public.get_user_company_id()
    )
  );

-- ── MEETING QUIZZES ──
drop policy if exists "Users can view company quizzes" on public.meeting_quizzes;
create policy "Users can view company quizzes"
  on public.meeting_quizzes for select
  using (
    exists (
      select 1 from public.meetings m
      where m.id = meeting_quizzes.meeting_id
        and m.company_id = public.get_user_company_id()
    )
  );

-- ── QUIZ QUESTIONS ──
drop policy if exists "Users can view company quiz questions" on public.quiz_questions;
create policy "Users can view company quiz questions"
  on public.quiz_questions for select
  using (
    exists (
      select 1 from public.meeting_quizzes mq
      join public.meetings m on mq.meeting_id = m.id
      where mq.id = quiz_questions.quiz_id
        and m.company_id = public.get_user_company_id()
    )
  );

-- ── QUIZ RESPONSES ──
drop policy if exists "Users can view relevant quiz responses" on public.quiz_responses;
create policy "Users can view relevant quiz responses"
  on public.quiz_responses for select
  using (
    profile_id in (select id from public.profiles where auth_user_id = auth.uid())
    or public.can_view_profile(auth.uid(), profile_id)
  );

drop policy if exists "Members can insert own quiz responses" on public.quiz_responses;
create policy "Members can insert own quiz responses"
  on public.quiz_responses for insert
  with check (
    profile_id in (select id from public.profiles where auth_user_id = auth.uid())
  );

-- ── TASKS ──
drop policy if exists "Users can view company tasks" on public.tasks;
create policy "Users can view company tasks"
  on public.tasks for select
  using (company_id = public.get_user_company_id());

-- ── TASK ASSIGNMENTS ──
drop policy if exists "Users can view company task assignments" on public.task_assignments;
create policy "Users can view company task assignments"
  on public.task_assignments for select
  using (
    exists (
      select 1 from public.tasks t
      where t.id = task_assignments.task_id
        and t.company_id = public.get_user_company_id()
    )
  );

-- ── TASK PROOFS ──
drop policy if exists "Users can view company task proofs" on public.task_proofs;
create policy "Users can view company task proofs"
  on public.task_proofs for select
  using (
    exists (
      select 1 from public.task_assignments ta
      join public.tasks t on t.id = ta.task_id
      where ta.id = task_proofs.assignment_id
        and t.company_id = public.get_user_company_id()
    )
  );

-- ── FOLLOWUPS ──
drop policy if exists "Leaders can view followups they scheduled" on public.followups;
create policy "Leaders can view followups they scheduled"
  on public.followups for select
  using (
    company_id = public.get_user_company_id()
    and (
      leader_id in (select id from public.profiles where auth_user_id = auth.uid())
      or member_id in (select id from public.profiles where auth_user_id = auth.uid())
    )
  );

-- ── NOTIFICATIONS ──
drop policy if exists "Users can view own notifications" on public.notifications;
create policy "Users can view own notifications"
  on public.notifications for select
  using (
    recipient_id in (select id from public.profiles where auth_user_id = auth.uid())
  );

drop policy if exists "Users can update own notifications" on public.notifications;
create policy "Users can update own notifications"
  on public.notifications for update
  using (
    recipient_id in (select id from public.profiles where auth_user_id = auth.uid())
  )
  with check (
    recipient_id in (select id from public.profiles where auth_user_id = auth.uid())
  );

-- ── DOCUMENTS ──
drop policy if exists "Users can view company documents" on public.documents;
create policy "Users can view company documents"
  on public.documents for select
  using (company_id = public.get_user_company_id());

-- ── DOCUMENT CHUNKS ──
drop policy if exists "Users can view company document chunks" on public.document_chunks;
create policy "Users can view company document chunks"
  on public.document_chunks for select
  using (
    exists (
      select 1 from public.documents d
      where d.id = document_chunks.document_id
        and d.company_id = public.get_user_company_id()
    )
  );

-- ── PRODUCTS ──
drop policy if exists "Users can view company products" on public.products;
create policy "Users can view company products"
  on public.products for select
  using (company_id = public.get_user_company_id());

-- ── PRODUCT FAQs ──
drop policy if exists "Users can view company product faqs" on public.product_faqs;
create policy "Users can view company product faqs"
  on public.product_faqs for select
  using (
    exists (
      select 1 from public.products p
      where p.id = product_faqs.product_id
        and p.company_id = public.get_user_company_id()
    )
  );

-- ── SUCCESS STORIES ──
drop policy if exists "Users can view company success stories" on public.success_stories;
create policy "Users can view company success stories"
  on public.success_stories for select
  using (company_id = public.get_user_company_id());

-- ── AI CONVERSATIONS ──
drop policy if exists "Users can view own ai conversations" on public.ai_conversations;
create policy "Users can view own ai conversations"
  on public.ai_conversations for select
  using (
    profile_id in (select id from public.profiles where auth_user_id = auth.uid())
  );

-- ── AI MESSAGES ──
drop policy if exists "Users can view own ai messages" on public.ai_messages;
create policy "Users can view own ai messages"
  on public.ai_messages for select
  using (
    exists (
      select 1 from public.ai_conversations c
      where c.id = ai_messages.conversation_id
        and c.profile_id in (select id from public.profiles where auth_user_id = auth.uid())
    )
  );

-- ── COMPLIANCE RULES ──
drop policy if exists "Users can view company compliance rules" on public.compliance_rules;
create policy "Users can view company compliance rules"
  on public.compliance_rules for select
  using (company_id = public.get_user_company_id());

drop policy if exists "Leaders can modify company compliance rules" on public.compliance_rules;
create policy "Leaders can modify company compliance rules"
  on public.compliance_rules for all
  using (
    company_id = public.get_user_company_id()
    and exists (
      select 1 from public.profiles p
      where p.auth_user_id = auth.uid()
        and p.role = 'leader'
    )
  )
  with check (
    company_id = public.get_user_company_id()
    and exists (
      select 1 from public.profiles p
      where p.auth_user_id = auth.uid()
        and p.role = 'leader'
    )
  );

-- ── COMPLIANCE EVENTS ──
drop policy if exists "Users can view own compliance events" on public.compliance_events;
create policy "Users can view own compliance events"
  on public.compliance_events for select
  using (
    profile_id in (select id from public.profiles where auth_user_id = auth.uid())
    or exists (
      select 1 from public.profiles p
      where p.auth_user_id = auth.uid()
        and p.role = 'leader'
        and p.company_id = compliance_events.company_id
    )
  );

-- ── COMPLIANCE SNAPSHOTS ──
-- drop policy if exists "Users can view relevant compliance snapshots" on public.compliance_snapshots;
-- create policy "Users can view relevant compliance snapshots"
--   on public.compliance_snapshots for select
--   using (
--     profile_id in (select id from public.profiles where auth_user_id = auth.uid())
--     or (
--       company_id = public.get_user_company_id()
--       and exists (
--         select 1 from public.profiles p
--         where p.auth_user_id = auth.uid()
--           and p.role = 'leader'
--       )
--     )
--   );

-- ── COMPLIANCE VIOLATIONS ──
drop policy if exists "Users can view relevant compliance violations" on public.compliance_violations;
create policy "Users can view relevant compliance violations"
  on public.compliance_violations for select
  using (
    profile_id in (select id from public.profiles where auth_user_id = auth.uid())
    or exists (
      select 1 from public.profiles p
      where p.auth_user_id = auth.uid()
        and p.role = 'leader'
        and p.company_id = compliance_violations.company_id
    )
  );

-- ── TERMINATION LOGS ──
-- drop policy if exists "Users can view relevant termination logs" on public.termination_logs;
-- create policy "Users can view relevant termination logs"
--   on public.termination_logs for select
--   using (
--     profile_id in (select id from public.profiles where auth_user_id = auth.uid())
--     or exists (
--       select 1 from public.profiles p
--       where p.auth_user_id = auth.uid()
--         and p.role = 'leader'
--         and p.company_id = (
--           select company_id from public.profiles
--           where id = termination_logs.profile_id
--         )
--     )
--   );

-- ── RESTRUCTURE LOGS ──
drop policy if exists "Leaders can view company restructure logs" on public.restructure_logs;
create policy "Leaders can view company restructure logs"
  on public.restructure_logs for select
  using (
    company_id = public.get_user_company_id()
    and exists (
      select 1 from public.profiles p
      where p.auth_user_id = auth.uid()
        and p.role = 'leader'
    )
  );

-- ── AUDIT LOGS ──
drop policy if exists "Leaders can view company audit logs" on public.audit_logs;
create policy "Leaders can view company audit logs"
  on public.audit_logs for select
  using (
    company_id = public.get_user_company_id()
    and exists (
      select 1 from public.profiles p
      where p.auth_user_id = auth.uid()
        and p.role = 'leader'
    )
  );
