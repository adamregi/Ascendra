# Architecture Decisions (ADRs) Index

> **Purpose**: A quick reference index for all Architecture Decision Records (ADRs) in the Ascendra project.
> **Full files are located in**: `docs/backend/adrs/`

---

## 001 - Row-Level Security
- **Status**: Accepted
- **Summary**: Use Supabase Row-Level Security (RLS) for all tenant isolation. Every policy MUST use `get_user_company_id()` to ensure data cannot cross company boundaries.
- **Related Features**: Database, Auth, Security

## 002 - ltree for Hierarchical Data
- **Status**: Accepted
- **Summary**: Use PostgreSQL's `ltree` extension for the MLM network hierarchy instead of adjacency lists (parent_id) or nested sets. This provides efficient path querying for upline/downline operations.
- **Related Features**: Members, Network Tree, Database

## 003 - RPC-Based Dashboard
- **Status**: Accepted
- **Summary**: All dashboard KPIs and analytics are computed via PostgreSQL RPCs and materialized views. The Flutter client only consumes pre-aggregated view models.
- **Related Features**: Dashboard, Analytics, Flutter Architecture

## 004 - 100ms for Video
- **Status**: Accepted
- **Summary**: Use the 100ms SDK for video conferencing rather than WebRTC directly. Handle room creation via Edge Functions and attendance via webhooks to NestJS.
- **Related Features**: Meetings, Edge Functions, NestJS

## 005 - Gemini RAG Architecture
- **Status**: Accepted
- **Summary**: Use Google Gemini as the LLM. Documents are chunked and stored in `pgvector`. Similarity searches happen in PostgreSQL, context is built in NestJS, and passed to Gemini.
- **Related Features**: AI Assistant, Knowledge Base

## 006 - BullMQ Event Bus
- **Status**: Accepted
- **Summary**: Use Upstash Redis + BullMQ for asynchronous domain events (e.g., `MeetingEnded`, `TaskCompleted`). NestJS workers consume these events to trigger side effects like compliance evaluation.
- **Related Features**: Background Jobs, NestJS, Architecture

## 007 - Materialized View Refresh Strategy
- **Status**: Accepted
- **Summary**: Materialized views for analytics are refreshed via NestJS workers listening to domain events, NOT via SQL triggers, to prevent database lock contention during heavy traffic.
- **Related Features**: Analytics, Database, Background Jobs

## 008 - Business Logic Boundaries
- **Status**: Accepted
- **Summary**: Atomic operations and data integrity stay in PostgreSQL (RPCs). Evolving business rules (compliance, AI orchestration) live in NestJS. UI rendering lives in Flutter.
- **Related Features**: Architecture, API Design
