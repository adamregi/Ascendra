-- ============================================================================
-- 018_ai.sql — AI conversations, messages, and usage logs
-- ============================================================================
-- Stores chatbot threads, message histories, and audits API tokens/costs.
--
-- Dependencies: 002_companies.sql, 003_profiles.sql

-- ============================================================================
-- Table: ai_conversations
-- ============================================================================
create table if not exists public.ai_conversations (
  id         uuid primary key default gen_random_uuid(),
  company_id uuid not null references public.companies(id) on delete cascade,
  profile_id uuid not null references public.profiles(id) on delete cascade,
  title      text check (title is null or char_length(trim(title)) > 0),
  created_at timestamptz not null default now()
);

-- ============================================================================
-- Table: ai_messages
-- ============================================================================
create table if not exists public.ai_messages (
  id              uuid primary key default gen_random_uuid(),
  conversation_id uuid not null references public.ai_conversations(id) on delete cascade,
  role            text not null check (role in ('user', 'assistant', 'system')),
  content         text not null check (char_length(trim(content)) > 0),
  created_at      timestamptz not null default now()
);

-- ============================================================================
-- Table: ai_usage_logs (cost and rate-limiting audit trail)
-- ============================================================================
create table if not exists public.ai_usage_logs (
  id                uuid primary key default gen_random_uuid(),
  company_id        uuid not null references public.companies(id) on delete cascade,
  profile_id        uuid not null references public.profiles(id) on delete cascade,
  conversation_id   uuid references public.ai_conversations(id) on delete set null,
  message_id        uuid references public.ai_messages(id) on delete set null,
  provider          text not null default 'gemini' check (char_length(trim(provider)) > 0),
  model             text not null check (char_length(trim(model)) > 0),
  operation         text not null default 'rag_chat' check (char_length(trim(operation)) > 0),
  prompt_tokens     integer not null default 0 check (prompt_tokens >= 0),
  completion_tokens integer not null default 0 check (completion_tokens >= 0),
  total_tokens      integer not null default 0 check (total_tokens >= 0),
  latency_ms        integer check (latency_ms is null or latency_ms >= 0),
  cost_usd          numeric(12, 6) check (cost_usd is null or cost_usd >= 0),
  created_at        timestamptz not null default now(),
  metadata          jsonb not null default '{}'::jsonb
                    check (jsonb_typeof(metadata) = 'object')
);

-- ============================================================================
-- Indexes
-- ============================================================================

-- FK indexes: ai_conversations
create index if not exists ai_conversations_company_id_idx
  on public.ai_conversations (company_id);

create index if not exists ai_conversations_profile_id_idx
  on public.ai_conversations (profile_id);

-- FK & timeline index: ai_messages
create index if not exists ai_messages_conversation_created_idx
  on public.ai_messages (conversation_id, created_at);

-- FK & audit indexes: ai_usage_logs
create index if not exists ai_usage_logs_company_created_idx
  on public.ai_usage_logs (company_id, created_at desc);

create index if not exists ai_usage_logs_profile_created_idx
  on public.ai_usage_logs (profile_id, created_at desc);

create index if not exists ai_usage_logs_conversation_id_idx
  on public.ai_usage_logs (conversation_id);

create index if not exists ai_usage_logs_message_id_idx
  on public.ai_usage_logs (message_id);

-- Enable RLS
alter table public.ai_conversations enable row level security;
alter table public.ai_messages enable row level security;
alter table public.ai_usage_logs enable row level security;

-- ============================================================================
-- Comments
-- ============================================================================

comment on table public.ai_conversations is
  'RAG chatbot conversation sessions per user.';
comment on table public.ai_messages is
  'Chat history records linked to conversation sessions.';
comment on table public.ai_usage_logs is
  'Usage and token logs for billing, analytics, and rate-limiting.';
