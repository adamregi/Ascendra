-- ============================================================================
-- 021_helper_functions.sql — Database functions and stored procedures
-- ============================================================================
-- Core system helpers, recursive tree queries, atomic transactions,
-- vector similarity search, and analytics refreshing.
--
-- Dependencies: 001_extensions.sql, 002_companies.sql, 003_profiles.sql,
--               004_network_nodes.sql, 017_documents.sql, 019_compliance.sql

-- ============================================================================
-- Helper: get_user_company_id
-- ============================================================================
create or replace function public.get_user_company_id()
returns uuid
language sql
stable
security definer
set search_path = public
as $$
  select company_id from public.profiles
  where auth_user_id = auth.uid()
  limit 1;
$$;

-- ============================================================================
-- Helper: can_view_profile
-- ============================================================================
create or replace function public.can_view_profile(p_viewer_auth_id uuid, p_target_profile_id uuid)
returns boolean
language sql
stable
security definer
set search_path = public, extensions
as $$
  select exists (
    select 1
    from public.profiles viewer
    left join public.network_nodes viewer_node on viewer_node.profile_id = viewer.id
    left join public.network_nodes target_node on target_node.profile_id = p_target_profile_id
    left join public.invitations i on i.profile_id = p_target_profile_id and i.inviter_id = viewer.id
    where viewer.auth_user_id = p_viewer_auth_id
      and (
        viewer.id = p_target_profile_id
        or (viewer_node.path_ltree @> target_node.path_ltree and viewer.company_id = target_node.company_id)
        or i.id is not null
      )
  );
$$;

-- ============================================================================
-- Network Tree: get_descendants (recursive CTE)
-- ============================================================================
create or replace function public.get_descendants(p_profile_id uuid)
returns table (
  profile_id uuid,
  parent_id uuid,
  depth integer
)
language sql
stable
as $$
  with recursive descendants as (
    select
      nn.profile_id,
      nn.parent_id,
      1 as depth
    from public.network_nodes nn
    where nn.parent_id = p_profile_id

    union all

    select
      nn.profile_id,
      nn.parent_id,
      d.depth + 1
    from public.network_nodes nn
    inner join descendants d on nn.parent_id = d.profile_id
  )
  select * from descendants;
$$;

-- ============================================================================
-- Network Tree: get_ancestors (recursive CTE)
-- ============================================================================
create or replace function public.get_ancestors(p_profile_id uuid)
returns table (
  profile_id uuid,
  parent_id uuid,
  depth integer
)
language sql
stable
as $$
  with recursive ancestors as (
    select
      nn.profile_id,
      nn.parent_id,
      1 as depth
    from public.network_nodes nn
    where nn.profile_id = (
      select parent_id from public.network_nodes where profile_id = p_profile_id
    )

    union all

    select
      nn.profile_id,
      nn.parent_id,
      a.depth + 1
    from public.network_nodes nn
    inner join ancestors a on nn.profile_id = a.parent_id
    where a.parent_id is not null
  )
  select * from ancestors;
$$;

-- ============================================================================
-- Network Tree: calculate_subtree_size
-- ============================================================================
create or replace function public.calculate_subtree_size(p_profile_id uuid)
returns integer
language sql
stable
as $$
  select count(*)::integer from public.get_descendants(p_profile_id);
$$;

-- ============================================================================
-- Network Tree: calculate_node_depth
-- ============================================================================
create or replace function public.calculate_node_depth(p_profile_id uuid)
returns integer
language sql
stable
as $$
  select count(*)::integer from public.get_ancestors(p_profile_id);
$$;

