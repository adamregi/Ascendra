# Continuous Improvement Loop — Ascendra

> **Purpose**: A self-reflection process that AI agents must execute at the end of every task to ensure the Operating System evolves instead of remaining static.

---

## 1. The Post-Task Reflection

Before closing a conversation or marking a major task complete, the AI agent must ask itself the following 8 questions and take action if the answer is "Yes".

### Execution Quality
1. **Was the implementation successful?**
   - *Action*: If the tests passed and the UI matches the reference, proceed. If not, rollback or alert the user.
2. **Can documentation be improved?**
   - *Action*: If a rule in `ANTI_PATTERNS.md` was unclear or missing, add a clarification. If an instruction in `AGENTS.md` was confusing, update it.

### Reusability
3. **Can a reusable component be extracted?**
   - *Action*: If you wrote a highly customized `Container` or `Row` that looks like it could be used elsewhere, extract it to `lib/shared/widgets/` and add it to `docs/COMPONENT_CATALOG.md`.
4. **Can a new Skill be created?**
   - *Action*: If you just solved a complex problem (e.g., implementing an intricate 100ms webhook), create a new `.md` file in the `Skills/` directory so future agents don't have to reinvent the solution.
5. **Can an existing Skill be generalized?**
   - *Action*: If an existing skill is too specific to `tasks`, generalize it so it can be applied to `meetings` or `compliance`.

### System Evolution
6. **Should a new recipe be added?**
   - *Action*: If you just performed a multi-step process that isn't documented (e.g., "Add a new Subscription Tier"), write a step-by-step guide in `.ai-core/RECIPES.md`.
7. **Should a new anti-pattern be documented?**
   - *Action*: If you caught yourself or a previous agent making a mistake (e.g., accidentally importing `dart:html` in a mobile app), add it immediately to `.ai-core/ANTI_PATTERNS.md`.
8. **Should the knowledge graph be updated?**
   - *Action*: If you created a new feature module, ensure it is fully mapped in `.ai-core/KNOWLEDGE_GRAPH.md` and `docs/FEATURE_DEPENDENCY_MATRIX.md`.

## 2. Execution

The AI agent does not need user permission to update documentation or create a new Skill based on this reflection loop. The agent must proactively maintain the engineering platform.
