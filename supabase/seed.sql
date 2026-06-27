-- ============================================================================
-- seed.sql — Realistic dataset for Ascendra leadership platform testing
-- ============================================================================
-- Populates 1 Company, 1 Leader, 6 Profiles (5 active/warned/terminated members,
-- 1 invited prospect), 2 Invitations, 1 Active Subscription, 3 Meetings,
-- 5 Tasks, and 3 Followups.

-- Clear existing data (in case of re-run without db reset)
truncate table public.audit_logs cascade;
-- truncate table public.termination_logs cascade; (Temporarily commented out for Phase D1)
truncate table public.restructure_logs cascade;
-- truncate table public.compliance_snapshots cascade; (Temporarily commented out for Phase D1)
truncate table public.compliance_events cascade;
truncate table public.compliance_violations cascade;
truncate table public.compliance_rules cascade;
truncate table public.ai_usage_logs cascade;
truncate table public.ai_messages cascade;
truncate table public.ai_conversations cascade;
truncate table public.success_stories cascade;
truncate table public.product_faqs cascade;
truncate table public.products cascade;
truncate table public.document_chunks cascade;
truncate table public.documents cascade;
truncate table public.notifications cascade;
truncate table public.followups cascade;
truncate table public.task_assignments cascade;
truncate table public.task_proofs cascade;
truncate table public.tasks cascade;
truncate table public.meeting_recordings cascade;
truncate table public.meeting_answers cascade;
truncate table public.meeting_questions cascade;
truncate table public.meeting_sessions cascade;
truncate table public.meeting_attendances cascade;
truncate table public.meetings cascade;
truncate table public.invitations cascade;
truncate table public.subscriptions cascade;
truncate table public.network_nodes cascade;
truncate table public.profiles cascade;
truncate table public.company_settings cascade;
truncate table public.companies cascade;

-- Seed Supabase Auth Users
insert into auth.users (id, email, raw_app_meta_data, raw_user_meta_data, aud, role)
values
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'alice@example.com', '{"provider":"email"}', '{}', 'authenticated', 'authenticated'),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'bob@example.com', '{"provider":"email"}', '{}', 'authenticated', 'authenticated'),
  ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'charlie@example.com', '{"provider":"email"}', '{}', 'authenticated', 'authenticated'),
  ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'david@example.com', '{"provider":"email"}', '{}', 'authenticated', 'authenticated'),
  ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'eva@example.com', '{"provider":"email"}', '{}', 'authenticated', 'authenticated'),
  ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'frank@example.com', '{"provider":"email"}', '{}', 'authenticated', 'authenticated')
on conflict (id) do nothing;

-- Defer circular FK checks for transactional company insertion
set constraints public.companies_owner_id_fkey, public.profiles_company_id_fkey deferred;

-- 1. Seed Company
insert into public.companies (id, name, slug, owner_id)
values (
  '11111111-1111-1111-1111-111111111111',
  'Apex Distributors',
  'apex-distributors',
  'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'
);

-- 2. Seed Company Settings
insert into public.company_settings (company_id, timezone, auto_terminate)
values ('11111111-1111-1111-1111-111111111111', 'UTC', true)
on conflict (company_id) do nothing;

-- 3. Seed Compliance Rules
insert into public.compliance_rules (company_id, rule_type, threshold, severity, enabled, description)
values
  ('11111111-1111-1111-1111-111111111111', 'attendance_percentage', 90, 'high', true, 'Attendance must remain above 90%'),
  ('11111111-1111-1111-1111-111111111111', 'overdue_tasks', 3, 'medium', true, 'Maximum of 3 overdue tasks allowed'),
  ('11111111-1111-1111-1111-111111111111', 'inactive_days', 14, 'high', true, 'Maximum of 14 days of inactivity allowed')
on conflict (company_id, rule_type) do nothing;

