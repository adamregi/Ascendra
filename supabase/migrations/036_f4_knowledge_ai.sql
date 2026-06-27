-- ============================================================================
-- Phase F4: Knowledge Assistant & Hybrid Search
-- ============================================================================

-- 1. Alter documents
alter table public.documents
add column if not exists source_type text,
add column if not exists source_id uuid;

-- 2. Alter ai_recommendations
alter table public.ai_recommendations
add column if not exists recommendation_source text not null default 'system_rule' check (recommendation_source in ('system_rule', 'ai_generated', 'hybrid')),
add column if not exists source_reference jsonb;

-- 3. Alter document_chunks
alter table public.document_chunks
add column if not exists keyword_tsv tsvector generated always as (to_tsvector('english', chunk_text)) stored;

create index if not exists document_chunks_keyword_tsv_idx on public.document_chunks using gin(keyword_tsv);

-- 4. Update Triggers to populate source_type and source_id
-- We must drop and recreate the trigger functions from 028_helper_functions.sql

create or replace function public.sync_product_to_documents()
returns trigger
language plpgsql
security definer
as $$
declare
  v_owner_id uuid;
begin
  select id into v_owner_id from public.profiles where company_id = coalesce(new.company_id, old.company_id) and role in ('admin', 'leader') limit 1;
  
  if tg_op = 'INSERT' then
    insert into public.documents (
      company_id, uploaded_by, title, category, file_url, file_name, storage_path, mime_type, raw_text, source_type, source_id
    ) values (
      new.company_id, v_owner_id, new.name, 'product', 'virtual://product/' || new.id::text, new.name, 'virtual/product/' || new.id::text, 'text/markdown', '# ' || new.name || E'\n\n' || coalesce(new.description, '') || E'\n\nBenefits:\n' || coalesce(new.benefits, ''), 'product', new.id
    );
  elsif tg_op = 'UPDATE' then
    update public.documents
    set title = new.name, raw_text = '# ' || new.name || E'\n\n' || coalesce(new.description, '') || E'\n\nBenefits:\n' || coalesce(new.benefits, ''), file_name = new.name
    where storage_path = 'virtual/product/' || new.id::text;
  end if;
  return new;
end;
$$;

create or replace function public.sync_product_faq_to_documents()
returns trigger
language plpgsql
security definer
as $$
declare
  v_owner_id uuid;
  v_product_name text;
  v_company_id uuid;
begin
  select company_id, name into v_company_id, v_product_name from public.products where id = coalesce(new.product_id, old.product_id);
  select id into v_owner_id from public.profiles where company_id = v_company_id and role in ('admin', 'leader') limit 1;

  if tg_op = 'INSERT' then
    insert into public.documents (
      company_id, uploaded_by, title, category, file_url, file_name, storage_path, mime_type, raw_text, source_type, source_id
    ) values (
      v_company_id, v_owner_id, v_product_name || ' FAQ: ' || new.question, 'faq', 'virtual://faq/' || new.id::text, 'faq_' || new.id::text, 'virtual/faq/' || new.id::text, 'text/markdown', 'Q: ' || new.question || E'\n\nA: ' || new.answer, 'faq', new.id
    );
  elsif tg_op = 'UPDATE' then
    update public.documents
    set title = v_product_name || ' FAQ: ' || new.question, raw_text = 'Q: ' || new.question || E'\n\nA: ' || new.answer
    where storage_path = 'virtual/faq/' || new.id::text;
  end if;
  return new;
end;
$$;

create or replace function public.sync_success_story_to_documents()
returns trigger
language plpgsql
security definer
as $$
declare
  v_owner_id uuid;
begin
  select id into v_owner_id from public.profiles where company_id = coalesce(new.company_id, old.company_id) and role in ('admin', 'leader') limit 1;

  if tg_op = 'INSERT' then
    insert into public.documents (
      company_id, uploaded_by, title, category, file_url, file_name, storage_path, mime_type, raw_text, source_type, source_id
    ) values (
      new.company_id, v_owner_id, new.title, 'success_story', 'virtual://success_story/' || new.id::text, new.title, 'virtual/success_story/' || new.id::text, 'text/markdown', '# ' || new.title || E'\n\n' || coalesce(new.description, '') || E'\n\nWatch here: ' || coalesce(new.youtube_url, ''), 'success_story', new.id
    );
  elsif tg_op = 'UPDATE' then
    update public.documents
    set title = new.title, raw_text = '# ' || new.title || E'\n\n' || coalesce(new.description, '') || E'\n\nWatch here: ' || coalesce(new.youtube_url, ''), file_name = new.title
    where storage_path = 'virtual/success_story/' || new.id::text;
  end if;
  return new;
end;
$$;

-- 5. Backfill existing documents
update public.documents
set source_type = category,
    source_id = case 
      when storage_path like 'virtual/%' then (string_to_array(storage_path, '/'))[3]::uuid
      else null
    end
where category in ('product', 'faq', 'success_story') and source_id is null;

update public.documents
set source_type = 'document'
where source_type is null;

-- 6. Hybrid Search RPC
create or replace function public.search_knowledge_hybrid(
  p_company_id uuid,
  p_query text,
  p_embedding extensions.vector(768),
  p_match_count int
)
returns table (
  id uuid,
  document_id uuid,
  chunk_text text,
  vector_score float,
  fts_score float,
  combined_score float,
  title text,
  category text,
  source_type text,
  source_id uuid
)
language plpgsql
security definer
as $$
declare
  v_exact_match boolean := false;
  v_vector_weight float;
  v_keyword_weight float;
begin
  -- Dynamic Weighting
  select true into v_exact_match
  from public.documents
  where company_id = p_company_id
    and (title ilike '%' || p_query || '%' or p_query ilike '%' || title || '%')
  limit 1;

  if v_exact_match then
    v_vector_weight := 0.40;
    v_keyword_weight := 0.60;
  else
    v_vector_weight := 0.70;
    v_keyword_weight := 0.30;
  end if;

  return query
  with vector_search as (
    select c.id, c.document_id, c.chunk_text,
           (1 - (c.embedding <=> p_embedding))::float as vector_score
    from public.document_chunks c
    join public.documents d on d.id = c.document_id
    where d.company_id = p_company_id
    order by c.embedding <=> p_embedding
    limit p_match_count * 2
  ),
  fts_search as (
    select c.id, c.document_id, c.chunk_text,
           ts_rank(c.keyword_tsv, websearch_to_tsquery('english', p_query))::float as fts_score
    from public.document_chunks c
    join public.documents d on d.id = c.document_id
    where d.company_id = p_company_id
      and c.keyword_tsv @@ websearch_to_tsquery('english', p_query)
    order by fts_score desc
    limit p_match_count * 2
  ),
  merged as (
    select coalesce(v.id, f.id) as id,
           coalesce(v.document_id, f.document_id) as document_id,
           coalesce(v.chunk_text, f.chunk_text) as chunk_text,
           coalesce(v.vector_score, 0) as vector_score,
           coalesce(f.fts_score, 0) as fts_score
    from vector_search v
    full outer join fts_search f on v.id = f.id
  )
  select m.id, m.document_id, m.chunk_text,
         m.vector_score, m.fts_score,
         (m.vector_score * v_vector_weight + m.fts_score * v_keyword_weight) as combined_score,
         d.title, d.category, d.source_type, d.source_id
  from merged m
  join public.documents d on d.id = m.document_id
  order by combined_score desc
  limit p_match_count;

end;
$$;
