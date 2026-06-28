# AI Agent Checklists — Ascendra

> **Purpose**: Standardized checklists for AI agents to follow during different phases of work.

---

## 1. Initial Assessment Checklist (Before Coding)

- [ ] I have read the user's request carefully.
- [ ] I have identified the relevant feature module(s).
- [ ] I have searched the `Skills/` folder for related skills and read them.
- [ ] I have checked `assets/reference/` for any existing UI designs related to this task.
- [ ] I understand whether this requires a UI change, a database change, or both.
- [ ] If this requires a backend change, I have checked if an RPC already exists for it.

## 2. UI Implementation Checklist (During Coding)

- [ ] The widget is presentation-only (no data fetching logic inside).
- [ ] The widget accepts a typed view model (Freezed), not raw JSON.
- [ ] I checked `shared/widgets/` to see if I could reuse an existing component.
- [ ] I used `AppColors`, `AppTypography`, and `AppSpacing` (no hardcoded design values).
- [ ] The layout is responsive (works at 360px without overflow).
- [ ] `ref.watch` is used correctly with appropriate `.when()` state handling.

## 3. Database / Backend Checklist (During Coding)

- [ ] New database changes are in a NEW migration file (never edit existing ones).
- [ ] RLS policies are included for new tables.
- [ ] RPCs that return data return JSON/JSONB for easy mapping to Freezed models.
- [ ] I have not put complex, evolving business logic (like compliance rules) into SQL unless absolutely necessary.
- [ ] If I created an RPC, I have also created the corresponding Dart model and repository method.

## 4. Pre-PR / Self-Review Checklist (After Coding)

- [ ] `flutter analyze` passes with zero errors.
- [ ] `dart run build_runner build -d` was run after any model/provider changes.
- [ ] No aggregates or complex metrics are computed in Flutter.
- [ ] The code aligns with the project's Clean Architecture.
- [ ] I have verified that all necessary imports are correct.
- [ ] I have formatted the code with `dart format .`.

---

*AI Note: Complete these checks silently before responding to the user. Do not print these checklists to the user unless explicitly requested.*
