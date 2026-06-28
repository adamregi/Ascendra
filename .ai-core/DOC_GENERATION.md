# Documentation Generation Rules — Ascendra

> **Purpose**: Defines the rules for making Ascendra's documentation self-maintaining. AI agents must automatically update the relevant indexes when source code changes are made.

---

## 1. The Golden Rule

**Documentation is part of the code.** A feature is not complete until its corresponding documentation has been updated. Do not wait for the user to ask you to update the documentation.

## 2. Trigger Events & Required Updates

Whenever you perform one of the following actions, you MUST evaluate and execute the corresponding documentation updates.

### Action: Created a New Feature Module
- **Update**: `.ai-core/FEATURE_REGISTRY.md` (Add the new feature, its owners, and status).
- **Update**: `docs/MODULE_CONTRACTS.md` (Define its inputs, outputs, and RPCs).
- **Update**: `docs/DEPENDENCY_GRAPH.md` (If it introduces a new architectural flow).
- **Update**: `PROJECT_MANIFEST.md` (If it requires a major new index link).

### Action: Created a New RPC
- **Update**: `.ai-core/FEATURE_REGISTRY.md` (Append the RPC to the relevant feature's row).
- **Update**: `docs/API_REFERENCE.md` (Document parameters and return types).
- **Update**: `docs/MODULE_CONTRACTS.md` (Add to the specific module's contract).

### Action: Created a New Shared Component (`lib/shared/widgets/`)
- **Update**: `docs/COMPONENT_CATALOG.md` (Add the widget, its parameters, and its intended use case).

### Action: Modified a Provider or Repository
- **Update**: `docs/MODULE_CONTRACTS.md` (If the public interface or return type changed).

### Action: Completed a Milestone / Cut a Release
- **Update**: `CHANGELOG.md` (Following Keep a Changelog).
- **Update**: `.ai-core/PROJECT_HEALTH.md` (Update pending milestones and test coverage).

## 3. Manual vs. Generated Documentation

AI Agents should understand which documents are immutable rules and which are generated indexes.

- **Manual (Do not alter unless explicitly instructed)**: `AGENTS.md`, `PROJECT_MANIFEST.md`, `ROLES.md`, `ANTI_PATTERNS.md`, `QUALITY_GATES.md`.
- **Generated (Update automatically upon code change)**: `FEATURE_REGISTRY.md`, `COMPONENT_CATALOG.md`, `API_REFERENCE.md`, `PROJECT_HEALTH.md`, `CHANGELOG.md`.
