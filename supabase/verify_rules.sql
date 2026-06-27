-- ============================================================================
-- verify_rules.sql — Assertion verification test suite for Ascendra MLM DB
-- ============================================================================
-- Wraps tests in a transaction block and performs ROLLBACK at the end.

begin;

-- Create temporary table to store assertion results (without serial column to avoid sequence permissions)
create temporary table test_results (
  test_name text not null,
  passed boolean not null,
  error_message text
);

-- Grant permissions to authenticated role for RLS tests
grant all privileges on table test_results to authenticated;

-- Helper procedure to record test assertions
create or replace procedure assert_true(p_name text, p_condition boolean, p_error text)
language plpgsql as $$
begin
  insert into test_results (test_name, passed, error_message)
  values (p_name, p_condition, case when p_condition then null else p_error end);
end;
$$;

-- ============================================================================
-- 1. ASSERT RLS DOWNLINE ISOLATION POLICIES
-- ============================================================================

-- Alice (Leader) should see all 7 profiles (herself + 5 members + 1 invited Grace)
set local role authenticated;
set local request.jwt.claim.sub = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa';

do $$
declare
  v_count integer;
begin
  select count(*)::integer into v_count from public.profiles;
  call assert_true('RLS: Alice (leader) sees all profiles', v_count = 7, 'Expected 7 profiles, got ' || v_count::text);
end $$;

-- Bob (Member but has downline branch: David & Eva)
-- Bob should see exactly 3 profiles: himself, David, and Eva.
set local role authenticated;
set local request.jwt.claim.sub = 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb';

do $$
declare
  v_count integer;
  v_sees_alice boolean;
  v_sees_charlie boolean;
  v_sees_self boolean;
  v_sees_david boolean;
  v_sees_eva boolean;
begin
  select count(*)::integer into v_count from public.profiles;
  call assert_true('RLS: Bob (member sponsor) sees exactly 3 profiles', v_count = 3, 'Expected 3 profiles, got ' || v_count::text);
  
  select exists(select 1 from public.profiles where id = 'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa') into v_sees_alice;
  select exists(select 1 from public.profiles where id = 'ccaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa') into v_sees_charlie;
  select exists(select 1 from public.profiles where id = 'bbaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa') into v_sees_self;
  select exists(select 1 from public.profiles where id = 'ddaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa') into v_sees_david;
  select exists(select 1 from public.profiles where id = 'eeaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa') into v_sees_eva;
  
  call assert_true('RLS: Bob cannot see Alice', not v_sees_alice, 'Bob should not see Alice');
  call assert_true('RLS: Bob cannot see Charlie', not v_sees_charlie, 'Bob should not see Charlie');
  call assert_true('RLS: Bob can see himself', v_sees_self, 'Bob should see himself');
  call assert_true('RLS: Bob can see David', v_sees_david, 'Bob should see David');
  call assert_true('RLS: Bob can see Eva', v_sees_eva, 'Bob should see Eva');
end $$;

-- David (Member leaf) should see only 1 profile (himself)
set local role authenticated;
set local request.jwt.claim.sub = 'dddddddd-dddd-dddd-dddd-dddddddddddd';

do $$
declare
  v_count integer;
  v_sees_bob boolean;
  v_sees_self boolean;
begin
  select count(*)::integer into v_count from public.profiles;
  call assert_true('RLS: David (member leaf) sees exactly 1 profile', v_count = 1, 'Expected 1 profile, got ' || v_count::text);
  
  select exists(select 1 from public.profiles where id = 'bbaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa') into v_sees_bob;
  select exists(select 1 from public.profiles where id = 'ddaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa') into v_sees_self;
  
  call assert_true('RLS: David cannot see Bob', not v_sees_bob, 'David should not see Bob');
  call assert_true('RLS: David can see himself', v_sees_self, 'David should see himself');
end $$;


-- ============================================================================
-- 2. ASSERT SUBSCRIPTION PLAN LIMITS
-- ============================================================================
set local role postgres;
reset request.jwt.claim.sub;

do $$
declare
  v_error_raised boolean := false;
begin
  -- Temporarily lower the Starter plan member limit to 5
  update public.subscription_plans
  set member_limit = 5
  where name = 'Starter';

  begin
    -- Inserting 6th member (should fail because we already have 5 active/warned/invited members: Bob, Charlie, David, Eva, Grace)
    insert into public.profiles (id, auth_user_id, company_id, distributor_id, full_name, phone, email, role, status)
    values (
      'f0000000-0000-0000-0000-000000000000',
      null,
      '11111111-1111-1111-1111-111111111111',
      'DIST_LIMIT_TEST',
      'Limit Test Member',
      '+15559999999',
      'limit_test@example.com',
      'member',
      'active'
    );
  exception when others then
    v_error_raised := true;
  end;

  call assert_true('Limits: Profile insertion blocks when subscription limit is reached', v_error_raised, 'Inserting member beyond limit should have failed');
end $$;


-- ============================================================================
-- 3. ASSERT NETWORK TREE RESTRUCTURING
-- ============================================================================
do $$
declare
  v_result jsonb;
  v_bob_exists boolean;
  v_david_parent uuid;
  v_david_path text;
  v_david_depth integer;
  v_eva_parent uuid;
  v_eva_path text;
  v_eva_depth integer;
  v_alice_downline integer;
  v_log_exists boolean;
  v_term_log_updated boolean;
