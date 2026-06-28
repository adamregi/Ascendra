# Project Health Dashboard — Ascendra

> **Purpose**: A living dashboard tracking the overall health, stability, and completion status of the Ascendra project. AI agents should update this file after running analysis or test commands.

---

## 1. Automated Health Metrics

*Note: These values should be updated automatically by AI agents after running the respective commands.*

| Metric | Status | Last Checked | Notes |
|--------|--------|--------------|-------|
| **Flutter Analyzer** | 0 Issues | 2026-06-28 | `flutter analyze` |
| **Riverpod Lint** | 0 Issues | 2026-06-28 | `dart run custom_lint` |
| **Test Pass Rate** | 100% | 2026-06-28 | `flutter test` |
| **Test Coverage** | 85% | 2026-06-28 | Focus required on `tasks` |
| **Build Status (Android)**| Passing | 2026-06-28 | Target SDK 34 |
| **Build Status (iOS)** | Passing | 2026-06-28 | Target iOS 15.0 |
| **DB Migrations** | 0 Pending | 2026-06-28 | Local DB in sync |

## 2. Documentation Completeness

*Note: These values indicate whether the generated documentation indexes are fully mapped to the current source code.*

| Document | Completeness | Needs Update? |
|----------|-------------|---------------|
| `FEATURE_REGISTRY.md` | 100% | No |
| `API_REFERENCE.md` | 100% | No |
| `SCREEN_CATALOG.md` | 90% | Yes (Missing new AI coach screens) |
| `MODULE_CONTRACTS.md` | 100% | No |

## 3. Pending Milestones

| Milestone | Status | Description |
|-----------|--------|-------------|
| **M1: Auth & Architecture** | ✅ Completed | Setup Supabase, GoRouter, Riverpod. |
| **M2: Dashboard & Networking** | ✅ Completed | UI Tokens, Ltree networking, KPIs. |
| **M3: Meetings & Video** | ✅ Completed | 100ms Integration, webhook attendance. |
| **M4: Tasks & Follow-ups** | ✅ Completed | Task commands, proof uploads, timelines. |
| **M5: Member Profiles** | ✅ Completed | Tabbed profiles, materialized progress. |
| **M6: Compliance Engine** | ⏳ Pending | Rule evaluation, automated warnings. |
| **M7: AI Executive Coach** | ⏳ Pending | RAG pipeline, pgvector, Gemini integration. |
| **M8: App Store Release** | ⏳ Pending | CI/CD pipelines, provisioning, production. |

## 4. Technical Debt

- Remove deprecated `get_old_task_format` RPC once M6 is complete.
- Refactor `TaskTimelineWidget` to use the new Serene Modernist timeline component.
