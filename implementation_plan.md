# Phase F1 — Skill Router & Context Builder (Final)

Phase F1 transforms Ascendra from a flat RAG chatbot into a skill-aware business intelligence assistant. Every question is classified, contextualized with operational data, and sent to Gemini with structured summaries — not raw database dumps.

---

## Proposed Changes

### 1. Database Migration

#### [NEW] [032_ai_skill_routes.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/032_ai_skill_routes.sql)

---

#### 1A. Upgrade `ai_context_logs`

Add latency breakdown columns and the `system_assistant` skill. Update the CHECK constraint.

```sql
-- Widen skill enum to include system_assistant
alter table public.ai_context_logs
  drop constraint if exists ai_context_logs_skill_check;

alter table public.ai_context_logs
  add constraint ai_context_logs_skill_check
  check (skill is null or skill in (
    'team_performance', 'compliance_coach', 'meeting_coach',
    'task_coach', 'member_success', 'knowledge_assistant',
    'leadership_advisor', 'retention_risk', 'growth_opportunity',
    'system_assistant'
  ));

-- Add granular latency + routing reason
alter table public.ai_context_logs
  add column if not exists routing_reason       text,
  add column if not exists retrieval_latency_ms integer
    check (retrieval_latency_ms is null or retrieval_latency_ms >= 0),
  add column if not exists context_latency_ms   integer
    check (context_latency_ms is null or context_latency_ms >= 0),
  add column if not exists gemini_latency_ms    integer
    check (gemini_latency_ms is null or gemini_latency_ms >= 0);
```

---

#### 1B. `ai_skill_patterns` — Company-Aware Weighted Patterns

```sql
create table if not exists public.ai_skill_patterns (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid references public.companies(id) on delete cascade,
    -- NULL = global pattern, UUID = company-specific override
  skill       text not null check (skill in (
                'team_performance', 'compliance_coach', 'meeting_coach',
                'task_coach', 'member_success', 'knowledge_assistant',
                'leadership_advisor', 'retention_risk', 'growth_opportunity',
                'system_assistant'
              )),
  pattern     text not null check (char_length(trim(pattern)) > 0),
  weight      integer not null default 1 check (weight > 0),
  created_at  timestamptz not null default now()
);

create index if not exists ai_skill_patterns_company_idx
  on public.ai_skill_patterns (company_id);
```

**Override precedence logic** (implemented in `route_skill`):

```
Company-specific patterns exist for this skill?
  → YES: Use ONLY company patterns for that skill
  → NO:  Use global patterns for that skill
```

This prevents scoring pollution where both global and company weights stack.

---

#### 1C. `context_cache` — With Normalized Question Hash

```sql
create table if not exists public.context_cache (
  profile_id     uuid not null references public.profiles(id) on delete cascade,
  skill          text not null check (skill in (
                   'team_performance', 'compliance_coach', 'meeting_coach',
                   'task_coach', 'member_success', 'knowledge_assistant',
                   'leadership_advisor', 'retention_risk', 'growth_opportunity',
                   'system_assistant'
                 )),
  question_hash  text not null check (char_length(question_hash) = 32),
  payload        jsonb not null default '{}'::jsonb,
  expires_at     timestamptz not null,
  created_at     timestamptz not null default now(),
  primary key (profile_id, skill, question_hash)
);

create index if not exists context_cache_expires_at_idx
  on public.context_cache (expires_at);
```

**Normalization before hashing** (implemented in Edge Function):

```
"Show my team performance?"
  → lowercase:          "show my team performance?"
  → trim:               "show my team performance?"
  → collapse spaces:    "show my team performance?"
  → strip punctuation:  "show my team performance"
  → MD5:                "a1b2c3..."
```

All of these produce the **same cache key**:

```
Show my team performance
show   my team performance
SHOW MY TEAM PERFORMANCE?
```

---

#### 1D. `ai_skill_routes` — Analytics With Alternatives

