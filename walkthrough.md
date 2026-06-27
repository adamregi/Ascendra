# Phase F0 — AI Data Architecture Walkthrough

## Summary

Phase F0 adds the **AI forensic debugging layer** — the `ai_context_logs` table and enhanced `ai-chat` edge function that captures full evidence chains for every AI interaction. This is the foundation that makes the entire AI pipeline (Phases F1–F4) debuggable and auditable.

---

## Changes Made

### 1. New Migration: `031_ai_context_logs.sql`

[031_ai_context_logs.sql](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/migrations/031_ai_context_logs.sql) — **~160 lines of SQL**

#### New Table: `ai_context_logs`

The most important table in the AI architecture. Every AI response gets a forensic log.

| Column Group | Columns | Purpose |
|-------------|---------|---------|
| **Question** | `question` | What the user asked |
| **Skill Routing** | `skill`, `skill_confidence` | Server-side auto-detected skill + confidence (0.00–1.00) |
| **RAG Evidence** | `retrieved_document_ids`, `retrieved_chunks`, `retrieval_similarity`, `retrieved_chunk_count` | Full retrieval audit. 0 chunks = failed. 50 = exploded. |
| **Context** | `context_snapshot`, `context_sources`, `compliance_snapshot_id` | Operational data collected. `context_sources` logs which tables and row counts. |
| **Prompt** | `system_prompt`, `full_prompt_hash` | The assembled prompt sent to Gemini + SHA-256 hash for comparison |
| **Response** | `response`, `response_sources`, `confidence` | What Gemini returned, source citations, model confidence |
| **Pipeline** | `ai_version`, `total_latency_ms` | Version tag (`f0-rag`) + end-to-end latency |

#### Schema Alteration: `ai_conversations`

Added `updated_at` column with `set_updated_at()` trigger — the conversation timestamp now updates on every new message.

#### Indexes (9 new)

| Index | Purpose |
|-------|---------|
| `(company_id, created_at desc)` | Company audit queries |
| `(conversation_id, created_at)` | Conversation replay |
| `(skill, created_at desc)` | Skill usage analytics |
| GIN on `retrieved_document_ids` | "Which responses used this document?" |
| GIN on `context_snapshot` | JSONB queries on operational data |
| `(ai_version, created_at desc)` | Compare pipeline versions |
| `(conversation_id)` | FK index |
| `(message_id)` | FK index |
| `(compliance_snapshot_id)` | FK index (partial) |

#### RLS Policies (2 new)

| Policy | Scope |
|--------|-------|
| `Leaders read company ai_context_logs` | Leaders see all context logs in their company |
| `Members read own ai_context_logs` | Members see only their own conversation logs |

Inserts are service_role only (edge function uses `supabaseAdmin`).

---

### 2. Edge Function Rewrite: `ai-chat/index.ts`

[ai-chat/index.ts](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/supabase/functions/ai-chat/index.ts) — **5 key changes**

#### Fix: Role Normalization

**Before:** Inserted `role: "model"` into `ai_messages` — violated the CHECK constraint `('user', 'assistant', 'system')`.

**After:** `normalizeRole()` function maps Gemini's `"model"` → `"assistant"`. All providers (Gemini, OpenAI, Claude) standardize to `user/assistant/system`.

#### New: Context Logging

Every AI response (success **and** failure) now inserts a forensic record into `ai_context_logs` with:
- Retrieved document IDs and chunk similarity scores
- Context sources (which tables, how many rows)
- Full system prompt + SHA-256 hash
- Response text
- Pipeline version (`f0-rag`)
- End-to-end latency

#### New: Auto-Generated Titles

**Before:** `title = message.substring(0, 40) + "..."` — raw truncation.

**After:** `generateTitle()` — trims whitespace, capitalizes first letter, truncates to 60 chars with ellipsis. Produces cleaner conversation list entries.

#### New: Conversation `updated_at`

Every message exchange now updates `ai_conversations.updated_at` so the conversation list can sort by most recent activity.

#### New: AI Version Tagging

`AI_VERSION = "f0-rag"` constant is logged in both `ai_usage_logs.metadata` and `ai_context_logs.ai_version`. When the pipeline upgrades to F1/F2, changing this constant immediately segments the data.

---

### 3. Documentation Updates

#### [database.md](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/database.md)
- Added `AI_CONTEXT_LOGS` to the ERD (linked from `AI_CONVERSATIONS` and `COMPLIANCE_SNAPSHOTS`)
- Added `031_ai_context_logs.sql` to migration dependency order
- Added `updated_at` to `ai_conversations` table definition
- Added full `ai_context_logs` table definition with debuggability guide

#### [data-sources.md](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/Skills/AI_skills/references/data-sources.md)
- Added AI Infrastructure section documenting all 4 AI tables
- Added `AI Debugging` row to the Key Fields table

#### [Skills.md](file:///c:/Users/vigne/StudioProjects/Production_app/distributor_os/Skills/AI_skills/Skills.md)
- Added Phase F AI Architecture section with 4-layer pipeline diagram
- Added Skill ↔ `ai_context_logs.skill` mapping table
- Added Pipeline Version Tags table (`f0-rag` through `f4-knowledge`)
- Added Activation Roadmap (F0→F4)

---

## Complete AI Table Inventory (Post-F0)

| Table | Purpose | Phase Added |
|-------|---------|-------------|
| `ai_conversations` | Chat sessions per user | Phase E |
| `ai_messages` | Chat history (user/assistant/system) | Phase E |
| `ai_usage_logs` | Token counts, cost, latency | Phase E |
| `ai_context_logs` | **Forensic debugging** — retrieval, context, prompt, response evidence | **Phase F0** |

---

## What F0 Enables

```
Phase F0 (done)     → Every AI response is auditable
Phase F1 (next)     → Skill Router: route_skill(question) → {skill, confidence}
Phase F2            → Prompt Builder: skill-aware prompting + Response Processor
Phase F3            → Team Performance AI: Skills 1+2 live
Phase F4            → Knowledge Assistant AI: Skill 6 live
```

---

## Verification Steps

```bash
# 1. Reset local Supabase with all migrations
supabase db reset

# 2. Verify migration applied cleanly
supabase db diff

# 3. Serve edge functions
supabase functions serve
```

### Manual Tests

1. **Schema**: Open Supabase Studio → verify `ai_context_logs` table exists with all 21 columns
2. **updated_at**: Update an `ai_conversations` row → verify `updated_at` auto-updates
3. **AI Chat**: Send a message via `ai-chat` endpoint → verify:
   - `ai_context_logs` row created with retrieved chunks, prompt hash, response
   - `ai_messages.role` is `'assistant'` (not `'model'`)
   - `ai_conversations.updated_at` changed
   - `ai_usage_logs.metadata.ai_version` = `'f0-rag'`
4. **RLS**: Connect as member User A → verify cannot see User B's context logs
5. **Failed request**: Trigger a Gemini error → verify context log created with `[FAILED]` prefix in response
