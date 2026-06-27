-- ============================================================================
-- 031_ai_context_logs.sql — AI context evidence + conversation upgrade
-- ============================================================================
-- The most important table in the AI architecture.
-- Every AI response gets a forensic log so we can debug:
--   Was retrieval wrong? Was context wrong? Was Gemini wrong?
--
-- Dependencies: 002_companies.sql, 003_profiles.sql, 026_ai.sql,
--               024_compliance_snapshots.sql
-- ============================================================================

-- ============================================================================
-- Step 1: Add updated_at to ai_conversations (missing from 026_ai.sql)
-- ============================================================================

alter table public.ai_conversations
  add column if not exists updated_at timestamptz not null default now();

-- Apply the existing set_updated_at() trigger
drop trigger if exists set_ai_conversations_updated_at on public.ai_conversations;
create trigger set_ai_conversations_updated_at
  before update on public.ai_conversations
  for each row execute function public.set_updated_at();

-- ============================================================================
-- Step 2: ai_context_logs — Forensic debugging table
-- ============================================================================

create table if not exists public.ai_context_logs (
  id                      uuid primary key default gen_random_uuid(),
  company_id              uuid not null references public.companies(id) on delete cascade,
  conversation_id         uuid not null references public.ai_conversations(id) on delete cascade,
  message_id              uuid references public.ai_messages(id) on delete set null,

  -- ── What the user asked ──────────────────────────────────────────────
  question                text not null check (char_length(trim(question)) > 0),

  -- ── Skill routing ────────────────────────────────────────────────────
  -- Which skill was selected by the server-side router
  skill                   text check (skill is null or skill in (
                            'team_performance', 'compliance_coach', 'meeting_coach',
                            'task_coach', 'member_success', 'knowledge_assistant',
                            'leadership_advisor', 'retention_risk', 'growth_opportunity'
                          )),
  -- How confident the router was in the skill selection (0.00 – 1.00)
  skill_confidence        numeric(3,2) check (
                            skill_confidence is null
                            or (skill_confidence >= 0 and skill_confidence <= 1)
                          ),

  -- ── RAG retrieval evidence ───────────────────────────────────────────
  -- Document IDs that contributed chunks (for "which responses used this doc?" queries)
  retrieved_document_ids  uuid[] not null default '{}',
  -- Full chunk content with metadata: [{chunk_text, document_id, document_title}]
  retrieved_chunks        jsonb not null default '[]'::jsonb
                          check (jsonb_typeof(retrieved_chunks) = 'array'),
  -- Per-chunk similarity scores: [{chunk_id, similarity}]
  retrieval_similarity    jsonb not null default '[]'::jsonb
                          check (jsonb_typeof(retrieval_similarity) = 'array'),
  -- Count of chunks retrieved (0 = RAG failed, 50 = retrieval exploded)
  retrieved_chunk_count   integer not null default 0
                          check (retrieved_chunk_count >= 0),

  -- ── Operational context snapshot ─────────────────────────────────────
  -- Structured snapshot of operational data collected for this question
  -- e.g. { team_health_score: 78, open_violations: 3, ... }
  context_snapshot        jsonb not null default '{}'::jsonb
                          check (jsonb_typeof(context_snapshot) = 'object'),
  -- Which data sources were queried and how many rows returned
  -- e.g. [{"source":"compliance_snapshots","rows":5}, {"source":"meeting_attendances","rows":22}]
  context_sources         jsonb not null default '[]'::jsonb
                          check (jsonb_typeof(context_sources) = 'array'),
  -- Link to the compliance snapshot used (if applicable)
  compliance_snapshot_id  uuid references public.compliance_snapshots(id) on delete set null,

  -- ── Prompt assembly ──────────────────────────────────────────────────
  -- The full system prompt sent to Gemini (for prompt debugging)
  system_prompt           text,
  -- SHA-256 hash of the full prompt for deduplication/comparison
  full_prompt_hash        text,

  -- ── Response ─────────────────────────────────────────────────────────
  -- What Gemini returned
  response                text not null check (char_length(trim(response)) > 0),
  -- Source citations attached to the response: [{type, title, id}]
  response_sources        jsonb not null default '[]'::jsonb
                          check (jsonb_typeof(response_sources) = 'array'),
  -- Model's self-reported confidence (0.00 – 1.00)
  confidence              numeric(3,2) check (
                            confidence is null
                            or (confidence >= 0 and confidence <= 1)
                          ),

  -- ── Pipeline metadata ────────────────────────────────────────────────
  -- Pipeline version tag: f0-rag, f1-context, f2-gemini, etc.
  ai_version              text not null default 'f0-rag'
                          check (char_length(trim(ai_version)) > 0),
  -- Total end-to-end latency in milliseconds
  total_latency_ms        integer check (total_latency_ms is null or total_latency_ms >= 0),

  created_at              timestamptz not null default now()
);