```sql
create table if not exists public.ai_skill_routes (
  id              uuid primary key default gen_random_uuid(),
  company_id      uuid not null references public.companies(id) on delete cascade,
  profile_id      uuid not null references public.profiles(id) on delete cascade,
  question        text not null check (char_length(trim(question)) > 0),
  skill           text not null check (skill in (
                    'team_performance', 'compliance_coach', 'meeting_coach',
                    'task_coach', 'member_success', 'knowledge_assistant',
                    'leadership_advisor', 'retention_risk', 'growth_opportunity',
                    'system_assistant'
                  )),
  confidence      numeric(3,2) not null check (confidence >= 0.00 and confidence <= 1.00),
  routing_reason  text,
  alternatives    text[] not null default '{}',
  needs_clarification boolean not null default false,
  created_at      timestamptz not null default now()
);

create index if not exists ai_skill_routes_company_created_idx
  on public.ai_skill_routes (company_id, created_at desc);

create index if not exists ai_skill_routes_skill_created_idx
  on public.ai_skill_routes (skill, created_at desc);
```

---

#### 1E. RLS, Grants, Comments

```sql
alter table public.ai_skill_patterns enable row level security;
alter table public.context_cache enable row level security;
alter table public.ai_skill_routes enable row level security;

-- Patterns are globally readable (admin editable via service_role)
create policy "Anyone read skill patterns"
  on public.ai_skill_patterns for select using (true);

-- Cache is service_role only (edge functions bypass RLS)
-- No user-facing policies needed

-- Skill routes: leaders see company, members see own
create policy "Leaders read company ai_skill_routes"
  on public.ai_skill_routes for select
  using (
    company_id = public.get_user_company_id()
    and exists (
      select 1 from public.profiles
      where auth_user_id = auth.uid()
        and role = 'leader'
        and company_id = public.ai_skill_routes.company_id
    )
  );

create policy "Members read own ai_skill_routes"
  on public.ai_skill_routes for select
  using (
    profile_id in (
      select id from public.profiles
      where auth_user_id = auth.uid()
    )
  );

grant select on public.ai_skill_patterns to authenticated;
grant select on public.ai_skill_routes to authenticated;

comment on table public.ai_skill_patterns is
  'Weighted keyword patterns for AI skill classification. NULL company_id = global. UUID = company override.';
comment on table public.context_cache is
  'Short-lived cache (5 min TTL) for context builder payloads. Key: profile + skill + normalized question hash.';
comment on table public.ai_skill_routes is
  'Analytics log for AI skill classification decisions. Stores alternatives and clarification flags.';
comment on column public.ai_context_logs.routing_reason is
  'Human-readable explanation of why the skill router selected this skill.';
comment on column public.ai_context_logs.retrieval_latency_ms is
  'Latency of RAG chunk retrieval in ms.';
comment on column public.ai_context_logs.context_latency_ms is
  'Latency of Context Builder data collection in ms.';
comment on column public.ai_context_logs.gemini_latency_ms is
  'Latency of Gemini content generation in ms.';
```

---

#### 1F. Seed Global Patterns

