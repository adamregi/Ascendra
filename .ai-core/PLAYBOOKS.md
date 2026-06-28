# AI Playbooks — Ascendra

> **Purpose**: Massive, multi-document workflows that AI agents can execute to accomplish high-level business goals. These are broader than the recipes found in `.ai-core/RECIPES.md`.

---

## 1. Build a New Feature from Scratch

1. **Initialize Context**: Run the Context Engine (`.ai-core/CONTEXT_ENGINE.md`).
2. **Impact Analysis**: Fill out `.ai-core/IMPACT_ANALYSIS.md`.
3. **Database Architecture**: Assume the `Database Architect` role. Write migrations, define tables, RLS policies, and the BFF RPC.
4. **Data Layer**: Assume the `Flutter Engineer` role. Run `build_runner` to generate Freezed models and Riverpod providers.
5. **UI Layer**: Assume the `UI/UX Engineer` role. Implement the UI matching `assets/reference/`.
6. **Testing**: Assume the `QA Engineer` role. Write widget and unit tests.
7. **Documentation**: Run `.ai-core/DOC_GENERATION.md` rules to update `features.json`, `rpc_catalog.json`, and `FEATURE_REGISTRY.md`.
8. **Final Validation**: Pass `.ai-core/QUALITY_GATES.md`.

## 2. Refactor an Existing Module

1. **Context & Impact**: Load `docs/REFACTORING_GUIDE.md` and complete `.ai-core/IMPACT_ANALYSIS.md`.
2. **Matrix Check**: Consult `docs/FEATURE_DEPENDENCY_MATRIX.md` to identify which modules will break.
3. **Deprecation**: Mark old RPCs as `-- DEPRECATED` (do not drop them).
4. **Implementation**: Build the new logic alongside the old logic.
5. **Quality Assurance**: Run the full test suite to ensure regressions were not introduced to dependent modules.
6. **Documentation Update**: Update `docs/MODULE_CONTRACTS.md` with the new boundaries.

## 3. Perform a Release

1. **Health Check**: Consult `.ai-core/PROJECT_HEALTH.md` and ensure all tests and analyzers pass.
2. **Changelog Generation**: Assume the `Documentation Engineer` role. Read Git history and update `CHANGELOG.md` following the Keep a Changelog standard.
3. **Version Bump**: Assume the `DevOps Engineer` role. Bump versions in `pubspec.yaml` and `VERSION_MATRIX.md`.
4. **Database Sync**: Ensure all local migrations are pushed to the Production Supabase project.
5. **Artifact Build**: Execute the build commands defined in `.ai-core/BUILD_COMMANDS.md`.
