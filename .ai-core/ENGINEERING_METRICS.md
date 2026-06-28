# Engineering Metrics — Ascendra

> **Purpose**: Defines the metrics tracked by the AI Operating System to measure codebase health and technical debt.

---

## 1. Tracked Metrics

A future automation script will parse the `.json` metadata files and the source code to update these metrics in `.ai-core/PROJECT_HEALTH.md`.

### Codebase Size
- **Provider Count**: Number of `@riverpod` annotations (Indicates state complexity).
- **Repository Count**: Number of classes implementing a `Repository` interface (Indicates data layer complexity).
- **RPC Count**: Length of `.ai-core/data/rpc_catalog.json` (Indicates backend-for-frontend surface area).

### Quality & Duplication
- **Component Reuse**: Ratio of UI elements utilizing `lib/shared/widgets/` versus bespoke feature-specific implementations.
- **Widget Duplication**: Number of structurally identical widgets existing in separate feature folders.

### Documentation & Safety
- **Documentation Coverage**: Percentage of `lib/features/` that exist in `features.json`.
- **Test Coverage**: Percentage of non-UI logic (`models`, `repositories`, `providers`) covered by `test/`.
- **Analyzer Issues**: Output count of `flutter analyze` and `dart run custom_lint`.

## 2. Thresholds & Alerts

If the **Widget Duplication** metric rises above 5%, the AI should proactively suggest a refactoring playbook (via `.ai-core/PLAYBOOKS.md`) to extract shared components into `lib/shared/`.