```sql
insert into public.ai_skill_patterns (company_id, skill, pattern, weight) values
  -- team_performance
  (null, 'team_performance', 'team.*performance', 10),
  (null, 'team_performance', 'performance.*team', 10),
  (null, 'team_performance', 'show.*team', 8),
  (null, 'team_performance', 'team summary', 5),
  (null, 'team_performance', 'who needs attention', 5),
  -- compliance_coach
  (null, 'compliance_coach', 'missed.*meeting', 10),
  (null, 'compliance_coach', 'meeting.*missed', 10),
  (null, 'compliance_coach', 'who missed', 10),
  (null, 'compliance_coach', 'who is missing.*meeting', 10),
  (null, 'compliance_coach', 'violation', 5),
  (null, 'compliance_coach', 'warned', 5),
  (null, 'compliance_coach', 'suspended', 5),
  (null, 'compliance_coach', 'terminated', 5),
  (null, 'compliance_coach', 'compliance', 5),
  -- meeting_coach
  (null, 'meeting_coach', 'attendance.*report', 8),
  (null, 'meeting_coach', 'meeting.*performance', 8),
  (null, 'meeting_coach', 'engagement.*report', 8),
  (null, 'meeting_coach', 'meeting', 3),
  (null, 'meeting_coach', 'attendance', 3),
  (null, 'meeting_coach', 'session', 2),
  (null, 'meeting_coach', 'duration', 2),
  -- task_coach
  (null, 'task_coach', 'task.*report', 8),
  (null, 'task_coach', 'overdue.*task', 8),
  (null, 'task_coach', 'assignment.*completion', 8),
  (null, 'task_coach', 'task', 3),
  (null, 'task_coach', 'assignment', 3),
  (null, 'task_coach', 'proof', 3),
  (null, 'task_coach', 'overdue', 3),
  (null, 'task_coach', 'productivity', 3),
  -- member_success
  (null, 'member_success', 'help.*member', 10),
  (null, 'member_success', 'how.*can.*help', 8),
  (null, 'member_success', 'struggling', 8),
  (null, 'member_success', 'improve.*member', 8),
  (null, 'member_success', 'what.*should.*improve', 5),
  -- knowledge_assistant
  (null, 'knowledge_assistant', 'compensation.*plan', 10),
  (null, 'knowledge_assistant', 'explain.*product', 10),
  (null, 'knowledge_assistant', 'document', 5),
  (null, 'knowledge_assistant', 'policy', 5),
  (null, 'knowledge_assistant', 'manual', 5),
  (null, 'knowledge_assistant', 'faq', 5),
  (null, 'knowledge_assistant', 'success.*stor', 5),
  -- leadership_advisor
  (null, 'leadership_advisor', 'improve.*leadership', 10),
  (null, 'leadership_advisor', 'leadership.*advice', 10),
  (null, 'leadership_advisor', 'how.*to.*lead', 10),
  (null, 'leadership_advisor', 'what.*focus.*on', 5),
  (null, 'leadership_advisor', 'weekly.*priorit', 5),
  (null, 'leadership_advisor', 'my.*priorit', 5),
  -- retention_risk
  (null, 'retention_risk', 'inactive', 10),
  (null, 'retention_risk', 'might.*quit', 10),
  (null, 'retention_risk', 'disengaged', 10),
  (null, 'retention_risk', 'retention', 10),
  (null, 'retention_risk', 'at.*risk', 8),
  (null, 'retention_risk', 'engagement.*drop', 8),
  -- growth_opportunity
  (null, 'growth_opportunity', 'who.*can.*become.*leader', 10),
  (null, 'growth_opportunity', 'growth.*opportunit', 10),
  (null, 'growth_opportunity', 'team.*expansion', 8),
  (null, 'growth_opportunity', 'who.*should.*promote', 8),
  (null, 'growth_opportunity', 'top.*performer', 5),
  (null, 'growth_opportunity', 'recruit', 5),
  -- system_assistant
  (null, 'system_assistant', 'how.*invite.*member', 10),
  (null, 'system_assistant', 'upgrade.*plan', 10),
  (null, 'system_assistant', 'where.*find.*recording', 10),
  (null, 'system_assistant', 'how.*do.*i', 5),
  (null, 'system_assistant', 'where.*can.*i', 5);
```

---

#### 1G. `route_skill` — Relative Confidence + Clarification Threshold

