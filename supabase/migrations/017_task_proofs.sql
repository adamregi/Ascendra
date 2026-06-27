-- ============================================================================
-- 017_task_proofs.sql — Evidence of task completion
-- ============================================================================
-- Stores evidence submitted by members to back up their task completion claims.
--
-- Dependencies: 016_task_assignments.sql

create table if not exists public.task_proofs (
  id            uuid primary key default gen_random_uuid(),
  assignment_id uuid not null references public.task_assignments(id) on delete cascade,
  proof_type    text not null
                check (proof_type in ('photo', 'pdf', 'document', 'video', 'text')),
  comment       text check (comment is null or char_length(trim(comment)) > 0),
  file_url      text check (file_url is null or char_length(trim(file_url)) > 0),
  submitted_at  timestamptz not null default now()
);

-- ============================================================================
-- Indexes
-- ============================================================================

-- FK index: assignment_id
create index if not exists task_proofs_assignment_id_idx
  on public.task_proofs (assignment_id);

-- Enable RLS
alter table public.task_proofs enable row level security;

-- ============================================================================
-- Comments
-- ============================================================================

comment on table public.task_proofs is
  'Evidence of task completion submitted by assigned members.';
comment on column public.task_proofs.proof_type is
  'Type of evidence: photo, pdf, document, video, or text.';
comment on column public.task_proofs.comment is
  'Short description or note provided by the member when submitting proof.';