-- ============================================================================
-- Step 3: Indexes
-- ============================================================================

-- Company audit: "show me all AI interactions for this company"
create index if not exists ai_context_logs_company_created_idx
  on public.ai_context_logs (company_id, created_at desc);

-- Conversation replay: "show the full context trail for this conversation"
create index if not exists ai_context_logs_conversation_created_idx
  on public.ai_context_logs (conversation_id, created_at);

-- Skill analytics: "how often is each skill used?"
create index if not exists ai_context_logs_skill_created_idx
  on public.ai_context_logs (skill, created_at desc)
  where skill is not null;

-- Document traceability: "which AI responses used this document?"
create index if not exists ai_context_logs_retrieved_doc_ids_gin_idx
  on public.ai_context_logs using gin (retrieved_document_ids);

-- Context debugging: JSONB queries on operational data
create index if not exists ai_context_logs_context_snapshot_gin_idx
  on public.ai_context_logs using gin (context_snapshot jsonb_path_ops);

-- Version filtering: "show me all f0-rag responses vs f1-context responses"
create index if not exists ai_context_logs_ai_version_idx
  on public.ai_context_logs (ai_version, created_at desc);

-- FK indexes (PostgreSQL does NOT auto-index FKs)
create index if not exists ai_context_logs_conversation_id_idx
  on public.ai_context_logs (conversation_id);

create index if not exists ai_context_logs_message_id_idx
  on public.ai_context_logs (message_id);

create index if not exists ai_context_logs_compliance_snapshot_id_idx
  on public.ai_context_logs (compliance_snapshot_id)
  where compliance_snapshot_id is not null;

-- ============================================================================
-- Step 4: Row Level Security
-- ============================================================================

alter table public.ai_context_logs enable row level security;

-- Leaders can read all context logs in their company (for debugging AI behavior)
create policy "Leaders read company ai_context_logs"
  on public.ai_context_logs for select
  using (
    company_id = public.get_user_company_id()
    and exists (
      select 1 from public.profiles
      where auth_user_id = auth.uid()
        and role = 'leader'
        and company_id = public.ai_context_logs.company_id
    )
  );

-- Members can read context logs for their own conversations only
create policy "Members read own ai_context_logs"
  on public.ai_context_logs for select
  using (
    conversation_id in (
      select id from public.ai_conversations
      where profile_id = (
        select id from public.profiles
        where auth_user_id = auth.uid()
      )
    )
  );

-- Only service_role (edge functions) can insert context logs
-- No user-facing insert policy — inserts come from the ai-chat edge function
-- using supabaseAdmin (service_role key), which bypasses RLS.

-- ============================================================================
-- Step 5: Comments
-- ============================================================================

comment on table public.ai_context_logs is
  'Forensic debugging log for every AI response. Captures question, skill routing, '
  'retrieved chunks, operational context, assembled prompt, and response. '
  'Use this to diagnose: Was retrieval wrong? Was context wrong? Was Gemini wrong?';

comment on column public.ai_context_logs.skill is
  'Server-side auto-detected skill. Never trust the client for routing.';
comment on column public.ai_context_logs.skill_confidence is
  'Router confidence in skill selection (0.00–1.00). Useful for routing audits.';
comment on column public.ai_context_logs.retrieved_chunk_count is
  '0 = RAG failed to find anything. 50 = retrieval exploded. Quick diagnostic field.';
comment on column public.ai_context_logs.context_sources is
  'Array of {source, rows} objects showing which operational tables were queried. '
  'Enables "did we fail retrieval or context building?" debugging.';
comment on column public.ai_context_logs.ai_version is
  'Pipeline version tag (f0-rag, f1-context, f2-gemini). '
  'When responses change after an upgrade, this field tells you why.';
comment on column public.ai_context_logs.system_prompt is
  'The full system instruction sent to Gemini. Stored for prompt debugging.';
comment on column public.ai_context_logs.full_prompt_hash is
  'SHA-256 hash of the complete prompt. For deduplication and A/B comparison.';
comment on column public.ai_context_logs.confidence is
  'Model self-reported confidence (0.00–1.00). NULL if model did not report.';
comment on column public.ai_context_logs.context_snapshot is
  'Structured operational data collected for this question. '
  'e.g. {team_health_score: 78, open_violations: 3}. Populated in Phase F1+.';