```sql
create or replace function public.route_skill(p_company_id uuid, p_question text)
returns json
language plpgsql
security definer
set search_path = public
as $$
declare
  v_question    text := lower(trim(p_question));
  v_skill       text;
  v_confidence  numeric(3,2);
  v_reason      text;
  v_alternatives text[] := '{}';
  v_top_score   numeric;
  v_second_score numeric;
  v_needs_clarification boolean := false;
begin
  -- ── Score matches using company-override precedence ──
  -- For each skill: if company-specific patterns exist, use ONLY those.
  -- Otherwise fall back to global (company_id IS NULL) patterns.
  with effective_patterns as (
    select sp.skill, sp.pattern, sp.weight
    from public.ai_skill_patterns sp
    where sp.company_id = p_company_id
      and v_question ~* sp.pattern

    union all

    select sp.skill, sp.pattern, sp.weight
    from public.ai_skill_patterns sp
    where sp.company_id is null
      and v_question ~* sp.pattern
      -- Exclude skills that have company-specific overrides
      and sp.skill not in (
        select distinct sp2.skill
        from public.ai_skill_patterns sp2
        where sp2.company_id = p_company_id
      )
  ),
  scored as (
    select
      ep.skill,
      sum(ep.weight) as total_score,
      string_agg(ep.pattern || ' (' || ep.weight || ')', ', ') as matched
    from effective_patterns ep
    group by ep.skill
  ),
  ranked as (
    select skill, total_score, matched,
      row_number() over (order by total_score desc, skill asc) as rn
    from scored
  )
  select skill, total_score, matched into v_skill, v_top_score, v_reason
  from ranked where rn = 1;

  -- Get second-highest score for relative confidence
  with effective_patterns as (
    select sp.skill, sp.pattern, sp.weight
    from public.ai_skill_patterns sp
    where sp.company_id = p_company_id
      and v_question ~* sp.pattern
    union all
    select sp.skill, sp.pattern, sp.weight
    from public.ai_skill_patterns sp
    where sp.company_id is null
      and v_question ~* sp.pattern
      and sp.skill not in (
        select distinct sp2.skill
        from public.ai_skill_patterns sp2
        where sp2.company_id = p_company_id
      )
  ),
  scored as (
    select ep.skill, sum(ep.weight) as total_score
    from effective_patterns ep
    group by ep.skill
  ),
  ranked as (
    select skill, total_score,
      row_number() over (order by total_score desc, skill asc) as rn
    from scored
  )
  select total_score into v_second_score
  from ranked where rn = 2;

  if v_skill is null then
    -- ── Safe default: knowledge_assistant ──
    v_skill := 'knowledge_assistant';
    v_confidence := 0.50;
    v_reason := 'No operational keywords matched. Defaulting to knowledge_assistant.';
  else
    -- ── Relative confidence: top / (top + second) ──
    v_second_score := coalesce(v_second_score, 0);
    v_confidence := least(0.99,
      (v_top_score / (v_top_score + v_second_score))::numeric(3,2)
    );
    v_reason := 'Matched: ' || v_reason;

    -- ── Clarification threshold: difference <= 2 ──
    if v_second_score > 0 and (v_top_score - v_second_score) <= 2 then
      v_needs_clarification := true;
    end if;

    -- ── Collect alternatives (top 2 runner-ups) ──
    with effective_patterns as (
      select sp.skill, sp.pattern, sp.weight
      from public.ai_skill_patterns sp
      where sp.company_id = p_company_id
        and v_question ~* sp.pattern
      union all
      select sp.skill, sp.pattern, sp.weight
      from public.ai_skill_patterns sp
      where sp.company_id is null
        and v_question ~* sp.pattern
        and sp.skill not in (
          select distinct sp2.skill
          from public.ai_skill_patterns sp2
          where sp2.company_id = p_company_id
        )
    ),
    scored as (
      select ep.skill, sum(ep.weight) as total_score
      from effective_patterns ep
      group by ep.skill
    )
    select array_agg(skill order by total_score desc, skill asc)
    into v_alternatives
    from (
      select skill, total_score from scored
      where skill != v_skill
      order by total_score desc, skill asc
      limit 2
    ) s;
  end if;

  if v_alternatives is null then
    v_alternatives := '{}';
  end if;

  return json_build_object(
    'skill', v_skill,
    'confidence', v_confidence,
    'routing_reason', v_reason,
    'alternatives', v_alternatives,
    'needs_clarification', v_needs_clarification
  );
end;
$$;
```

**Confidence formula explained:**

| Top Score | 2nd Score | Confidence | Meaning |
|-----------|-----------|------------|---------|
| 20 | 0 | 0.99 | Only one skill matched — very confident |
| 20 | 3 | 0.87 | Clear winner — confident |
| 15 | 14 | 0.52 | Nearly tied — low confidence |
| 10 | 10 | 0.50 | Dead tie — needs clarification |

**Clarification threshold:** When `top_score - second_score <= 2`, the function sets `needs_clarification = true`.

---

#### 1H. Cache Cleanup Function

```sql
create or replace function public.cleanup_expired_context_cache()
returns integer
language plpgsql
security definer
set search_path = public
as $$
declare
  v_deleted integer;
begin
  delete from public.context_cache
  where expires_at < now();

  get diagnostics v_deleted = row_count;
  return v_deleted;
end;
$$;

comment on function public.cleanup_expired_context_cache() is
  'Removes expired context cache entries. Run daily via pg_cron or scheduled edge function.';
```

---

### 2. Context Builder Edge Function

