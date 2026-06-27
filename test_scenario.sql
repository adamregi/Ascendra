-- Setup Cron jobs
do $$
begin
    perform cron.schedule('daily_mv_member_analytics',     '0  1 * * *', 'REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_member_analytics');
    perform cron.schedule('daily_mv_team_analytics',       '3  1 * * *', 'REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_team_analytics');
    perform cron.schedule('daily_mv_meeting_analytics',    '6  1 * * *', 'REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_meeting_analytics');
    perform cron.schedule('daily_mv_task_analytics',       '9  1 * * *', 'REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_task_analytics');
    perform cron.schedule('daily_mv_growth_analytics',     '12 1 * * *', 'REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_growth_analytics');
    perform cron.schedule('daily_mv_top_performers',       '15 1 * * *', 'REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_top_performers');
    perform cron.schedule('daily_mv_leadership_pipeline',  '18 1 * * *', 'REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_leadership_pipeline');
    perform cron.schedule('daily_mv_promotion_candidates', '21 1 * * *', 'REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_promotion_candidates');
    perform cron.schedule('weekly_growth_intelligence',    '0  2 * * 0', 'SELECT public.refresh_growth_intelligence()');
    perform cron.schedule('weekly_mv_leadership_pipeline', '10 2 * * 0', 'REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_leadership_pipeline');
    perform cron.schedule('weekly_mv_promotion_candidates','13 2 * * 0', 'REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_promotion_candidates');
    perform cron.schedule('daily_mv_executive_overview',      '24 1 * * *', 'REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_executive_overview');
    perform cron.schedule('daily_mv_recommendation_center',   '27 1 * * *', 'REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_recommendation_center');
end
$$;

DO $$
DECLARE
    v_company_id uuid := '11111111-1111-1111-1111-111111111111';
    v_leader_id uuid := 'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa';
    v_member_1 uuid := gen_random_uuid();
    v_member_2 uuid := gen_random_uuid();
    v_member_3 uuid := gen_random_uuid();
    v_meeting_1 uuid := gen_random_uuid();
    v_meeting_2 uuid := gen_random_uuid();
    v_meeting_3 uuid := gen_random_uuid();
BEGIN
    INSERT INTO public.profiles (id, full_name, role, status, company_id, distributor_id, email, phone)
    VALUES 
    (v_member_1, 'Member One', 'member', 'active', v_company_id, 'M_TEST_1', 'm1@test.com', '+10000001111'),
    (v_member_2, 'Member Two', 'member', 'active', v_company_id, 'M_TEST_2', 'm2@test.com', '+10000002222'),
    (v_member_3, 'Member Three', 'member', 'active', v_company_id, 'M_TEST_3', 'm3@test.com', '+10000003333');
    
    INSERT INTO public.network_nodes (profile_id, parent_id, company_id, depth, path, downline_count)
    VALUES 
    (v_member_1, v_leader_id, v_company_id, 1, v_leader_id::text || '.' || v_member_1::text, 0),
    (v_member_2, v_leader_id, v_company_id, 1, v_leader_id::text || '.' || v_member_2::text, 0),
    (v_member_3, v_leader_id, v_company_id, 1, v_leader_id::text || '.' || v_member_3::text, 0);

    INSERT INTO public.meetings (id, company_id, leader_id, title, meeting_status, scheduled_at, started_at, ended_at)
    VALUES 
    (v_meeting_1, v_company_id, v_leader_id, 'Test Meeting 1', 'completed', now() - interval '3 weeks', now() - interval '3 weeks', now() - interval '3 weeks' + interval '1 hour'),
    (v_meeting_2, v_company_id, v_leader_id, 'Test Meeting 2', 'completed', now() - interval '2 weeks', now() - interval '2 weeks', now() - interval '2 weeks' + interval '1 hour'),
    (v_meeting_3, v_company_id, v_leader_id, 'Test Meeting 3', 'completed', now() - interval '1 week', now() - interval '1 week', now() - interval '1 week' + interval '1 hour');

    INSERT INTO public.meeting_attendances (id, meeting_id, profile_id, attendance_status)
    VALUES 
    (gen_random_uuid(), v_meeting_1, v_member_1, 'attended'), 
    (gen_random_uuid(), v_meeting_2, v_member_1, 'attended'), 
    (gen_random_uuid(), v_meeting_3, v_member_1, 'attended'),
    (gen_random_uuid(), v_meeting_1, v_member_2, 'attended'), 
    (gen_random_uuid(), v_meeting_2, v_member_2, 'absent'), 
    (gen_random_uuid(), v_meeting_3, v_member_2, 'absent'),
    (gen_random_uuid(), v_meeting_1, v_member_3, 'absent'), 
    (gen_random_uuid(), v_meeting_2, v_member_3, 'attended'), 
    (gen_random_uuid(), v_meeting_3, v_member_3, 'attended');
    
    INSERT INTO public.meeting_sessions (attendance_id, joined_at, left_at)
    SELECT id, (select started_at from public.meetings where id = meeting_id) + interval '2 minutes', (select ended_at from public.meetings where id = meeting_id)
    FROM public.meeting_attendances WHERE profile_id = v_member_1;
    
    INSERT INTO public.meeting_sessions (attendance_id, joined_at, left_at)
    SELECT id, (select started_at from public.meetings where id = meeting_id) + interval '30 minutes', (select ended_at from public.meetings where id = meeting_id)
    FROM public.meeting_attendances WHERE profile_id = v_member_2 AND attendance_status = 'attended';
    
    INSERT INTO public.meeting_sessions (attendance_id, joined_at, left_at)
    SELECT id, (select started_at from public.meetings where id = meeting_id) + interval '5 minutes', (select ended_at from public.meetings where id = meeting_id)
    FROM public.meeting_attendances WHERE profile_id = v_member_3 AND attendance_status = 'attended';
END
$$;

SELECT public.refresh_analytics_views();
SELECT public.refresh_growth_intelligence();
