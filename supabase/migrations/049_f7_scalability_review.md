# Phase F7 Scalability Review
*Evaluation at 1,000 / 5,000 / 10,000 members*

---

## 1. Network Hierarchy Bottleneck (Critical)

### The Problem

Nearly every AI context RPC uses the ltree `<@` (ancestor-of) operator to scope a leader's downline:

```sql
WHERE n.path_ltree <@ (SELECT path_ltree FROM network_nodes WHERE profile_id = p_leader_id)
```

This pattern appears in:
- `get_ai_growth_opportunity_context()`
- `get_ai_promotion_advisor_context()`
- `get_ai_recognition_coach_context()`
- `get_ai_leadership_advisor_context()`
- `get_ai_retention_risk_context()`
- `resolve_member_reference()`

#### Performance Impact

| Members | Avg Tree Depth | Downline Scan Cost | Estimated RPC Time |
|---------|---------------|-------------------|-------------------|
| 1,000   | 4-5           | ~200 rows         | < 50ms ✅         |
| 5,000   | 6-8           | ~1,000 rows       | ~150ms ⚠️         |
| 10,000  | 8-12          | ~2,500 rows       | ~400ms+ ❌        |

The subquery `(SELECT path_ltree FROM network_nodes WHERE profile_id = p_leader_id)` runs once per RPC, but the ltree `<@` scan touches every node in the company since there is no company-scoped GIST index on `path_ltree`.

### Fix Applied in 047

```sql
CREATE INDEX IF NOT EXISTS network_nodes_path_gist_idx
  ON public.network_nodes USING gist (path_ltree);
```

> [!IMPORTANT]
> If this GIST index does not already exist from an earlier migration, it must be added. Verify in the existing schema. Without it, every `<@` query is a sequential scan at 10K members.

### Additional Recommendation

At 10K+ members, consider caching the leader's downline profile IDs in `mv_team_analytics` as a `uuid[]` array column. This avoids repeated ltree traversals across multiple RPC calls in the same AI conversation.

---

## 2. Materialized View Refresh Costs

### Refresh Time Estimates

| Materialized View          | 1K Members | 5K Members | 10K Members | Notes |
|---------------------------|-----------|-----------|------------|-------|
| `mv_member_analytics`      | ~2s       | ~8s       | ~20s       | 4 LEFT JOINs on operational tables |
| `mv_team_analytics`        | ~1s       | ~5s       | ~15s       | ltree `<@` join per leader |
| `mv_growth_analytics`      | ~1s       | ~3s       | ~8s        | 3× DISTINCT ON over snapshots |
| `mv_top_performers`        | ~0.5s     | ~2s       | ~5s        | Single DISTINCT ON + window |
| `mv_leadership_pipeline`   | ~0.5s     | ~1s       | ~3s        | Single DISTINCT ON |
| `mv_promotion_candidates`  | ~0.5s     | ~1s       | ~3s        | Joins across 3 MVs |

#### `mv_member_analytics` is the most expensive view.

At 10K members, the 4-way LEFT JOIN across `meeting_attendances`, `meetings`, `task_assignments`, and `followups` becomes the dominant cost. Each operational table could have 50K-200K rows.

### Fix Applied in 047

Added descending composite indexes on the snapshot tables:

```sql
CREATE INDEX member_perf_profile_date_desc_idx
  ON member_performance_snapshots (profile_id, snapshot_date DESC);

CREATE INDEX leadership_history_profile_week_desc_idx
  ON leadership_score_history (profile_id, week_start DESC);
```

These eliminate sequential scans for all `DISTINCT ON` queries used in `mv_growth_analytics` and `mv_leadership_pipeline`.

### Future Recommendation (10K+)

Partition `meeting_attendances` and `task_assignments` by month. This bounds the scan size for `mv_member_analytics` and dramatically reduces refresh time.

---

## 3. RPC Loop Bottlenecks

### `calculate_leadership_scores()`

This function iterates over every non-admin profile in a PL/pgSQL loop. Each iteration performs:
- A lookup in `mv_member_analytics`
- A lookup in `mv_growth_analytics`
- A lookup in `member_risk_scores`
- An UPSERT into `leadership_score_history`

| Members | Loop Iterations | Estimated Time |
|---------|----------------|---------------|
| 1,000   | ~1,000         | ~3s ✅        |
| 5,000   | ~5,000         | ~15s ⚠️       |
| 10,000  | ~10,000        | ~35s ❌       |

### Recommendation (5K+)