#### [NEW] [supabase/functions/context-builder/index.ts](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/functions/context-builder/index.ts)

Input:
```json
{
  "company_id": "...",
  "profile_id": "...",
  "skill": "team_performance",
  "question": "Show my team performance"
}
```

**Processing pipeline:**

1. **Normalize question** → lowercase, trim, collapse whitespace, strip punctuation → MD5 hash.
2. **Cache lookup** → Check `context_cache` by `(profile_id, skill, question_hash)`. If valid:
   ```json
   {
     "context": { ... },
     "sources": [ ... ],
     "metadata": {
       "generated_at": "2026-06-20T12:00:00Z",
       "cache_hit": true,
       "cache_age_seconds": 42
     }
   }
   ```
3. **Member name resolution** (for `member_success` and similar):
   - Exact match on `full_name` (case-insensitive)
   - Exact match on `distributor_id`
   - Fuzzy match (trigram similarity via `pg_trgm` if available)
   - If multiple candidates → `{ "needs_clarification": true, "candidates": [...] }`
4. **Skill-specific data collection** — fixed summary contracts per skill.
5. **Token budget enforcement** — Aggregate into summaries, limit raw lists to 10 items, hard cap at 16,000 chars.
6. **Cache upsert** — Write to `context_cache` with 5-minute TTL.
7. **Return** with freshness metadata (`generated_at`, `cache_hit: false`, `cache_age_seconds: 0`).

**Skill-Specific Summary Contracts:**

##### `team_performance`
```json
{
  "team_health_score": 82,
  "total_members": 25,
  "active_members": 22,
  "warned_members": 2,
  "suspended_members": 1,
  "attendance_rate": 91,
  "task_completion_rate": 87,
  "open_followups": 8,
  "members_needing_attention": 5,
  "top_performers": [
    { "name": "...", "health_score": 95 }
  ],
  "at_risk_members": [
    { "name": "...", "health_score": 42, "issues": ["low_attendance", "overdue_tasks"] }
  ]
}
```

##### `compliance_coach`
```json
{
  "total_rules": 4,
  "active_violations": 12,
  "open_violations": 8,
  "escalated_violations": 2,
  "active_warnings": 4,
  "suspended_members": 1,
  "violations_last_30_days": 12,
  "recent_violations": [
    { "member": "...", "rule": "...", "severity": "...", "status": "..." }
  ]
}
```

##### `meeting_coach`
```json
{
  "total_meetings_30d": 12,
  "attendance_rate": 88,
  "avg_duration_minutes": 42,
  "total_missed": 6,
  "late_joins": 3,
  "members_with_low_attendance": [
    { "name": "...", "attended": 4, "total": 12, "rate": 33 }
  ]
}
```

##### `task_coach`
```json
{
  "total_tasks": 42,
  "completed": 35,
  "overdue": 7,
  "completion_rate": 83,
  "pending_proofs": 3,
  "overdue_members": [
    { "name": "...", "overdue_count": 3, "oldest_due": "..." }
  ]
}
```

##### `member_success`
```json
{
  "member": { "name": "...", "status": "active", "role": "member" },
  "health_score": 68,
  "attendance_rate": 75,
  "task_completion_rate": 60,
  "open_warnings": 1,
  "recent_meetings_attended": 3,
  "recent_meetings_total": 8,
  "recent_tasks_completed": 4,
  "recent_tasks_assigned": 7,
  "followup_count": 2,
  "strengths": ["consistent_meeting_joiner"],
  "weaknesses": ["overdue_tasks", "declining_score"]
}
```

##### `knowledge_assistant`
RAG-driven — context builder returns minimal operational summary. The main retrieval happens in `ai-chat` via `match_document_chunks`.
```json
{
  "documents_available": 15,
  "products_available": 4,
  "faqs_available": 22,
  "success_stories_available": 6
}
```

##### `leadership_advisor`
Cross-domain aggregation:
```json
{
  "team_health_score": 78,
  "compliance_rate": 85,
  "attendance_rate": 88,
  "task_completion_rate": 82,
  "retention_risk_count": 3,
  "growth_candidates": 2,
  "biggest_bottleneck": "overdue_tasks",
  "biggest_opportunity": "3 members near promotion"
}
```

