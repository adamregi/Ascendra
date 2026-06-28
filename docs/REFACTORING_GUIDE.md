# Refactoring Playbook — Ascendra

> **Purpose**: Standard Operating Procedures for safely executing large structural changes across the stack.

---

## 1. Splitting a Module

If a feature grows too large (e.g., `tasks` splitting into `tasks` and `compliance`), follow this sequence:
1. Create the new folder structure for the extracted module (`lib/features/compliance/`).
2. Move the relevant models and repository files.
3. Update the imports in the old module.
4. Split the backend RPC. Do NOT drop the old RPC fields immediately. Have the new RPC return the new data, and let the old RPC return duplicate data temporarily.
5. Update Riverpod Providers to call the new repository.
6. Verify UI behavior.
7. Deprecate and remove duplicate fields from the old RPC.

## 2. Merging Providers

If two providers are frequently watched together (e.g., `userProfileProvider` and `userSettingsProvider`), consider merging them into a single `AppState` provider.
1. Create the new combined `@riverpod` class.
2. Initialize it using `ref.watch` on the original repositories.
3. Update the UI to watch the new provider.
4. Delete the old providers and their `.g.dart` files.

## 3. Renaming a DTO (Data Transfer Object)

Renaming a Freezed model requires updating both ends of the contract.
1. Rename the Freezed class (e.g., `OldModel` -> `NewModel`).
2. Run `dart run build_runner build -d`.
3. If the JSON keys changed, update the backend RPC using the `json_build_object` mapping.
4. Ensure `docs/MODULE_CONTRACTS.md` is updated.

## 4. Extracting a Shared Widget

If a widget is duplicated across two features, extract it:
1. Move the widget file to `lib/shared/widgets/`.
2. Replace any feature-specific domain models with generic parameters (e.g., `String title`, `VoidCallback onTap`).
3. Update all call sites.
4. Add the widget to `docs/COMPONENT_CATALOG.md`.

## 5. Archiving a Module

If a feature is completely deprecated:
1. Remove it from the `app_router.dart` routes.
2. Delete the `lib/features/<module>/` folder.
3. Add a `-- DEPRECATED` comment to its backend RPCs (Do not drop immediately).
4. Remove it from `.ai-core/FEATURE_REGISTRY.md`.