-- ============================================================================
-- Helper: _rebuild_subtree_paths (internal path and depth rebuilder)
-- ============================================================================
create or replace function public._rebuild_subtree_paths(p_node_id uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_parent_path text;
  v_parent_depth integer;
  v_new_path text;
  v_new_depth integer;
  v_child_id uuid;
begin
  -- Get parent's path and depth
  select nn_parent.path, nn_parent.depth into v_parent_path, v_parent_depth
  from public.network_nodes nn
  join public.network_nodes nn_parent on nn.parent_id = nn_parent.profile_id
  where nn.profile_id = p_node_id;

  if v_parent_path is not null then
    v_new_path := v_parent_path || '.' || p_node_id::text;
    v_new_depth := v_parent_depth + 1;
  else
    -- This node is now a root node
    v_new_path := p_node_id::text;
    v_new_depth := 0;
  end if;

  -- Update this node's path and depth
  update public.network_nodes
  set path = v_new_path,
      depth = v_new_depth
  where profile_id = p_node_id;

  -- Recursively rebuild all children
  for v_child_id in
    select profile_id from public.network_nodes where parent_id = p_node_id
  loop
    perform public._rebuild_subtree_paths(v_child_id);
  end loop;
end;
$$;

-- ============================================================================
-- Network Tree Restructuring: restructure_network_tree
-- ============================================================================
create or replace function public.restructure_network_tree(p_terminated_id uuid)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_terminated_node record;
  v_new_parent_id uuid;
  v_children_moved integer := 0;
  v_before_tree jsonb;
  v_after_tree jsonb;
  v_company_id uuid;
  v_child record;
begin
  -- 1. Lock and fetch the terminated node
  select * into v_terminated_node
  from public.network_nodes
  where profile_id = p_terminated_id
  for update;

  if not found then
    return jsonb_build_object(
      'success', false,
      'error', 'Network node not found for terminated profile'
    );
  end if;

  -- Get company_id for the restructure log
  select company_id into v_company_id
  from public.profiles
  where id = p_terminated_id;

  -- The new parent is the terminated node's parent
  v_new_parent_id := v_terminated_node.parent_id;

  -- 2. Capture before state
  select jsonb_agg(jsonb_build_object(
    'profile_id', nn.profile_id,
    'parent_id', nn.parent_id,
    'path', nn.path
  ))
  into v_before_tree
  from public.network_nodes nn
  where nn.parent_id = p_terminated_id;

  -- 3. Reassign all direct children to the terminated node's parent
  for v_child in
    select * from public.network_nodes
    where parent_id = p_terminated_id
    for update
  loop
    update public.network_nodes
    set parent_id = v_new_parent_id
    where profile_id = v_child.profile_id;

    v_children_moved := v_children_moved + 1;
  end loop;

  -- 4. Rebuild paths and depths for all affected descendants
  perform public._rebuild_subtree_paths(v_child_id)
  from (
    select profile_id as v_child_id
    from public.network_nodes
    where parent_id = v_new_parent_id
      and profile_id != p_terminated_id
  ) affected;

  -- 6. Remove the terminated node from the tree
  delete from public.network_nodes where profile_id = p_terminated_id;

  -- 5. Update counts on the new parent
  if v_new_parent_id is not null then
    update public.network_nodes
    set
      downline_count = (
        select count(*) from public.get_descendants(v_new_parent_id)
      )
    where profile_id = v_new_parent_id;
  end if;

  -- 7. Capture after state
  if v_new_parent_id is not null then
    select jsonb_agg(jsonb_build_object(
      'profile_id', nn.profile_id,
      'parent_id', nn.parent_id,
      'path', nn.path
    ))
    into v_after_tree
    from public.network_nodes nn
    where nn.parent_id = v_new_parent_id;
  else
    v_after_tree := '[]'::jsonb;
  end if;

  -- 8. Log the restructure
  if v_company_id is not null then
    insert into public.restructure_logs (
      company_id,
      terminated_profile_id,
      new_parent_id,
      children_moved,
      before_tree,
      after_tree
    ) values (
      v_company_id,
      p_terminated_id,
      v_new_parent_id,
      v_children_moved,
      coalesce(v_before_tree, '[]'::jsonb),
      coalesce(v_after_tree, '[]'::jsonb)
    );
  end if;

  -- 9. Update the termination_logs record with restructure info
  update public.termination_logs
  set
    parent_reassigned_to = v_new_parent_id,
    restructured_at = now()
  where profile_id = p_terminated_id
    and restructured_at is null;

  return jsonb_build_object(
    'success', true,
    'terminated_profile_id', p_terminated_id,
    'new_parent_id', v_new_parent_id,
    'children_moved', v_children_moved
  );
end;
$$;

-- ============================================================================
-- Transactional Helper: create_company_atomic
-- ============================================================================
create or replace function public.create_company_atomic(
  p_user_id uuid,
  p_company_name text,
  p_company_slug text,
  p_full_name text,
  p_logo_url text default null,
  p_distributor_id text default null
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_company_id uuid;
  v_company record;
  v_profile record;
begin
  -- Defer circular FK checks until transaction commit
  set constraints companies_owner_id_fkey, profiles_company_id_fkey deferred;

  -- 1. Generate company ID
  v_company_id := gen_random_uuid();

  -- 2. Insert company
  insert into public.companies (id, name, slug, owner_id, logo_url)
  values (v_company_id, p_company_name, p_company_slug, p_user_id, p_logo_url)
  returning * into v_company;

  -- 3. Insert leader profile (OTP onboarding updates auth_user_id later)
  insert into public.profiles (id, auth_user_id, full_name, company_id, role, status, phone, distributor_id)
  values (
    p_user_id,
    p_user_id,
    p_full_name,
    v_company_id,
    'leader',
    'active',
    'temp_phone_' || p_user_id::text,
    coalesce(p_distributor_id, 'DIST_' || upper(substring(p_user_id::text, 1, 8)))
  )
  returning * into v_profile;

  -- 4. Create root network node
  insert into public.network_nodes (profile_id, parent_id, depth, path, downline_count, company_id)
  values (p_user_id, null, 0, p_user_id::text, 0, v_company_id);

  -- 5. Create default company settings
  insert into public.company_settings (company_id)
  values (v_company_id);

  -- 6. Create default compliance rules
  insert into public.compliance_rules (company_id, rule_type, threshold, severity, enabled, description)
  values
    (v_company_id, 'attendance_percentage', 90, 'high', true, 'Attendance must remain above 90%'),
    (v_company_id, 'overdue_tasks', 3, 'medium', true, 'Maximum of 3 overdue tasks allowed'),
    (v_company_id, 'inactive_days', 14, 'high', true, 'Maximum of 14 days of inactivity allowed'),
    (v_company_id, 'open_followups', 5, 'low', true, 'Maximum of 5 open follow-ups allowed');

  -- 7. Create audit log entry
  insert into public.audit_logs (company_id, actor_id, target_id, action, entity_type, after_data)
  values (
    v_company_id,
    p_user_id,
    v_company_id,
    'created',
    'company',
    jsonb_build_object(
      'name', p_company_name,
      'slug', p_company_slug,
      'ownerId', p_user_id
    )
  );

  return jsonb_build_object(
    'company', row_to_json(v_company),
    'profile', row_to_json(v_profile)
  );
end;
$$;

-- ============================================================================
-- Helper: match_document_chunks (pgvector similarity search)
-- ============================================================================
create or replace function public.match_document_chunks (
  query_embedding extensions.vector(768),
  match_threshold float,
  match_count int,
  p_company_id uuid
)
returns table (
  id uuid,
  document_id uuid,
  chunk_text text,
  similarity float
)
language sql stable
as $$
  select
    dc.id,
    dc.document_id,
    dc.chunk_text,
    1 - (dc.embedding <=> query_embedding) as similarity
  from public.document_chunks dc
  join public.documents d on dc.document_id = d.id
  where d.company_id = p_company_id
    and 1 - (dc.embedding <=> query_embedding) > match_threshold
  order by dc.embedding <=> query_embedding
  limit match_count;
$$;

-- ============================================================================
-- Sync Trigger: products to documents
-- ============================================================================
create or replace function public.sync_product_to_documents()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  v_owner_id uuid;
begin
  select owner_id into v_owner_id from public.companies where id = new.company_id;
  
  if tg_op = 'INSERT' then
    insert into public.documents (
      company_id,
      uploaded_by,
      title,
      category,
      file_url,
      file_name,
      storage_path,
      mime_type,
      raw_text
    ) values (
      new.company_id,
      v_owner_id,
      new.name,
      'product',
      'virtual://product/' || new.id::text,
      new.name,
      'virtual/product/' || new.id::text,
      'text/markdown',
      '# ' || new.name || E'\n\n## Description\n' || coalesce(new.description, '') || E'\n\n## Benefits\n' || coalesce(new.benefits, '')
    );
  elsif tg_op = 'UPDATE' then
    update public.documents
    set
      title = new.name,
      file_name = new.name,
      raw_text = '# ' || new.name || E'\n\n## Description\n' || coalesce(new.description, '') || E'\n\n## Benefits\n' || coalesce(new.benefits, '')
    where storage_path = 'virtual/product/' || new.id::text;
  end if;
  return new;
end;
$$;

create or replace function public.delete_product_from_documents()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  delete from public.documents
  where storage_path = 'virtual/product/' || old.id::text;
  return old;
end;
$$;

drop trigger if exists sync_product_insert_update on public.products;
create trigger sync_product_insert_update
  after insert or update on public.products
  for each row execute function public.sync_product_to_documents();
  
drop trigger if exists sync_product_delete on public.products;
create trigger sync_product_delete
  after delete on public.products
  for each row execute function public.delete_product_from_documents();

-- ============================================================================
-- Sync Trigger: product_faqs to documents
-- ============================================================================
create or replace function public.sync_product_faq_to_documents()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  v_company_id uuid;
  v_owner_id uuid;
begin
  select company_id into v_company_id from public.products where id = new.product_id;
  select owner_id into v_owner_id from public.companies where id = v_company_id;
  
  if tg_op = 'INSERT' then
    insert into public.documents (
      company_id,
      uploaded_by,
      title,
      category,
      file_url,
      file_name,
      storage_path,
      mime_type,
      raw_text
    ) values (
      v_company_id,
      v_owner_id,
      new.question,
      'faq',
      'virtual://faq/' || new.id::text,
      new.question,
      'virtual/faq/' || new.id::text,
      'text/markdown',
      'Question: ' || new.question || E'\n\nAnswer: ' || new.answer
    );
  elsif tg_op = 'UPDATE' then
    update public.documents
    set
      title = new.question,
      file_name = new.question,
      raw_text = 'Question: ' || new.question || E'\n\nAnswer: ' || new.answer
    where storage_path = 'virtual/faq/' || new.id::text;
  end if;
  return new;
end;
$$;

create or replace function public.delete_product_faq_from_documents()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  delete from public.documents
  where storage_path = 'virtual/faq/' || old.id::text;
  return old;
end;
$$;

drop trigger if exists sync_product_faq_insert_update on public.product_faqs;
create trigger sync_product_faq_insert_update
  after insert or update on public.product_faqs
  for each row execute function public.sync_product_faq_to_documents();
  
drop trigger if exists sync_product_faq_delete on public.product_faqs;
create trigger sync_product_faq_delete
  after delete on public.product_faqs
  for each row execute function public.delete_product_faq_from_documents();

-- ============================================================================
-- Sync Trigger: success_stories to documents
-- ============================================================================
create or replace function public.sync_success_story_to_documents()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  v_owner_id uuid;
begin
  select owner_id into v_owner_id from public.companies where id = new.company_id;
  
  if tg_op = 'INSERT' then
    insert into public.documents (
      company_id,
      uploaded_by,
      title,
      category,
      file_url,
      file_name,
      storage_path,
      mime_type,
      raw_text
    ) values (
      new.company_id,
      v_owner_id,
      new.title,
      'success_story',
      'virtual://success_story/' || new.id::text,
      new.title,
      'virtual/success_story/' || new.id::text,
      'text/markdown',
      '# ' || new.title || E'\n\n' || coalesce(new.description, '') || E'\n\nWatch here: ' || coalesce(new.youtube_url, '')
    );
  elsif tg_op = 'UPDATE' then
    update public.documents
    set
      title = new.title,
      file_name = new.title,
      raw_text = '# ' || new.title || E'\n\n' || coalesce(new.description, '') || E'\n\nWatch here: ' || coalesce(new.youtube_url, '')
    where storage_path = 'virtual/success_story/' || new.id::text;
  end if;
  return new;
end;
$$;

create or replace function public.delete_success_story_from_documents()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  delete from public.documents
  where storage_path = 'virtual/success_story/' || old.id::text;
  return old;
end;
$$;

drop trigger if exists sync_success_story_insert_update on public.success_stories;
create trigger sync_success_story_insert_update
  after insert or update on public.success_stories
  for each row execute function public.sync_success_story_to_documents();
  
drop trigger if exists sync_success_story_delete on public.success_stories;
create trigger sync_success_story_delete
  after delete on public.success_stories
  for each row execute function public.delete_success_story_from_documents();

-- ============================================================================
-- Helper: start_meeting (starts meeting by host leader)
-- ============================================================================
create or replace function public.start_meeting(p_meeting_id uuid, p_leader_id uuid)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_meeting record;
begin
  select * into v_meeting
  from public.meetings
  where id = p_meeting_id
  for update;

  if not found then
    raise exception 'Meeting not found';
  end if;

  if v_meeting.leader_id <> p_leader_id then
    raise exception 'Only the host leader is allowed to start this meeting';
  end if;

  if v_meeting.meeting_status <> 'scheduled' then
    raise exception 'Only scheduled meetings can be started (current status: %)', v_meeting.meeting_status;
  end if;

  update public.meetings
  set meeting_status = 'live',
      started_at = now(),
      updated_at = now()
  where id = p_meeting_id
  returning * into v_meeting;

  return row_to_json(v_meeting)::jsonb;
end;
$$;

-- ============================================================================
-- Helper: end_meeting (ends meeting by host leader)
-- ============================================================================
create or replace function public.end_meeting(p_meeting_id uuid, p_leader_id uuid)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_meeting record;
begin
  select * into v_meeting
  from public.meetings
  where id = p_meeting_id
  for update;

  if not found then
    raise exception 'Meeting not found';
  end if;

  if v_meeting.leader_id <> p_leader_id then
    raise exception 'Only the host leader is allowed to end this meeting';
  end if;

  if v_meeting.meeting_status <> 'live' then
    raise exception 'Only live meetings can be ended (current status: %)', v_meeting.meeting_status;
  end if;

  update public.meetings
  set meeting_status = 'completed',
      ended_at = now(),
      updated_at = now()
  where id = p_meeting_id
  returning * into v_meeting;

  return row_to_json(v_meeting)::jsonb;
end;
$$;

-- ============================================================================
-- Helper: join_meeting_session (joins or reconnects to a meeting)
-- ============================================================================
create or replace function public.join_meeting_session(
  p_meeting_id uuid,
  p_profile_id uuid,
  p_join_source text default 'mobile'
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_meeting record;
  v_attendance record;
  v_session record;
  v_active_session_count integer;
  v_has_previous_sessions boolean;
begin
  -- 1. Fetch and lock meeting
  select * into v_meeting
  from public.meetings
  where id = p_meeting_id
  for share;

  if not found then
    raise exception 'Meeting not found';
  end if;

  if v_meeting.meeting_status <> 'live' then
    raise exception 'Meeting is not live';
  end if;

  -- 2. Look up or create the meeting_attendances row (on-demand registration)
  select * into v_attendance
  from public.meeting_attendances
  where meeting_id = p_meeting_id and profile_id = p_profile_id
  for update;

  if not found then
    insert into public.meeting_attendances (meeting_id, profile_id, attendance_status)
    values (p_meeting_id, p_profile_id, 'registered')
    returning * into v_attendance;
  end if;

  -- 3. Check for an already active session for this attendance (idempotence)
  select * into v_session
  from public.meeting_sessions
  where attendance_id = v_attendance.id and left_at is null
  limit 1;

  if found then
    return row_to_json(v_session)::jsonb;
  end if;

  -- 4. Check capacity limit
  if v_meeting.max_participants is not null then
    select count(*)::integer into v_active_session_count
    from public.meeting_sessions ms
    join public.meeting_attendances ma on ma.id = ms.attendance_id
    where ma.meeting_id = p_meeting_id and ms.left_at is null;

    if v_active_session_count >= v_meeting.max_participants then
      raise exception 'Meeting capacity limit reached';
    end if;
  end if;

  -- 5. Check late join rules
  select exists (
    select 1
    from public.meeting_sessions
    where attendance_id = v_attendance.id
  ) into v_has_previous_sessions;

  if not v_has_previous_sessions and not v_meeting.late_join_allowed then
    if v_meeting.started_at is not null and now() > v_meeting.started_at + (v_meeting.late_join_cutoff_minutes * interval '1 minute') then
      raise exception 'Late join not allowed';
    end if;
  end if;

  -- 6. Insert new session
  insert into public.meeting_sessions (attendance_id, joined_at, join_source)
  values (v_attendance.id, now(), p_join_source)
  returning * into v_session;

  return row_to_json(v_session)::jsonb;
end;
$$;

-- ============================================================================
-- Helper: leave_meeting_session (closes active connection segment)
-- ============================================================================
create or replace function public.leave_meeting_session(p_meeting_id uuid, p_profile_id uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_session_id uuid;
begin
  select ms.id into v_session_id
  from public.meeting_sessions ms
  join public.meeting_attendances ma on ma.id = ms.attendance_id
  where ma.meeting_id = p_meeting_id
    and ma.profile_id = p_profile_id
    and ms.left_at is null
  order by ms.joined_at desc
  limit 1
  for update;

  if v_session_id is not null then
    update public.meeting_sessions
    set left_at = now()
    where id = v_session_id;
  end if;
end;
$$;

-- ============================================================================
-- Helper: clean_up_test_data (cleans up test companies and profiles)
-- ============================================================================
create or replace function public.clean_up_test_data()
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_company_record record;
  v_profile_id uuid;
begin
  -- Defer circular FK checks until transaction commit
  set constraints companies_owner_id_fkey, profiles_company_id_fkey deferred;
  -- Loop through and delete all companies matching test slugs
  for v_company_record in
    select id, owner_id from public.companies
    where slug like 'test-company-%' or slug like 'meeting-company-%' or slug like 'task-company-%'
  loop
    -- Delete network nodes first because of on delete restrict
    delete from public.network_nodes where company_id = v_company_record.id;
    -- Delete invitations, meetings, tasks, followups, subscriptions etc.
    delete from public.invitations where company_id = v_company_record.id;
    delete from public.meetings where company_id = v_company_record.id;
    delete from public.tasks where company_id = v_company_record.id;
    delete from public.followups where company_id = v_company_record.id;
    delete from public.subscriptions where leader_id = v_company_record.owner_id;
    
    -- Break circular FK by setting company owner to default seeded leader
    update public.companies
    set owner_id = 'baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'
    where id = v_company_record.id;

    -- Delete the company and profiles
    delete from public.profiles where company_id = v_company_record.id;
    delete from public.companies where id = v_company_record.id;
  end loop;
end;
$$;


-- ============================================================================
-- Helper: create_task_atomic
-- ============================================================================
create or replace function public.create_task_atomic(
  p_company_id uuid,
  p_leader_id uuid,
  p_title text,
  p_description text,
  p_priority text,
  p_due_date timestamptz
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_task record;
begin
  insert into public.tasks (
    company_id, leader_id, title, description, priority, due_date, status
  )
  values (
    p_company_id, p_leader_id, p_title, p_description, p_priority, p_due_date, 'draft'
  )
  returning * into v_task;

  return row_to_json(v_task)::jsonb;
end;
$$;


-- ============================================================================
-- Helper: assign_task_members
-- ============================================================================
create or replace function public.assign_task_members(
  p_task_id uuid,
  p_member_ids uuid[]
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_member_id uuid;
  v_task record;
begin
  select * into v_task from public.tasks where id = p_task_id;
  if not found then
    raise exception 'Task not found';
  end if;

  foreach v_member_id in array p_member_ids loop
    insert into public.task_assignments (task_id, member_id, status)
    values (p_task_id, v_member_id, 'assigned')
    on conflict (task_id, member_id) do nothing;

    insert into public.notifications (company_id, recipient_id, actor_id, task_id, type, title, body)
    values (
      v_task.company_id,
      v_member_id,
      v_task.leader_id,
      p_task_id,
      'task_assigned',
      'New Task Assigned',
      'You have been assigned: ' || v_task.title
    );
  end loop;

  if v_task.status = 'draft' then
    update public.tasks set status = 'assigned' where id = p_task_id;
  end if;
end;
$$;


-- ============================================================================
-- Helper: start_task_assignment
-- ============================================================================
create or replace function public.start_task_assignment(
  p_assignment_id uuid
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_assign record;
  v_task record;
begin
  select * into v_assign from public.task_assignments where id = p_assignment_id;
  if not found then
    raise exception 'Assignment not found';
  end if;

  select * into v_task from public.tasks where id = v_assign.task_id;

  if v_assign.status = 'assigned' then
    update public.task_assignments
    set status = 'in_progress',
        started_at = now(),
        updated_at = now()
    where id = p_assignment_id;

    if v_task.status = 'assigned' then
      update public.tasks set status = 'active' where id = v_assign.task_id;
    end if;
  end if;
end;
$$;


-- ============================================================================
-- Helper: submit_task_proof
-- ============================================================================
create or replace function public.submit_task_proof(
  p_assignment_id uuid,
  p_proof_type text,
  p_comment text,
  p_file_url text
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_proof record;
  v_assign record;
  v_task record;
begin
  select * into v_assign from public.task_assignments where id = p_assignment_id;
  if not found then
    raise exception 'Assignment not found';
  end if;

  select * into v_task from public.tasks where id = v_assign.task_id;

  insert into public.task_proofs (assignment_id, proof_type, comment, file_url, submitted_at)
  values (p_assignment_id, p_proof_type, p_comment, p_file_url, now())
  returning * into v_proof;

  update public.task_assignments
  set status = 'submitted',
      submitted_at = now(),
      updated_at = now()
  where id = p_assignment_id;

  return row_to_json(v_proof)::jsonb;
end;
$$;


-- ============================================================================
-- Helper: review_task_assignment
-- ============================================================================
create or replace function public.review_task_assignment(
  p_assignment_id uuid,
  p_leader_id uuid,
  p_approved boolean,
  p_comment text
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_assign record;
  v_task record;
  v_new_status text;
  v_notif_type text;
  v_notif_title text;
  v_notif_body text;
  v_all_approved boolean;
begin
  select * into v_assign from public.task_assignments where id = p_assignment_id;
  if not found then
    raise exception 'Assignment not found';
  end if;

  select * into v_task from public.tasks where id = v_assign.task_id;
  if v_task.leader_id <> p_leader_id then
    raise exception 'Only the task leader can review assignments';
  end if;

  if p_approved then
    v_new_status := 'approved';
    v_notif_type := 'task_completed';
    v_notif_title := 'Assignment Approved';
    v_notif_body := 'Your submission for "' || v_task.title || '" has been approved.';
  else
    v_new_status := 'rejected';
    v_notif_type := 'task_rejected';
    v_notif_title := 'Assignment Rejected';
    v_notif_body := 'Your submission for "' || v_task.title || '" was rejected. Comment: ' || coalesce(p_comment, '');
  end if;

  update public.task_assignments
  set status = v_new_status,
      reviewed_at = now(),
      review_comment = p_comment,
      updated_at = now()
  where id = p_assignment_id;

  insert into public.notifications (company_id, recipient_id, actor_id, task_id, type, title, body)
  values (
    v_task.company_id,
    v_assign.member_id,
    p_leader_id,
    v_task.id,
    v_notif_type,
    v_notif_title,
    v_notif_body
  );

  select not exists (
    select 1 from public.task_assignments
    where task_id = v_assign.task_id and status <> 'approved'
  ) into v_all_approved;

  if v_all_approved then
    update public.tasks set status = 'completed' where id = v_assign.task_id;
  end if;
end;
$$;


-- ============================================================================
-- Helper: sync_overdue_assignments
-- ============================================================================
create or replace function public.sync_overdue_assignments(
  p_company_id uuid
)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  update public.task_assignments ta
  set status = 'overdue',
      updated_at = now()
  from public.tasks t
  where ta.task_id = t.id
    and t.company_id = p_company_id
    and ta.status in ('assigned', 'in_progress')
    and t.due_date < now();
end;
$$;


-- ============================================================================
-- Helper: create_followup
-- ============================================================================
create or replace function public.create_followup(
  p_company_id uuid,
  p_leader_id uuid,
  p_member_id uuid,
  p_reason_type text,
  p_reason text,
  p_notes text,
  p_due_date timestamptz
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_followup record;
begin
  insert into public.followups (
    company_id, leader_id, member_id, reason_type, reason, notes, due_date, status
  )
  values (
    p_company_id, p_leader_id, p_member_id, p_reason_type, p_reason, p_notes, p_due_date, 'open'
  )
  returning * into v_followup;

  insert into public.notifications (company_id, recipient_id, actor_id, type, title, body)
  values (
    p_company_id,
    p_member_id,
    p_leader_id,
    'followup_created',
    'New Follow-Up Reminded',
    'Follow-up scheduled: ' || p_reason
  );

  return row_to_json(v_followup)::jsonb;
end;
$$;


-- ============================================================================
-- Helper: update_followup
-- ============================================================================
create or replace function public.update_followup(
  p_followup_id uuid,
  p_leader_id uuid,
  p_status text,
  p_notes text
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_followup record;
begin
  select * into v_followup from public.followups where id = p_followup_id;
  if not found then
    raise exception 'Follow-up not found';
  end if;

  if v_followup.leader_id <> p_leader_id then
    raise exception 'Only the follow-up creator can update it';
  end if;

  update public.followups
  set status = p_status,
      notes = coalesce(p_notes, notes),
      updated_at = now()
  where id = p_followup_id
  returning * into v_followup;

  return row_to_json(v_followup)::jsonb;
end;
$$;


-- ============================================================================
-- Helper: evaluate_compliance (calculates compliance breaches and creates violations)
-- ============================================================================
create or replace function public.evaluate_compliance(
  p_company_id uuid
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_member record;
  v_rule record;
  v_attendance_pct numeric;
  v_overdue_count integer;
  v_inactive_days integer;
  v_followup_count integer;
  v_last_activity timestamptz;
  v_violation_exists boolean;
begin
  -- Loop through all members of the company
  for v_member in
    select id, created_at
    from public.profiles
    where company_id = p_company_id
      and role = 'member'
      and status <> 'terminated'
  loop
    -- Loop through all enabled compliance rules of the company
    for v_rule in
      select *
      from public.compliance_rules
      where company_id = p_company_id
        and enabled = true
    loop
      -- Check if an active violation already exists for this rule and member
      select exists (
        select 1
        from public.compliance_violations
        where profile_id = v_member.id
          and rule_id = v_rule.id
          and status in ('open', 'acknowledged')
      ) into v_violation_exists;

      -- ── 1. Attendance Rule Evaluation ──
      if v_rule.rule_type = 'attendance_percentage' then
        select coalesce(avg(attendance_percentage), 100.0)
        into v_attendance_pct
        from public.meeting_attendances ma
        join public.meetings m on ma.meeting_id = m.id
        where ma.profile_id = v_member.id
          and m.meeting_status = 'completed'
          and ma.attendance_status <> 'excused';

        -- Verify if the member has completed meeting records (don't evaluate on empty meeting list)
        if exists (
          select 1
          from public.meeting_attendances ma
          join public.meetings m on ma.meeting_id = m.id
          where ma.profile_id = v_member.id
            and m.meeting_status = 'completed'
            and ma.attendance_status <> 'excused'
        ) then
          if v_attendance_pct < v_rule.threshold then
            if not v_violation_exists then
              insert into public.compliance_violations (
                profile_id, company_id, rule_id, severity, status, details
              ) values (
                v_member.id, p_company_id, v_rule.id, v_rule.severity, 'open',
                'Average attendance (' || round(v_attendance_pct, 1) || '%) is below the minimum required (' || v_rule.threshold || '%).'
              );
            end if;
          else
            -- If compliance met, resolve any open violation
            update public.compliance_violations
            set status = 'resolved',
                resolved_at = now()
            where profile_id = v_member.id
              and rule_id = v_rule.id
              and status in ('open', 'acknowledged');
          end if;
        end if;

      -- ── 2. Overdue Tasks Rule Evaluation ──
      elsif v_rule.rule_type = 'overdue_tasks' then
        -- Count raw overdue events since the last time a violation of this rule was resolved
        select count(*)::integer
        into v_overdue_count
        from public.compliance_events
        where profile_id = v_member.id
          and event_type = 'task_overdue'
          and occurred_at > coalesce(
            (select max(resolved_at) from public.compliance_violations where profile_id = v_member.id and rule_id = v_rule.id and status = 'resolved'),
            '1970-01-01'::timestamptz
          );

        -- Also count current overdue assignments in the DB
        declare
          v_current_overdue integer;
        begin
          select count(*)::integer
          into v_current_overdue
          from public.task_assignments
          where member_id = v_member.id
            and status = 'overdue';

          if v_overdue_count >= v_rule.threshold then
            if not v_violation_exists then
              insert into public.compliance_violations (
                profile_id, company_id, rule_id, severity, status, details
              ) values (
                v_member.id, p_company_id, v_rule.id, v_rule.severity, 'open',
                'Member has accumulated ' || v_overdue_count || ' overdue task event(s), exceeding the threshold of ' || v_rule.threshold || '.'
              );
            elsif v_current_overdue < v_rule.threshold then
              update public.compliance_violations
              set status = 'resolved',
                  resolved_at = now()
              where profile_id = v_member.id
                and rule_id = v_rule.id
                and status in ('open', 'acknowledged');
            end if;
          else
            update public.compliance_violations
            set status = 'resolved',
                resolved_at = now()
            where profile_id = v_member.id
              and rule_id = v_rule.id
              and status in ('open', 'acknowledged');
          end if;
        end;

      -- ── 3. Inactive Days Rule Evaluation ──
      elsif v_rule.rule_type = 'inactive_days' then
        -- Calculate latest activity
        select coalesce(
          greatest(
            p.updated_at,
            (select max(joined_at) from public.meeting_sessions where profile_id = p.id),
            (select max(started_at) from public.task_assignments where member_id = p.id),
            (select max(submitted_at) from public.task_assignments where member_id = p.id),
            (select max(updated_at) from public.followups where member_id = p.id)
          ),
          p.created_at
        )
        into v_last_activity
        from public.profiles p
        where p.id = v_member.id;

        v_inactive_days := extract(day from now() - v_last_activity);

        if v_inactive_days >= v_rule.threshold then
          -- Log event if not logged today
          if not exists (
            select 1 from public.compliance_events
            where profile_id = v_member.id
              and event_type = 'inactive'
              and occurred_at >= date_trunc('day', now())
          ) then
            perform public.log_compliance_event(v_member.id, 'inactive', v_inactive_days::text, v_member.id);
          end if;

          if not v_violation_exists then
            insert into public.compliance_violations (
              profile_id, company_id, rule_id, severity, status, details
            ) values (
              v_member.id, p_company_id, v_rule.id, v_rule.severity, 'open',
              'Inactive for ' || v_inactive_days || ' day(s), exceeding the threshold of ' || v_rule.threshold || ' day(s).'
            );
          end if;
        else
          update public.compliance_violations
          set status = 'resolved',
              resolved_at = now()
          where profile_id = v_member.id
            and rule_id = v_rule.id
            and status in ('open', 'acknowledged');
        end if;

      -- ── 4. Open Follow-Ups Rule Evaluation ──
      elsif v_rule.rule_type = 'open_followups' then
        select count(*)::integer
        into v_followup_count
        from public.followups
        where member_id = v_member.id
          and status in ('open', 'in_progress');

        if v_followup_count >= v_rule.threshold then
          -- Log event if not logged today
          if not exists (
            select 1 from public.compliance_events
            where profile_id = v_member.id
              and event_type = 'followup_missed'
              and occurred_at >= date_trunc('day', now())
          ) then
            perform public.log_compliance_event(v_member.id, 'followup_missed', v_followup_count::text, v_member.id);
          end if;

          if not v_violation_exists then
            insert into public.compliance_violations (
              profile_id, company_id, rule_id, severity, status, details
            ) values (
              v_member.id, p_company_id, v_rule.id, v_rule.severity, 'open',
              'Member has ' || v_followup_count || ' open follow-up(s), exceeding the threshold of ' || v_rule.threshold || '.'
            );
          end if;
        else
          update public.compliance_violations
          set status = 'resolved',
              resolved_at = now()
          where profile_id = v_member.id
            and rule_id = v_rule.id
            and status in ('open', 'acknowledged');
        end if;

      end if;
    end loop;
    
    -- Evaluate member status based on open violations
    declare
      v_open_violations integer;
    begin
      select count(*)::integer into v_open_violations
      from public.compliance_violations
      where profile_id = v_member.id and status = 'open';
      
      if v_open_violations >= 4 then
        perform public.suspend_member(v_member.id);
      elsif v_open_violations >= 2 then
        perform public.warn_member(v_member.id);
      elsif v_open_violations = 0 then
        update public.profiles set status = 'active' where id = v_member.id and status in ('warned', 'suspended');
      end if;
    end;
    
  end loop;
end;
$$;


-- ============================================================================
-- Helper: acknowledge_violation (leader acknowledges a violation)
-- ============================================================================
create or replace function public.acknowledge_violation(
  p_violation_id uuid,
  p_leader_id uuid
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_violation record;
  v_leader record;
begin
  select * into v_violation
  from public.compliance_violations
  where id = p_violation_id
  for update;

  if not found then
    raise exception 'Violation not found';
  end if;

  select * into v_leader
  from public.profiles
  where id = p_leader_id;

  if not found or v_leader.role <> 'leader' then
    raise exception 'Only a leader can acknowledge violations';
  end if;

  if v_violation.company_id <> v_leader.company_id then
    raise exception 'Leader belongs to a different company';
  end if;

  if v_violation.status <> 'open' then
    raise exception 'Only open violations can be acknowledged (current status: %)', v_violation.status;
  end if;

  update public.compliance_violations
  set status = 'acknowledged',
      resolved_at = null
  where id = p_violation_id;
end;
$$;

-- ============================================================================
-- Helper: warn_member
-- ============================================================================
create or replace function public.warn_member(p_profile_id uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  update public.profiles
  set status = 'warned',
      warned_at = now()
  where id = p_profile_id and status not in ('warned', 'suspended', 'terminated');
end;
$$;

-- ============================================================================
-- Helper: suspend_member
-- ============================================================================
create or replace function public.suspend_member(p_profile_id uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  update public.profiles
  set status = 'suspended',
      suspended_at = now()
  where id = p_profile_id and status <> 'terminated';
end;
$$;

-- ============================================================================
-- Helper: terminate_member
-- ============================================================================
create or replace function public.terminate_member(p_profile_id uuid, p_leader_id uuid, p_reason text)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_profile record;
  v_company_id uuid;
  v_restructure_result jsonb;
begin
  select * into v_profile from public.profiles where id = p_profile_id;
  if not found then raise exception 'Profile not found'; end if;
  
  if v_profile.status = 'terminated' then raise exception 'Profile is already terminated'; end if;
  
  v_company_id := v_profile.company_id;
  
  -- 1. Update profile status
  update public.profiles
  set status = 'terminated',
      terminated_at = now()
  where id = p_profile_id;
  
  -- 2. Create termination log
  insert into public.termination_logs (profile_id, company_id, terminator_id, reason)
  values (p_profile_id, v_company_id, p_leader_id, p_reason);
  
  -- 3. Restructure tree
  v_restructure_result := public.restructure_network_tree(p_profile_id);
  
  -- 4. Cancel active tasks assigned to the terminated member
  update public.task_assignments
  set status = 'cancelled', updated_at = now()
  where member_id = p_profile_id and status in ('assigned', 'in_progress', 'overdue');
  
  insert into public.audit_logs (company_id, target_id, action, entity_type, after_data)
  select v_company_id, ta.id, 'cancelled_due_to_termination', 'task_assignment', jsonb_build_object('member_id', p_profile_id)
  from public.task_assignments ta
  where ta.member_id = p_profile_id and ta.status = 'cancelled' and ta.updated_at >= now() - interval '1 minute';
  
  -- 5. Reassign open followups to the parent leader
  update public.followups
  set leader_id = (v_restructure_result->>'new_parent_id')::uuid,
      updated_at = now()
  where member_id = p_profile_id and status in ('open', 'in_progress') and (v_restructure_result->>'new_parent_id') is not null;
  
  -- 6. Cancel future meetings hosted by this member
  update public.meetings
  set meeting_status = 'cancelled', updated_at = now()
  where leader_id = p_profile_id and meeting_status = 'scheduled';
  
  return v_restructure_result;
end;
$$;

-- ============================================================================
-- Helper: create_compliance_snapshot
-- ============================================================================
create or replace function public.create_compliance_snapshot(p_profile_id uuid)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_company_id uuid;
  v_attendance numeric;
  v_tasks numeric;
  v_followups numeric;
  v_compliance numeric;
  v_member_health numeric;
  v_team_health numeric;
  v_snapshot record;
  v_total_tasks int;
  v_completed_tasks int;
  v_open_followups int;
begin
  select company_id into v_company_id from public.profiles where id = p_profile_id;
  
  -- Get attendance score
  select coalesce(avg(attendance_percentage), 100.0) into v_attendance
  from public.meeting_attendances ma
  join public.meetings m on ma.meeting_id = m.id
  where ma.profile_id = p_profile_id and m.meeting_status = 'completed' and ma.attendance_status <> 'excused';
  
  -- Get task score
  select count(*)::int into v_total_tasks from public.task_assignments where member_id = p_profile_id;
  select count(*)::int into v_completed_tasks from public.task_assignments where member_id = p_profile_id and status = 'approved';
  if v_total_tasks > 0 then v_tasks := (v_completed_tasks::numeric / v_total_tasks::numeric) * 100.0; else v_tasks := 100.0; end if;
  
  -- Get followups score
  select count(*)::int into v_open_followups from public.followups where member_id = p_profile_id and status in ('open', 'in_progress');
  v_followups := greatest(0.0, 100.0 - (v_open_followups * 10.0));
  
  -- Calculate final scores
  v_compliance := (v_attendance * 0.50) + (v_tasks * 0.30) + (v_followups * 0.20);
  v_member_health := v_compliance;
  
  -- Team health score (average member health of downline)
  select avg(s.member_health_score) into v_team_health
  from public.get_descendants(p_profile_id) d
  join public.compliance_snapshots s on s.profile_id = d.profile_id
  where s.snapshot_date = current_date;
  
  insert into public.compliance_snapshots (
    profile_id, company_id, attendance_score, task_score, followup_score, compliance_score, member_health_score, team_health_score
  ) values (
    p_profile_id, v_company_id, v_attendance, v_tasks, v_followups, v_compliance, v_member_health, v_team_health
  )
  returning * into v_snapshot;
  
  return row_to_json(v_snapshot)::jsonb;
end;
$$;
