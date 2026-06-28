# ADR 002: Hierarchical Management Tree Representation with `ltree`

## Status
Accepted

## Context
Ascendra needs to represent a management hierarchy tree that can scale to 100,000+ members. Common operations include:
- Finding all downline members under a leader (recursive descendants).
- Finding the upline path of a member to compute warnings and audit scores (recursive ancestors).
- Checking whether user A is in the downline of user B to enforce permissions.

Using an adjacency list (`parent_id`) with recursive Common Table Expressions (CTEs) requires multiple database page reads and joins, causing query performance to degrade as the tree grows deeper.

## Decision
We decided to use the PostgreSQL **`ltree`** extension to store materialized paths of tree nodes. 

1. **Path Materialization**: The hierarchical path from the root node to each member is stored as a string of dot-separated UUIDs.
2. **UUID Formatting Compatibility**: Since `ltree` labels only support alphanumeric characters and underscores, hyphens in UUIDs are replaced with underscores (e.g., `550e8400_e29b_41d4_a716_446655440000`).
3. **Generated Column**: The system automatically computes and stores the path as an `ltree` type:
   ```sql
   path_ltree extensions.ltree generated always as (replace(path, '-', '_')::extensions.ltree) stored;
   ```
4. **GiST Indexing**: A Generalized Search Tree (GiST) index is added to speed up hierarchical operations:
   ```sql
   create index network_nodes_path_ltree_gist_idx on public.network_nodes using gist (path_ltree);
   ```

## Consequences

### Positive Impacts
- **Sub-Millisecond Queries**: Finding recursive ancestors (`path_ltree @> target_path`) or descendants (`path_ltree <@ target_path`) runs in sub-millisecond execution times, even with deep hierarchies.
- **Simplified Permission Logic**: Checking if user A has permission to view user B's profile is reduced to a simple index-backed comparison.

### Trade-offs & Cons
- **Write Amplification**: When a node is moved (e.g., during tree restructuring after a member is terminated), the materialized path of that node and all its descendants must be updated, causing write amplification.
- **Formatting Overhead**: The application layer must convert UUIDs between hyphens and underscores when querying hierarchical paths.
- **Tree Locking**: Restructuring deep sub-trees can lock the `network_nodes` table, requiring these updates to run asynchronously during low-traffic periods.
