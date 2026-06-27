-- ============================================================================
-- 016_task_assignments.sql — Task assignments to members
-- ============================================================================
-- Tracks progress and workflow status of task definitions assigned to members.
--
-- Dependencies: 003_profiles.sql, 015_tasks.sql

create table if not exists public.task_assignments (
  id             uuid primary key default gen_random_uuid(),
  task_id        uuid not null references public.tasks(id) on delete cascade,
  member_id      uuid not null references public.profiles(id) on delete cascade,
  assigned_at    timestamptz not null default now(),
  started_at     timestamptz,
  submitted_at   timestamptz,
  reviewed_at    timestamptz,
  status         text not null default 'assigned'
                 check (status in ('assigned', 'in_progress', 'submitted', 'approved', 'rejected', 'overdue', 'cancelled')),
  review_comment text,
  created_at     timestamptz not null default now(),
  updated_at     timestamptz not null default now(),
  -- Prevent duplicate assignments of the same task to a member
  constraint task_assignments_unique unique (task_id, member_id)
);

-- ============================================================================
-- Indexes
-- ============================================================================

-- FK index: task_id
create index if not exists task_assignments_task_id_idx
  on public.task_assignments (task_id);

-- FK index: member_id
create index if not exists task_assignments_member_id_idx
  on public.task_assignments (member_id);

-- Dashboard query: member assignments filtered by status
create index if not exists task_assignments_member_status_idx
  on public.task_assignments (member_id, status);

-- Enable RLS
alter table public.task_assignments enable row level security;

-- ============================================================================
-- Comments
-- ============================================================================

comment on table public.task_assignments is
  'Task assignments tracking individual workflow progress for each assigned member.';
comment on column public.task_assignments.status is
  'Assignment states: assigned → (started_at) in_progress → (submitted_at) submitted → (reviewed_at) approved | rejected. Or overdue if due date missed.';
comment on column public.task_assignments.started_at is
  'Timestamp when the member first opened/started the task.';
comment on column public.task_assignments.review_comment is
  'Feedback comment provided by the reviewing leader upon approval or rejection.';
