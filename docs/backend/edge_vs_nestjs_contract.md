# Edge Functions vs. NestJS Architecture Contract

This document establishes the official architectural boundaries and design contracts between Supabase Edge Functions, NestJS Services, the PostgreSQL database, and the Flutter client.

---

## 1. Architectural Layers & Responsibilities

| Layer | Primary Responsibility | Execution Characteristics | Key Tech Stack |
|---|---|---|---|
| **PostgreSQL Database** | Data persistence, validation constraints, transactional integrity, multi-tenant isolation (RLS). | State-bound, persistent. | PostgreSQL, RLS, `ltree`, `pgvector` |
| **Supabase Edge Functions** | User-triggered thin API orchestration, low-latency gateways, third-party webhook receivers. | Stateless, serverless, scales-to-zero, auto-scaled. | TypeScript, Deno Runtime |
| **NestJS Services** | Async processing queues, heavy calculation loops, AI workflows, notifications routing, cron/jobs. | Stateful, persistent, high-throughput, horizontally scaled. | NestJS, Deno/Node, Upstash Redis, BullMQ |
| **Flutter Client** | User Interface rendering, input collection, session caching, optimistic state updates. | Client-bound, stateful. | Dart, Flutter, Riverpod |

---

## 2. Layer Integration Boundaries

```
[Flutter Client] ────(HTTP/WS)────► [Edge Functions]
       │                                  │
    (PostgREST CRUD)                 (Publish Event)
       │                                  │
       ▼                                  ▼
[PostgreSQL Database] ◄───(JDBC/RPC)─── [NestJS Workers]
```

### Rule 1: Write Path Routing
- **Use standard PostgREST (Supabase Client Direct CRUD)** for basic inserts, updates, and selects. The client operates directly against database tables protected by RLS (e.g., updating user avatars, fetching messages, marking notifications read).
- **Use Edge Functions** for actions that require a serverless gateway, external verification, or direct third-party service creation (e.g., scheduling a meeting, accepting an invitation via OTP).
- **Use NestJS APIs** for heavy processing (e.g., triggering a RAG session, evaluating compliance manually).

### Rule 2: Background Work Isolation
- No Supabase Edge Function should run loops, trigger cron tasks, or execute logic that takes longer than 15 seconds.
- All scheduled routines (daily compliance loops, weekly rule evaluation checks) must run as workers inside the NestJS app, managed via queues (BullMQ).

### Rule 3: Third-Party APIs
- **Edge Functions** act as thin webhook listeners for external events (e.g., 100ms webhook notifies when a video peer joins/leaves). They capture the raw event data, save it to the DB or write to the event bus, and exit immediately.
- **NestJS** orchestrates heavy API exchanges (e.g., communicating with the Gemini API, fetching transcription media files from 100ms, or calling bulk notification gateways).

---

## 3. Detailed Boundary Decisions

### Edge Functions
- **`create-company`**: Resolves DNS settings, triggers transactional insert, registers company, returns context.
- **`invite-member`**: Validates invite against subscription limit, registers pending invite, exits.
- **`accept-invitation`**: Links invited user profile with actual GoTrue user ID, triggers SMS verification.
- **`record-attendance`**: Handles incoming webhooks from 100ms. Parses connection events and records raw metrics.
- **`upload-document`**: Receives document streams and transfers payload directly to Supabase Storage.

### NestJS
- **`ai-chat`**: Feeds context, queries pgvector database chunks, calls Gemini model, runs formatting filters, logs forensic telemetry.
- **`context-builder`**: Fetches operational metrics and aggregates variables to serve prompt context.
- **`run-compliance-check`**: Validates attendance parameters and logs warning violations.
- **`notification-router`**: Audits recipient preferences and dispatches notifications via Twilio, SendGrid, or FCM.
- **`digest-generator`**: Daily cron task compiling executive dashboard summaries.
- **`analytics-dashboard`**: Runs heavy analytics refreshes on materialized views.