Replace the row-by-row PL/pgSQL loop with a single set-based `INSERT ... ON CONFLICT` statement that computes all scores in one query. This would reduce 10K iterations to a single SQL statement executing in ~2-5 seconds.

Example pattern:
```sql
INSERT INTO leadership_score_history (profile_id, company_id, week_start, ...)
SELECT p.id, p.company_id, v_week_start, ...calculated scores...
FROM profiles p
LEFT JOIN mv_member_analytics mva ON ...
LEFT JOIN mv_growth_analytics ga ON ...
LEFT JOIN member_risk_scores mrs ON ...
WHERE p.role != 'admin'
ON CONFLICT (profile_id, week_start) DO UPDATE SET ...;
```

### `calculate_milestones()` — Same Pattern

Same loop structure. Same recommendation: convert to set-based operations at 5K+.

---

## 4. Missing Indexes Identified

| Table | Missing Index | Used By | Impact |
|-------|-------------|---------|--------|
| `coach_insights` | `(profile_id, created_at DESC)` | Leadership Advisor, Recognition Coach context | Seq scan at 5K+ |
| `leadership_recommendations` | `(status, recommendation_type)` | Promotion Advisor context, generate_leadership_recommendations() | Seq scan at 5K+ |
| `recognitions` | `(profile_id, awarded_at DESC)` | Recognition Coach context | Seq scan at 5K+ |
| `member_performance_snapshots` | `(profile_id, snapshot_date DESC)` | mv_growth_analytics, mv_top_performers | Seq scan on DISTINCT ON at 5K+ |

### All fixes applied in 047_f7_hardening.sql. ✅

---

## 5. `mv_team_analytics` Quadratic Growth Risk

This MV performs a self-join on `network_nodes` via ltree. For each leader node, it finds all descendant nodes. In a company with 100 leaders and 10K members, this produces ~100 × avg_downline_size row comparisons.

| Leaders | Members | Rows Processed | Estimated Time |
|---------|---------|---------------|---------------|
| 50      | 1,000   | ~20K          | ~1s ✅        |
| 200     | 5,000   | ~250K         | ~8s ⚠️       |
| 500     | 10,000  | ~1.25M        | ~30s+ ❌      |

### Recommendation (10K+)

Filter `leader_nodes` CTE to only include profiles with `role = 'leader'` instead of scanning every `network_node`. This immediately reduces the outer loop by 80-90%.

---

## 6. Cron Job Timing at Scale

### Current Schedule (from 047)

```
01:00  mv_member_analytics       (~20s at 10K)
01:03  mv_team_analytics          (~30s at 10K)  ⚠️ may overlap
01:06  mv_meeting_analytics       (~5s)
01:09  mv_task_analytics           (~5s)
01:12  mv_growth_analytics        (~8s)
01:15  mv_top_performers          (~5s)
01:18  mv_leadership_pipeline     (~3s)
01:21  mv_promotion_candidates    (~3s)
```

### Risk

At 10K members, `mv_team_analytics` could take 30s, overlapping with `mv_meeting_analytics` at 01:06. This won't cause errors (pg_cron runs them independently), but it creates CPU pressure.

### Recommendation (10K+)

Increase spacing to 5-minute intervals, or dynamically stagger based on observed execution times:

```
01:00  mv_member_analytics
01:05  mv_team_analytics
01:10  mv_meeting_analytics
01:13  mv_task_analytics
01:16  mv_growth_analytics
01:19  mv_top_performers
01:22  mv_leadership_pipeline
01:25  mv_promotion_candidates
```

---

## Summary

| Issue | Severity at 1K | Severity at 5K | Severity at 10K | Fix Status |
|-------|:---:|:---:|:---:|:---:|
| ltree `<@` without GIST index | ✅ Low | ⚠️ Medium | ❌ High | ✅ 047 (verify existing GIST) |
| DISTINCT ON without desc index | ✅ Low | ⚠️ Medium | ❌ High | ✅ 047 |
| PL/pgSQL loops in score calc | ✅ Low | ⚠️ Medium | ❌ High | 📋 Future (set-based rewrite) |
| mv_team_analytics self-join | ✅ Low | ⚠️ Medium | ❌ High | 📋 Future (filter leaders) |
| Missing secondary indexes | ✅ Low | ⚠️ Medium | ❌ High | ✅ 047 |
| Cron overlap risk | ✅ None | ✅ Low | ⚠️ Medium | 📋 Monitor + widen spacing |

> [!TIP]
> At the current expected scale (1K-5K members), all fixes in 047 are sufficient for production. The set-based rewrite and mv_team_analytics leader filter should be prioritized when the platform approaches 10K members.
