# Quality Gates — Ascendra

> **Purpose**: The mandatory checklist that an AI agent MUST run through and pass before marking a task as "Done".

---

## 1. Automated Checks (Code)

Before completion, you must run the following commands and ensure 0 errors:

- [ ] **Analyzer**: `flutter analyze` passes.
- [ ] **Formatting**: `dart format .` is applied to all modified files.
- [ ] **Tests (Flutter)**: `flutter test` passes for any modified features.
- [ ] **Tests (Database)**: `supabase test db` passes if any migrations were added.

## 2. Architectural Checks

You must manually verify the following constraints:

- [ ] **Architecture**: No business logic exists inside Flutter UI widgets. All database interactions go through a Repository and Riverpod Provider.
- [ ] **Security**: All new Supabase tables have RLS enabled, and policies strictly enforce tenant isolation (`company_id`). No API secrets are hardcoded in the client.
- [ ] **Performance**: Materialized Views are used for any complex aggregates/dashboards instead of pulling raw data to the client.

## 3. UI/UX Checks

- [ ] **Reference UI**: The layout perfectly matches the provided reference in `assets/reference/`.
- [ ] **Responsiveness**: The UI has been explicitly checked against the `mobileSmall` constraint (360px width) using `ResponsiveBuilder` or `Flexible`/`Expanded` to prevent overflow.
- [ ] **Accessibility**: All buttons and interactive elements have appropriate tap targets, and images have semantic labels where necessary.
- [ ] **Design Tokens**: `AppColors`, `AppTypography`, and `AppSpacing` are used exclusively. No magic numbers or hardcoded hex colors.

## 4. Documentation & AI Compliance

- [ ] **Documentation**: If a new feature, route, or shared widget was added, `FEATURE_REGISTRY.md`, `SCREEN_CATALOG.md`, or `COMPONENT_CATALOG.md` has been updated respectively.
- [ ] **Skills Used**: The agent actively searched for and applied relevant skills from the `Skills/` directory before implementation.
- [ ] **Plugins Used**: The agent utilized the preferred MCP plugins (e.g., Supabase MCP for SQL changes) as defined in `PLUGIN_DECISION_MATRIX.md`.

---
*An AI agent cannot declare a task complete until every item on this checklist is verified.*