##### `retention_risk`
```json
{
  "high_risk_count": 3,
  "medium_risk_count": 5,
  "inactive_30d_count": 2,
  "declining_attendance_count": 4,
  "declining_task_count": 3,
  "warning_count": 4,
  "high_risk_members": [
    { "name": "...", "risk_factors": ["inactive_15d", "3_overdue_tasks", "warned"], "health_score": 35 }
  ]
}
```

##### `growth_opportunity`
```json
{
  "top_performer_count": 4,
  "promotion_ready_count": 2,
  "high_engagement_count": 6,
  "top_performers": [
    { "name": "...", "health_score": 95, "task_rate": 100, "attendance_rate": 100 }
  ],
  "promotion_candidates": [
    { "name": "...", "readiness_factors": ["consistent_performer", "high_engagement"] }
  ]
}
```

##### `system_assistant`
No operational context needed — pure platform navigation.
```json
{
  "user_role": "leader",
  "subscription_plan": "enterprise",
  "features_available": ["meetings", "tasks", "compliance", "knowledge_base"]
}
```

---

### 3. AI Chat Integration

#### [MODIFY] [ai-chat/index.ts](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/functions/ai-chat/index.ts)

Pipeline upgrade from `f0-rag` to `f1-context`:

```
Question
  ↓
route_skill(companyId, message)          ← SQL RPC
  ↓
Log to ai_skill_routes                   ← Analytics
  ↓
context-builder(companyId, profileId,    ← Edge Function
                skill, question)
  ↓
RAG retrieval (if knowledge_assistant)   ← match_document_chunks
  ↓
Assemble system prompt with:
  - Skill instructions from Skills.md
  - Structured context summary JSON
  - RAG chunks (if any)
  ↓
Gemini generateContent                   ← LLM
  ↓
Log to ai_context_logs with:
  - skill, skill_confidence, routing_reason
  - context_snapshot, context_sources
  - retrieval_latency_ms, context_latency_ms, gemini_latency_ms
  - ai_version = 'f1-context'
```

---

### 4. Integration Test

#### [NEW] [ai_skill_router_test.dart](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/test/integration/ai_skill_router_test.dart)

Validates the routing engine by calling the `route_skill` RPC directly:

| Question | Expected Skill | Min Confidence |
|----------|---------------|----------------|
| `"Who missed meetings?"` | `compliance_coach` | 0.70 |
| `"Show my team performance"` | `team_performance` | 0.70 |
| `"What is the compensation plan?"` | `knowledge_assistant` | 0.70 |
| `"Which members are inactive?"` | `retention_risk` | 0.70 |
| `"How do I improve leadership?"` | `leadership_advisor` | 0.70 |
| `"How do I invite a member?"` | `system_assistant` | 0.70 |
| `"What is the refund process?"` | `knowledge_assistant` | 0.50 (fallback) |

Also tests:
- `alternatives` array is populated when multiple skills match.
- `needs_clarification` is `true` when top two scores differ by ≤ 2.

---

### 5. Documentation Updates

#### [MODIFY] [database.md](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/database.md)
- Document `ai_skill_patterns`, `context_cache`, `ai_skill_routes` tables with schemas.
- Update `ai_context_logs` with new columns.

#### [MODIFY] [data-sources.md](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/Skills/AI_skills/references/data-sources.md)
- Add new AI infrastructure tables.

#### [MODIFY] [Skills.md](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/Skills/AI_skills/Skills.md)
- Add `system_assistant` as Skill 10.
- Mark `f1-context` version as active.

---

## Verification Plan

### Automated Tests
```bash
supabase functions serve
flutter test test/integration/ai_skill_router_test.dart
```

### Manual Verification
1. **Route RPC**: `select public.route_skill('<company_uuid>', 'Who missed meetings?')` — verify correct classification.
2. **Cache**: Send same question twice → second response should include `cache_hit: true`.
3. **Clarification**: Send ambiguous question matching two skills nearly equally → verify `needs_clarification: true`.
4. **Latencies**: Check `ai_context_logs` for non-null `retrieval_latency_ms`, `context_latency_ms`, `gemini_latency_ms`.
5. **Override**: Insert a company-specific pattern, verify it takes precedence over global.
6. **Cleanup**: Call `cleanup_expired_context_cache()` → verify expired rows are removed.
