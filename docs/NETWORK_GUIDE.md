# Network Hierarchy Guide — Ascendra

> **Purpose**: Explanation of the `ltree` implementation for managing the MLM downline/upline structure.

---

## 1. Why ltree?

Network marketing organizations are deep trees. Querying "all descendants of Node X" in a standard adjacency list (`parent_id`) requires complex, slow recursive CTEs (Common Table Expressions). 

PostgreSQL's `ltree` extension stores the entire lineage path in a single column, allowing index-backed, instantaneous subtree queries.

## 2. The `network_nodes` Table

```sql
create table public.network_nodes (
  profile_id uuid primary key references public.profiles(id),
  company_id uuid not null references public.companies(id),
  sponsor_id uuid references public.profiles(id),
  path ltree not null,
  level integer not null
);
```

### Path Format
Paths are dot-separated strings representing the chain of command. In Ascendra, they use a sanitized version of the `profile_id` (UUIDs with dashes removed) or a sequence.
Example: `ROOT.D001.D005.D012`

## 3. Querying the Tree

All tree traversal MUST be done via the provided PostgreSQL helper functions, never in Flutter.

### Finding a Downline
```sql
-- "Find all nodes where the path contains this profile"
select * from network_nodes where path ~ '*.D005.*'
```
*(Handled by `get_descendants()` RPC)*

### Finding an Upline
```sql
-- "Find all ancestors of this specific path"
select * from network_nodes where path @> 'ROOT.D001.D005.D012'
```
*(Handled by `get_ancestors()` RPC)*

## 4. Restructuring (Changing Sponsors)

When a member is moved to a new sponsor, their `path` must change, AND the paths of their entire downline must be recalculated.

This is handled atomically by `restructure_network_tree()`.

**Critical Safety Rules:**
1. Flutter MUST never manually update a `path` or `sponsor_id`.
2. Restructuring uses row-level locks (`SELECT FOR UPDATE`) to prevent race conditions.
3. The RPC checks for circular loops (e.g., trying to move a sponsor under their own downline) before executing.