-- 4. Seed Profiles (including 1 invited prospect with no auth user yet)
insert into public.profiles (id, auth_user_id, company_id, distributor_id, full_name, phone, email, role, status)
values
  ('baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', 'DIST_ALICE', 'Alice Leader', '+15550000001', 'alice@example.com', 'leader', 'active'),
  ('bbaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '11111111-1111-1111-1111-111111111111', 'DIST_BOB', 'Bob Member', '+15550000002', 'bob@example.com', 'member', 'active'),
  ('ccaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'cccccccc-cccc-cccc-cccc-cccccccccccc', '11111111-1111-1111-1111-111111111111', 'DIST_CHARLIE', 'Charlie Member', '+15550000003', 'charlie@example.com', 'member', 'active'),
  ('ddaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'dddddddd-dddd-dddd-dddd-dddddddddddd', '11111111-1111-1111-1111-111111111111', 'DIST_DAVID', 'David Member', '+15550000004', 'david@example.com', 'member', 'active'),
  ('eeaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', '11111111-1111-1111-1111-111111111111', 'DIST_EVA', 'Eva Member', '+15550000005', 'eva@example.com', 'member', 'warned'),
  ('ffaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'ffffffff-ffff-ffff-ffff-ffffffffffff', '11111111-1111-1111-1111-111111111111', 'DIST_FRANK', 'Frank Member', '+15550000006', 'frank@example.com', 'member', 'terminated'),
  ('99aaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', null, '11111111-1111-1111-1111-111111111111', 'DIST_GRACE', 'Grace Prospect', '+15550000007', 'grace@example.com', 'member', 'invited');

-- Commit circular references
commit;

-- 5. Seed Network Tree Nodes
-- Genealogy branch structure:
-- Alice (depth 0, root)
-- ├── Bob (depth 1)
-- │   ├── David (depth 2)
-- │   └── Eva (depth 2)
-- └── Charlie (depth 1)
--     └── Frank (depth 2)
insert into public.network_nodes (profile_id, parent_id, company_id, depth, path, downline_count)
values
  ('baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', null, '11111111-1111-1111-1111-111111111111', 0, 'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 5),
  ('bbaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', 1, 'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa.bbaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 2),
  ('ccaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', 1, 'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa.ccaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 1),
  ('ddaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'bbaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', 2, 'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa.bbaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa.ddaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 0),
  ('eeaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'bbaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', 2, 'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa.bbaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa.eeaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 0),
  ('ffaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'ccaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', 2, 'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa.ccaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa.ffaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 0);

-- 6. Seed Active Subscription (Starter plan: 50 members cap)
insert into public.subscriptions (leader_id, plan_id, status, expires_at)
values (
  'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
  (select id from public.subscription_plans where name = 'Starter'),
  'active',
  now() + interval '30 days'
);

-- 7. Seed Invitations
insert into public.invitations (inviter_id, profile_id, company_id, distributor_id, full_name, phone, status, expires_at)
values
  ('baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'ccaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', 'DIST_CHARLIE', 'Charlie Member', '+15550000003', 'accepted', now() + interval '7 days'),
  ('baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '99aaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', 'DIST_GRACE', 'Grace Prospect', '+15550000007', 'pending', now() + interval '7 days');

-- 8. Seed Meetings
insert into public.meetings (id, company_id, leader_id, title, meeting_status, scheduled_at, started_at, ended_at, room_id)
values
  ('33333333-3333-3333-3333-333333333331', '11111111-1111-1111-1111-111111111111', 'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Daily Alignment', 'scheduled', now() + interval '2 hours', null, null, 'room-1'),
  ('33333333-3333-3333-3333-333333333332', '11111111-1111-1111-1111-111111111111', 'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Weekly Training', 'live', now() - interval '10 minutes', now() - interval '10 minutes', null, 'room-2'),
  ('33333333-3333-3333-3333-333333333333', '11111111-1111-1111-1111-111111111111', 'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Monthly Review', 'completed', now() - interval '1 day', now() - interval '1 day', now() - interval '23 hours', 'room-3');

-- 9. Seed Meeting Attendance Records & Sessions
-- Bob fully attended
insert into public.meeting_attendances (id, meeting_id, profile_id, attendance_status)
values ('aa111111-1111-1111-1111-111111111111', '33333333-3333-3333-3333-333333333333', 'bbaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'registered');

insert into public.meeting_sessions (attendance_id, joined_at, left_at)
values ('aa111111-1111-1111-1111-111111111111', now() - interval '1 day', now() - interval '23 hours');

-- Charlie fully attended
insert into public.meeting_attendances (id, meeting_id, profile_id, attendance_status)
values ('aa222222-2222-2222-2222-222222222222', '33333333-3333-3333-3333-333333333333', 'ccaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'registered');

insert into public.meeting_sessions (attendance_id, joined_at, left_at)
values ('aa222222-2222-2222-2222-222222222222', now() - interval '1 day', now() - interval '23 hours');

-- David joined late, did not finish full meeting
insert into public.meeting_attendances (id, meeting_id, profile_id, attendance_status)
values ('aa333333-3333-3333-3333-333333333333', '33333333-3333-3333-3333-333333333333', 'ddaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'registered');

insert into public.meeting_sessions (attendance_id, joined_at, left_at)
values ('aa333333-3333-3333-3333-333333333333', now() - interval '23 hours 15 minutes', now() - interval '23 hours');

-- 10. Seed Tasks & Assignments
insert into public.tasks (id, company_id, leader_id, title, status, priority)
values
  ('44444444-4444-4444-4444-444444444441', '11111111-1111-1111-1111-111111111111', 'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Task One', 'completed', 'normal'),
  ('44444444-4444-4444-4444-444444444442', '11111111-1111-1111-1111-111111111111', 'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Task Two', 'active', 'high'),
  ('44444444-4444-4444-4444-444444444443', '11111111-1111-1111-1111-111111111111', 'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Task Three', 'assigned', 'low'),
  ('44444444-4444-4444-4444-444444444444', '11111111-1111-1111-1111-111111111111', 'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Task Four', 'assigned', 'normal'),
  ('44444444-4444-4444-4444-444444444445', '11111111-1111-1111-1111-111111111111', 'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Task Five', 'cancelled', 'urgent');

insert into public.task_assignments (task_id, member_id, status)
values
  ('44444444-4444-4444-4444-444444444441', 'bbaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'approved'),
  ('44444444-4444-4444-4444-444444444442', 'ccaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'in_progress'),
  ('44444444-4444-4444-4444-444444444443', 'ddaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'assigned'),
  ('44444444-4444-4444-4444-444444444444', 'eeaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'assigned'),
  ('44444444-4444-4444-4444-444444444445', 'ffaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'assigned');

-- 11. Seed Followups
insert into public.followups (company_id, leader_id, member_id, reason_type, reason, status, due_date)
values
  ('11111111-1111-1111-1111-111111111111', 'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'bbaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'manual', 'Check in with Bob', 'open', now() + interval '1 day'),
  ('11111111-1111-1111-1111-111111111111', 'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'ccaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'manual', 'Discuss with Charlie', 'open', now() + interval '2 days'),
  ('11111111-1111-1111-1111-111111111111', 'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'eeaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'inactive', 'Help Eva with warned status', 'completed', now() - interval '1 day');

-- 12. Seed Quizzes
insert into public.meeting_quizzes (id, meeting_id, title, passing_score_pct)
values ('55555555-5555-5555-5555-555555555551', '33333333-3333-3333-3333-333333333333', 'Monthly Quiz 1', 60);

-- 13. Seed Quiz Questions
insert into public.quiz_questions (id, quiz_id, question_text, options, correct_option_index, points)
values
  ('66666666-6666-6666-6666-666666666661', '55555555-5555-5555-5555-555555555551', 'What is our focus this month?', '["Sales", "Compliance", "Productivity", "Expansion"]'::jsonb, 1, 1),
  ('66666666-6666-6666-6666-666666666662', '55555555-5555-5555-5555-555555555551', 'What is the required meeting duration?', '["10m", "15m", "30m", "60m"]'::jsonb, 2, 1);

-- 14. Seed Quiz Responses
insert into public.quiz_responses (quiz_id, profile_id, answers, score_pct, passed)
values
  ('55555555-5555-5555-5555-555555555551', 'bbaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '{"66666666-6666-6666-6666-666666666661": 1, "66666666-6666-6666-6666-666666666662": 2}'::jsonb, 100.00, true),
  ('55555555-5555-5555-5555-555555555551', 'ccaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '{"66666666-6666-6666-6666-666666666661": 1, "66666666-6666-6666-6666-666666666662": 0}'::jsonb, 50.00, false);
