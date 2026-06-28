# AI Memory Model — Ascendra

> **Purpose**: Defines how an AI agent should persist knowledge across interactions. Memory is not a single document; it is tiered based on the lifespan of the information.

---

## 1. Permanent Memory

**Lifespan**: The lifetime of the project.
**Location**: `PROJECT_MANIFEST.md`, `AGENTS.md`, `.ai-core/*.md`, `docs/*.md`.
**Content**: 
- Core architectural rules (e.g., "Never calculate KPIs in Flutter").
- Feature definitions and boundaries.
- Database schema structure.
**Update Cadence**: Only updated when the project architecture or business requirements fundamentally shift.

## 2. Long Term Memory

**Lifespan**: Months to Years.
**Location**: `.ai-core/data/*.json`, `CHANGELOG.md`, `.ai-core/PROJECT_HEALTH.md`.
**Content**:
- List of current features and RPCs.
- Pending milestones and technical debt.
- API endpoints and widget catalogs.
**Update Cadence**: Updated continuously by the AI upon completing any feature implementation or refactoring.

## 3. Session Memory

**Lifespan**: Days to Weeks.
**Location**: `.ai-core/MEMORY.md` or a conversation-specific `implementation_plan.md`.
**Content**:
- The current user request.
- The step-by-step execution plan for the active feature.
- Known bugs that are actively being triaged.
**Update Cadence**: Updated dynamically during a conversation or task execution. Usually cleared or archived once the task is marked "Done".

## 4. Temporary Memory (Scratch)

**Lifespan**: Minutes to Hours.
**Location**: Agent's internal context window or a temporary local scratch file (`.scratch.md`).
**Content**:
- Intermediate regex matches.
- Impact Analysis questionnaire drafts (`.ai-core/IMPACT_ANALYSIS.md`).
- Raw terminal output from `flutter analyze` or `flutter test`.
**Update Cadence**: Discarded immediately upon task completion. Do not commit scratch files to version control.
