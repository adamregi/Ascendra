# Architectural Decision History — Ascendra

> **Purpose**: A chronological log explaining the *why* behind core architectural decisions. AI agents must understand this history to avoid proposing solutions that have already been rejected.

---

## 1. Data Aggregation Strategy

- **Decision**: All complex data aggregation (Dashboards, KPIs) must happen on the Backend (PostgreSQL Materialized Views / RPCs) rather than in the Flutter Client.
- **Reason**: The Flutter app cannot download 10,000 tasks and 5,000 meetings to calculate a 7-day completion rate. It would destroy battery, memory, and bandwidth. The backend owns business logic.
- **Alternatives**: Client-side Dart calculations (Rejected due to OOM errors).
- **Status**: **Accepted** (See `docs/backend/adrs/003-rpc-dashboard.md`).
- **Related Modules**: `dashboard`, `members`, `compliance`.

## 2. Riverpod State Management

- **Decision**: Use `@riverpod` code generation for all providers and enforce `ref.cacheFor` with a TTL (e.g., 5 minutes) for network requests.
- **Reason**: Hand-written providers are prone to syntax errors and memory leaks. `ref.cacheFor` prevents the app from refetching data every time the user hits the "Back" button, vastly improving perceived performance.
- **Alternatives**: BLoC (Rejected for boilerplate), standard `Provider` (Rejected for lack of auto-dispose safety).
- **Status**: **Accepted**.
- **Related Modules**: All Flutter features.

## 3. Video Integration (100ms)

- **Decision**: Use 100ms for live video meetings, orchestrated via Supabase Edge Functions for token generation and room creation.
- **Reason**: WebRTC is incredibly difficult to scale. 100ms provides reliable Flutter SDKs and server-side webhooks. Edge Functions keep the API keys secure.
- **Alternatives**: Agora (Rejected due to pricing/developer experience), Jitsi (Rejected due to hosting complexity).
- **Status**: **Accepted** (See `docs/backend/adrs/004-100ms.md`).
- **Related Modules**: `meetings`.

## 4. Hierarchical Data (MLM Tree)

- **Decision**: Use PostgreSQL's `ltree` extension to model the MLM network.
- **Reason**: Traditional Adjacency Lists (`parent_id`) require complex recursive CTEs to calculate upline/downline data. `ltree` allows for extremely fast index-backed path querying (e.g., `path <@ '1.2'`).
- **Alternatives**: Adjacency List (Rejected for performance), Nested Sets (Rejected for slow writes).
- **Status**: **Accepted**.
- **Related Modules**: `members`, `compliance`.