begin
  -- 1. Insert termination log for Bob to simulate the workflow
  insert into public.termination_logs (profile_id, terminated_by, reason)
  values (
    'bbaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
    'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
    'Test termination'
  );

  -- 2. Run restructure network tree for Bob
  v_result := public.restructure_network_tree('bbaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa');
  call assert_true('Restructure: restructure_network_tree execution returned success', (v_result->>'success')::boolean, 'Restructuring tree failed: ' || coalesce(v_result->>'error', ''));

  -- 3. Verify Bob is removed from network_nodes
  select exists(select 1 from public.network_nodes where profile_id = 'bbaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa') into v_bob_exists;
  call assert_true('Restructure: Bob node removed from tree', not v_bob_exists, 'Bob node still exists in network_nodes');

  -- 4. Verify David parent is Alice, path is Alice.David, depth is 1
  select parent_id, path, depth into v_david_parent, v_david_path, v_david_depth
  from public.network_nodes
  where profile_id = 'ddaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa';
  
  call assert_true('Restructure: David parent is now Alice', v_david_parent = 'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Expected parent Alice, got ' || coalesce(v_david_parent::text, 'null'));
  call assert_true('Restructure: David path starts with Alice', v_david_path = 'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa.ddaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Expected Alice.David path, got ' || coalesce(v_david_path, 'null'));
  call assert_true('Restructure: David depth is 1', v_david_depth = 1, 'Expected depth 1, got ' || coalesce(v_david_depth::text, 'null'));

  -- 5. Verify Eva parent is Alice, path is Alice.Eva, depth is 1
  select parent_id, path, depth into v_eva_parent, v_eva_path, v_eva_depth
  from public.network_nodes
  where profile_id = 'eeaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa';
  
  call assert_true('Restructure: Eva parent is now Alice', v_eva_parent = 'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Expected parent Alice, got ' || coalesce(v_eva_parent::text, 'null'));
  call assert_true('Restructure: Eva path starts with Alice', v_eva_path = 'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa.eeaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Expected Alice.Eva path, got ' || coalesce(v_eva_path, 'null'));
  call assert_true('Restructure: Eva depth is 1', v_eva_depth = 1, 'Expected depth 1, got ' || coalesce(v_eva_depth::text, 'null'));

  -- 6. Verify Alice downline count (4 nodes total: Charlie, Frank, David, Eva)
  select downline_count into v_alice_downline
  from public.network_nodes
  where profile_id = 'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa';
  call assert_true('Restructure: Alice downline count updated to 4', v_alice_downline = 4, 'Expected downline count 4, got ' || coalesce(v_alice_downline::text, 'null'));

  -- 7. Verify restructure_logs entry exists
  select exists(select 1 from public.restructure_logs where terminated_profile_id = 'bbaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa') into v_log_exists;
  call assert_true('Restructure: Restructure log entry created', v_log_exists, 'No restructure log found for Bob');

  -- 8. Verify termination_logs updated
  select exists(select 1 from public.termination_logs where profile_id = 'bbaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa' and parent_reassigned_to = 'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa' and restructured_at is not null) into v_term_log_updated;
  call assert_true('Restructure: Termination log updated with parent reassignment', v_term_log_updated, 'Termination log not updated correctly');
end $$;


-- ============================================================================
-- 4. ASSERT MEMBER PROGRESS MATERIALIZED VIEW
-- ============================================================================
do $$
declare
  v_meetings_attended integer;
  v_total_duration integer;
  v_total_tasks integer;
  v_completed_tasks integer;
  v_task_rate numeric;
  v_quizzes_taken integer;
  v_quizzes_passed integer;
  v_quiz_rate numeric;
begin
  -- Refresh materialized views first
  perform public.refresh_analytics_views();

  select 
    meetings_attended, 
    total_attendance_duration_minutes, 
    total_tasks_assigned, 
    tasks_completed, 
    task_completion_rate_pct,
    quizzes_taken,
    quizzes_passed,
    quiz_pass_rate_pct
  into 
    v_meetings_attended, 
    v_total_duration, 
    v_total_tasks, 
    v_completed_tasks, 
    v_task_rate,
    v_quizzes_taken,
    v_quizzes_passed,
    v_quiz_rate
  from public.mv_member_progress
  where profile_id = 'bbaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa';

  call assert_true('Analytics: Bob meetings attended = 1', v_meetings_attended = 1, 'Expected 1 meeting, got ' || coalesce(v_meetings_attended::text, 'null'));
  call assert_true('Analytics: Bob total duration = 60', v_total_duration = 60, 'Expected 60 minutes, got ' || coalesce(v_total_duration::text, 'null'));
  call assert_true('Analytics: Bob total tasks = 1', v_total_tasks = 1, 'Expected 1 task, got ' || coalesce(v_total_tasks::text, 'null'));
  call assert_true('Analytics: Bob completed tasks = 1', v_completed_tasks = 1, 'Expected 1 task completed, got ' || coalesce(v_completed_tasks::text, 'null'));
  call assert_true('Analytics: Bob task rate = 100%', v_task_rate = 100.00, 'Expected 100% task rate, got ' || coalesce(v_task_rate::text, 'null'));
  call assert_true('Analytics: Bob quizzes taken = 1', v_quizzes_taken = 1, 'Expected 1 quiz taken, got ' || coalesce(v_quizzes_taken::text, 'null'));
  call assert_true('Analytics: Bob quizzes passed = 1', v_quizzes_passed = 1, 'Expected 1 quiz passed, got ' || coalesce(v_quizzes_passed::text, 'null'));
  call assert_true('Analytics: Bob quiz rate = 100%', v_quiz_rate = 100.00, 'Expected 100% quiz rate, got ' || coalesce(v_quiz_rate::text, 'null'));
end $$;

-- ============================================================================
-- REPORT TEST RESULTS
-- ============================================================================
select case when passed then '🟢 PASS' else '🔴 FAIL' end as status, 
       test_name, 
       error_message 
from test_results;

rollback;
