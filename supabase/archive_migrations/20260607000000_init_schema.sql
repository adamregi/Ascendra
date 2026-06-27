-- Enable necessary extensions
create extension if not exists vector;

-- Create profiles table
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text not null,
  company_id uuid not null,
  role text not null check (role in ('leader', 'member')),
  status text not null default 'active' check (status in ('active', 'warned', 'terminated')),
  warned_at timestamptz,
  terminated_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Create invitations table
create table if not exists public.invitations (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null,
  leader_id uuid references public.profiles(id) on delete cascade,
  email text not null,
  token text not null unique,
  expires_at timestamptz not null,
  status text not null default 'pending' check (status in ('pending', 'accepted', 'expired'))
);

-- Create network_nodes table
create table if not exists public.network_nodes (
  profile_id uuid primary key references public.profiles(id) on delete cascade,
  parent_id uuid references public.profiles(id) on delete set null,
  path text not null,
  children_count integer not null default 0,
  member_count integer not null default 0
);

-- Create meetings table
create table if not exists public.meetings (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null,
  host_id uuid not null references public.profiles(id) on delete cascade,
  title text not null,
  scheduled_at timestamptz not null,
  room_id text not null,
  created_at timestamptz not null default now()
);

-- Create meeting_attendances table
create table if not exists public.meeting_attendances (
  id uuid primary key default gen_random_uuid(),
  meeting_id uuid not null references public.meetings(id) on delete cascade,
  profile_id uuid not null references public.profiles(id) on delete cascade,
  joined_at timestamptz not null,
  left_at timestamptz,
  duration_seconds integer,
  created_at timestamptz not null default now(),
  unique (meeting_id, profile_id, joined_at)
);

-- Create compliance_rules table
create table if not exists public.compliance_rules (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null unique, -- one compliance rule per company
  min_attendance_duration_minutes integer not null default 30,
  min_attendance_count_per_month integer not null default 4,
  grace_period_days integer not null default 7,
  created_at timestamptz not null default now()
);

-- Create termination_logs table
create table if not exists public.termination_logs (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles(id) on delete cascade,
  terminated_at timestamptz not null default now(),
  reason text not null,
  parent_reassigned_to uuid references public.profiles(id),
  restructured_at timestamptz
);

-- Create documents table
create table if not exists public.documents (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null,
  uploaded_by uuid not null references public.profiles(id) on delete cascade,
  file_name text not null,
  storage_path text not null,
  mime_type text not null,
  raw_text text,
  created_at timestamptz not null default now()
);

-- Create document_chunks table
create table if not exists public.document_chunks (
  id uuid primary key default gen_random_uuid(),
  document_id uuid not null references public.documents(id) on delete cascade,
  chunk_text text not null,
  embedding vector(768)
);

-- Create AI conversations table
create table if not exists public.ai_conversations (
  id uuid primary key default gen_random_uuid(),
  company_id uuid not null,
  profile_id uuid not null references public.profiles(id) on delete cascade,
  title text,
  created_at timestamptz not null default now()
);

-- Create AI messages table
create table if not exists public.ai_messages (
  id uuid primary key default gen_random_uuid(),
  conversation_id uuid not null references public.ai_conversations(id) on delete cascade,
  role text not null check (role in ('user', 'model', 'system', 'assistant')),
  content text not null,
  created_at timestamptz not null default now()
);

-- Indexes for performance
create index if not exists document_chunks_document_id_idx on public.document_chunks(document_id);
create index if not exists network_nodes_parent_id_idx on public.network_nodes(parent_id);
create index if not exists invitations_token_idx on public.invitations(token);
create index if not exists profiles_company_id_idx on public.profiles(company_id);

-- Create match_document_chunks helper function for vector search
create or replace function public.match_document_chunks (
  query_embedding vector(768),
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

-- Enable Row Level Security (RLS) on all tables
alter table public.profiles enable row level security;
alter table public.invitations enable row level security;
alter table public.network_nodes enable row level security;
alter table public.meetings enable row level security;
alter table public.meeting_attendances enable row level security;
alter table public.compliance_rules enable row level security;
alter table public.termination_logs enable row level security;
alter table public.documents enable row level security;
alter table public.document_chunks enable row level security;
alter table public.ai_conversations enable row level security;
alter table public.ai_messages enable row level security;

-- Basic Select Policies for Authenticated Users (writes are restricted to edge functions running as service_role)
create policy "Allow select profiles" on public.profiles for select using (auth.role() = 'authenticated');
create policy "Allow select invitations" on public.invitations for select using (auth.role() = 'authenticated');
create policy "Allow select network_nodes" on public.network_nodes for select using (auth.role() = 'authenticated');
create policy "Allow select meetings" on public.meetings for select using (auth.role() = 'authenticated');
create policy "Allow select meeting_attendances" on public.meeting_attendances for select using (auth.role() = 'authenticated');
create policy "Allow select compliance_rules" on public.compliance_rules for select using (auth.role() = 'authenticated');
create policy "Allow select termination_logs" on public.termination_logs for select using (auth.role() = 'authenticated');
create policy "Allow select documents" on public.documents for select using (auth.role() = 'authenticated');
create policy "Allow select document_chunks" on public.document_chunks for select using (auth.role() = 'authenticated');
create policy "Allow select ai_conversations" on public.ai_conversations for select using (auth.role() = 'authenticated');
create policy "Allow select ai_messages" on public.ai_messages for select using (auth.role() = 'authenticated');
