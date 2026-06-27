-- ============================================================================
-- 004_network_nodes.sql — Management hierarchy tree
-- ============================================================================
-- Adjacency list with materialized path for tree traversal.
-- Uses ltree extension for efficient ancestor/descendant queries.
-- parent_id = NULL means root node (company leader).
--
-- Design assumption: This tree represents the MANAGEMENT HIERARCHY
-- (who manages whom), not MLM genealogy (who recruited whom).
-- Tree restructuring on termination is the correct behavior for this model.
-- If the business later requires separate genealogy tracking,
-- a new table will be needed.
--
-- Dependencies: 001_extensions.sql, 002_companies.sql, 003_profiles.sql

create table if not exists public.network_nodes (
  id              uuid primary key default gen_random_uuid(),
  profile_id      uuid not null unique references public.profiles(id) on delete cascade,
  parent_id       uuid references public.network_nodes(profile_id) on delete set null,
  company_id      uuid not null references public.companies(id) on delete restrict,
  depth           integer not null default 0 check (depth >= 0),
  path            text not null check (char_length(trim(path)) > 0),
  path_ltree      extensions.ltree generated always as (replace(path, '-', '_')::extensions.ltree) stored,
  downline_count  integer not null default 0 check (downline_count >= 0),
  created_at      timestamptz not null default now(),
  updated_at      timestamptz not null default now(),
  -- Prevent self-referencing cycles (node cannot be its own parent)
  check (parent_id is null or parent_id <> profile_id)
);

-- ============================================================================
-- Indexes
-- ============================================================================

-- FK index: parent_id for tree traversal joins
create index if not exists network_nodes_parent_id_idx
  on public.network_nodes (parent_id);

-- FK index: company_id
create index if not exists network_nodes_company_id_idx
  on public.network_nodes (company_id);

-- GiST index on ltree for ancestor/descendant queries (@>, <@)
create index if not exists network_nodes_path_ltree_gist_idx
  on public.network_nodes using gist (path_ltree);

-- ============================================================================
-- RLS
-- ============================================================================

alter table public.network_nodes enable row level security;

-- ============================================================================
-- Comments
-- ============================================================================

comment on table public.network_nodes is
  'Management hierarchy tree using adjacency list + materialized path. NOT MLM genealogy.';
comment on column public.network_nodes.path is
  'Dot-separated UUID path from root to this node. E.g. "root-uuid.parent-uuid.this-uuid"';
comment on column public.network_nodes.path_ltree is
  'Auto-generated ltree column for efficient tree queries. Hyphens in UUIDs replaced with underscores.';
comment on column public.network_nodes.depth is
  'Distance from root node (root = 0).';
comment on column public.network_nodes.downline_count is
  'Total descendants (recursive). Updated by triggers/functions.';
comment on column public.network_nodes.parent_id is
  'References network_nodes(profile_id), not profiles(id). Ensures parent is in the tree.';

-- Why ON DELETE SET NULL for parent_id:
-- When a member is terminated, their children get reassigned
-- to the terminated member's parent via restructure_network_tree().
-- SET NULL prevents cascade from deleting the children.

-- Why ON DELETE RESTRICT for company_id:
-- profiles.company_id already uses RESTRICT, so company deletion is blocked.
-- Using RESTRICT here instead of CASCADE for consistency.
