# Project Manifest — Ascendra

> **Welcome**. This is the root index and starting point for the Ascendra AI Operating System.
> **Mandatory AI Instruction**: Every AI agent entering this repository MUST read this file first before interacting with any source code.

## 1. Project Identity

- **Name**: Ascendra
- **Vision**: A leader-centric MLM leadership SaaS platform replacing scattered spreadsheets with a unified command center, powered by real-time compliance tracking and AI coaching.
- **Architecture**: Flutter (Client) → Supabase PostgREST (API) → PostgreSQL (DB) + NestJS (Workers) + Upstash Redis (Event Bus).

## 2. AI Operating System Overview

Ascendra is governed by a self-maintaining AI engineering platform. As an AI agent, you must follow the strict workflows defined in this system to maintain architectural integrity.

- **Start Here**: If you have just arrived, immediately read [CONTEXT_ENGINE.md](.ai-core/CONTEXT_ENGINE.md) to understand how to load your context deterministically.
- **Rules**: Never calculate backend KPIs in Flutter. Never bypass RLS. See [ANTI_PATTERNS.md](.ai-core/ANTI_PATTERNS.md) and [AI_RULES.md](.ai-core/AI_RULES.md) (Canonical Documents).

## 3. Documentation Hierarchy

### The Root (.ai-core/)
Contains the canonical AI governance, workflows, and rules.
- [CONTEXT_ENGINE.md](.ai-core/CONTEXT_ENGINE.md) — The reasoning engine.
- [KNOWLEDGE_GRAPH.md](.ai-core/KNOWLEDGE_GRAPH.md) — Navigating relationships.
- [PLANNING.md](.ai-core/PLANNING.md) — How to plan before coding.
- [ROLES.md](.ai-core/ROLES.md) — Which persona to adopt.
- [QUALITY_GATES.md](.ai-core/QUALITY_GATES.md) — Mandatory completion checks.
- [EVOLUTION_ENGINE.md](.ai-core/EVOLUTION_ENGINE.md) — Master rules for evolving this OS.
- [CONTINUOUS_IMPROVEMENT.md](.ai-core/CONTINUOUS_IMPROVEMENT.md) — Post-task AI reflection loop.
- [MEMORY_MODEL.md](.ai-core/MEMORY_MODEL.md) — How AI persists knowledge.

### The Library (docs/)
Contains manually maintained and generated architectural reference.
- [ARCHITECTURE_MAP.md](docs/ARCHITECTURE_MAP.md) — Layer ownership and boundaries.
- [ARCHITECTURE_EVOLUTION_LOG.md](docs/ARCHITECTURE_EVOLUTION_LOG.md) — Historical architecture versions.
- [MODULE_CONTRACTS.md](docs/MODULE_CONTRACTS.md) — Detailed feature boundaries.
- [FEATURE_DEPENDENCY_MATRIX.md](docs/FEATURE_DEPENDENCY_MATRIX.md) — Blast radius mapping.
- [DEPENDENCY_GRAPH.md](docs/DEPENDENCY_GRAPH.md) — How data flows.

## 4. Indexes & Quick Links

| Category | Index Link | Description |
|----------|------------|-------------|
| **Features** | [FEATURE_REGISTRY.md](.ai-core/FEATURE_REGISTRY.md) | Track all modules, owners, and reference screens. |
| **Data (JSON)** | [.ai-core/data/](.ai-core/data) | Machine-readable truth for features, RPCs, and widgets. |
| **Validation** | [DOC_VALIDATION.md](.ai-core/DOC_VALIDATION.md) | Quality checks for this documentation suite. |
| **Rules** | [ARCHITECTURAL_RULES.yaml](.ai-core/ARCHITECTURAL_RULES.yaml) | Encoded structural rules for static validation. |
| **Impact** | [IMPACT_ANALYSIS.md](.ai-core/IMPACT_ANALYSIS.md) | Pre-edit blast radius questionnaire. |
| **Metrics** | [ENGINEERING_METRICS.md](.ai-core/ENGINEERING_METRICS.md) | Tracked technical debt and reuse statistics. |
| **Playbooks** | [PLAYBOOKS.md](.ai-core/PLAYBOOKS.md) | Workflows for massive, multi-phase changes. |
| **Skills** | [SKILL_CATEGORIES.md](.ai-core/SKILL_CATEGORIES.md) | How to search the 24k+ skills directory. |
| **Plugins** | [PLUGIN_DECISION_MATRIX.md](.ai-core/PLUGIN_DECISION_MATRIX.md) | When to use Figma, Supabase MCP, etc. |
| **Decisions** | [DECISION_HISTORY.md](.ai-core/DECISION_HISTORY.md) | The *why* behind architectural choices. |
| **Builds** | [BUILD_COMMANDS.md](.ai-core/BUILD_COMMANDS.md) | Exact terminal commands for running and releasing. |

## 5. Quick-Start Workflow

1. Determine User Intent.
2. Load [CONTEXT_ENGINE.md](.ai-core/CONTEXT_ENGINE.md).
3. Search [FEATURE_REGISTRY.md](.ai-core/FEATURE_REGISTRY.md).
4. Load necessary [SKILL_CATEGORIES.md](.ai-core/SKILL_CATEGORIES.md).
5. Plan via [PLANNING.md](.ai-core/PLANNING.md).
6. Implement following [FEATURE_LIFECYCLE.md](.ai-core/FEATURE_LIFECYCLE.md).
7. Pass [QUALITY_GATES.md](.ai-core/QUALITY_GATES.md).
8. Automatically update docs via [DOC_GENERATION.md](.ai-core/DOC_GENERATION.md).
