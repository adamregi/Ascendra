# Evolution Engine — Ascendra

> **Purpose**: The master rulebook defining how the AI Operating System itself changes over time. This document closes the loop, allowing the AI to govern its own rules, roles, and boundaries as the codebase scales.

---

## 1. The Core Philosophy

The documentation suite must never become a bottleneck. If an instruction, rule, or boundary is slowing down development or causing repeated errors, **the AI is empowered and obligated to change it.**

## 2. Triggers for System Evolution

When should the AI modify the Operating System? Evaluate these conditions constantly:

### When to Create a New AI Role (`ROLES.md`)
- **Condition**: A new, highly specialized technology is introduced (e.g., heavily utilizing WebGL, or introducing a dedicated Payments service via Stripe).
- **Action**: Add a new persona (e.g., `Billing Engineer`) to `.ai-core/ROLES.md` to isolate those specific responsibilities and required plugins.

### When to Create or Archive a Skill (`Skills/`)
- **Condition (Create)**: A specific technical hurdle is cleared that took multiple attempts (e.g., getting Riverpod to work perfectly with Supabase Realtime).
- **Condition (Archive)**: A package is deprecated (e.g., migrating from `provider` to `riverpod`), or a feature is sunset.
- **Action**: Use the `CONTINUOUS_IMPROVEMENT.md` loop to add/remove the `.md` file in `Skills/`, and immediately update `.ai-core/SKILL_CATEGORIES.md`.

### When to Split Documentation (`docs/`)
- **Condition**: A file like `MODULE_CONTRACTS.md` or `API_REFERENCE.md` exceeds 500 lines or becomes difficult to traverse.
- **Action**: Split the file hierarchically (e.g., `docs/contracts/dashboard.md`, `docs/contracts/tasks.md`) and update `PROJECT_MANIFEST.md` to point to the new directory.

### When to Reconsider Architecture (`ARCHITECTURE_MAP.md`)
- **Condition**: An architectural rule (e.g., "No business logic in Flutter") is causing extreme friction for a very specific use case (e.g., offline-first queueing).
- **Action**: The AI must write an ADR (Architecture Decision Record) proposing the exception. If accepted by the human developer, the AI must update `ARCHITECTURE_MAP.md` and `DECISION_HISTORY.md` to reflect the new paradigm.

### When to Change Quality Gates (`QUALITY_GATES.md`)
- **Condition**: A new CI/CD tool is added, or a new standard is adopted (e.g., strictly requiring 100% test coverage for `data/` layers).
- **Action**: Add the new mandate to `.ai-core/QUALITY_GATES.md`. If a gate is consistently skipped because it is obsolete, remove it.

## 3. The Prime Directive

**Maintain the Source of Truth.**
If any change is made to the Evolution Engine, the Context Engine, or the Knowledge Graph, the agent must immediately update `PROJECT_MANIFEST.md` if structural links were affected. The Operating System must never contain broken links or dead-end reasoning paths.
