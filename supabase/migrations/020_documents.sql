-- ============================================================================
-- 017_documents.sql — Documents, Products, FAQs, and Success Stories
-- ============================================================================
-- Stores files (and their text chunks/embeddings for AI RAG), products,
-- product Q&A/FAQs, and success stories.
--
-- Dependencies: 002_companies.sql, 003_profiles.sql

-- ============================================================================
-- Table: documents
-- ============================================================================
create table if not exists public.documents (
  id           uuid primary key default gen_random_uuid(),
  company_id   uuid not null references public.companies(id) on delete cascade,
  uploaded_by  uuid not null references public.profiles(id) on delete cascade,
  title        text not null check (char_length(trim(title)) > 0),
  category     text check (category is null or char_length(trim(category)) > 0),
  file_url     text not null check (char_length(trim(file_url)) > 0),
  file_name    text not null check (char_length(trim(file_name)) > 0),
  storage_path text not null check (char_length(trim(storage_path)) > 0),
  mime_type    text not null check (char_length(trim(mime_type)) > 0),
  raw_text     text check (raw_text is null or char_length(trim(raw_text)) > 0),
  created_at   timestamptz not null default now()
);

-- ============================================================================
-- Table: document_chunks (for RAG / vector similarity search)
-- ============================================================================
create table if not exists public.document_chunks (
  id          uuid primary key default gen_random_uuid(),
  document_id uuid not null references public.documents(id) on delete cascade,
  chunk_text  text not null check (char_length(trim(chunk_text)) > 0),
  embedding   extensions.vector(768)
);

-- ============================================================================
-- Table: products
-- ============================================================================
create table if not exists public.products (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text not null check (char_length(trim(name)) > 0),
  description text check (description is null or char_length(trim(description)) > 0),
  benefits    text check (benefits is null or char_length(trim(benefits)) > 0),
  created_at  timestamptz not null default now()
);

-- ============================================================================
-- Table: product_faqs
-- ============================================================================
create table if not exists public.product_faqs (
  id         uuid primary key default gen_random_uuid(),
  product_id uuid not null references public.products(id) on delete cascade,
  question   text not null check (char_length(trim(question)) > 0),
  answer     text not null check (char_length(trim(answer)) > 0),
  created_at timestamptz not null default now()
);

-- ============================================================================
-- Table: success_stories
-- ============================================================================
create table if not exists public.success_stories (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  title       text not null check (char_length(trim(title)) > 0),
  description text check (description is null or char_length(trim(description)) > 0),
  youtube_url text check (youtube_url is null or char_length(trim(youtube_url)) > 0),
  created_at  timestamptz not null default now()
);

-- ============================================================================
-- Indexes
-- ============================================================================

-- FK indexes: documents
create index if not exists documents_company_id_idx
  on public.documents (company_id);

create index if not exists documents_uploaded_by_idx
  on public.documents (uploaded_by);

-- FK index: document_chunks
create index if not exists document_chunks_document_id_idx
  on public.document_chunks (document_id);

-- HNSW/IVF index for pgvector search is skipped here since we do it inside helper functions / migrations after extensions are ready.
-- Simple gist or ivfflat index can be added if scale requires it.

-- FK index: products
create index if not exists products_company_id_idx
  on public.products (company_id);

-- FK index: product_faqs
create index if not exists product_faqs_product_id_idx
  on public.product_faqs (product_id);

-- FK index: success_stories
create index if not exists success_stories_company_id_idx
  on public.success_stories (company_id);

-- Enable RLS
alter table public.documents enable row level security;
alter table public.document_chunks enable row level security;
alter table public.products enable row level security;
alter table public.product_faqs enable row level security;
alter table public.success_stories enable row level security;

-- ============================================================================
-- Comments
-- ============================================================================

comment on table public.documents is
  'Knowledge base files and documents uploaded by leaders/admin.';
comment on table public.document_chunks is
  'Parsed text fragments and vector embeddings for AI semantic search.';
comment on table public.products is
  'Product catalog definitions managed by admin/leaders.';
comment on table public.product_faqs is
  'Frequently asked questions and answers for specific products.';
comment on table public.success_stories is
  'Success stories and testimonials, optionally linking to YouTube.';
