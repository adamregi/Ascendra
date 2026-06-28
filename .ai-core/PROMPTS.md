# AI Prompt Library — Ascendra

> **Purpose**: A library of standardized prompts for AI agents to use when transitioning roles or executing specific workflows.

---

## 1. Feature Creation

### Create RPC
> "Assume the role of **Database Architect**. I need to create a new RPC named `[RPC_NAME]` for the `[FEATURE]` module. It should take `[PARAMETERS]` and return a JSON object matching this structure: `[JSON_STRUCTURE]`. Ensure it uses `security invoker` and enforces the company RLS policy."

### Create Feature (Flutter)
> "Assume the role of **Flutter Engineer**. We have a new backend contract defined in `[RPC_NAME]`. Please execute the Feature Lifecycle: First, create the Freezed models in `lib/features/[FEATURE]/data/models/`. Second, create the Repository interface and implementation. Third, create the Riverpod provider using `@riverpod` and `ref.cacheFor`. Do not build the UI yet."

### Create Screen (UI)
> "Assume the role of **UI/UX Engineer**. I need to build the `[SCREEN_NAME]` page for the `[FEATURE]` module. Please review the reference assets in `assets/reference/[SCREEN_NAME]/`. Translate the HTML/CSS reference into Flutter using Ascendra's `AppColors`, `AppTypography`, and `AppSpacing` tokens. Extract any reusable parts into `lib/features/[FEATURE]/presentation/widgets/`."

## 2. Review and Refactoring

### Review Architecture
> "Assume the role of **Database Architect** and **Flutter Engineer**. Review the implementation of the `[FEATURE]` module against `AGENTS.md` and `.ai-core/ANTI_PATTERNS.md`. Are there any business rules calculated in the UI? Is data fetching happening inside widgets instead of providers? Provide a list of architectural violations."

### Review Security
> "Assume the role of **Security Engineer**. Review the RLS policies in `supabase/migrations/[MIGRATION_FILE]` and the Edge Function in `supabase/functions/[FUNCTION_NAME]`. Verify that tenant isolation (`company_id`) is strictly enforced and that no sensitive keys are exposed to the client."

### Optimize Performance
> "Assume the role of **Performance Engineer**. Review the `[SCREEN_NAME]` page. Are there any unnecessary widget rebuilds? Are `const` constructors used wherever possible? Are lists using `ListView.builder`? Are Riverpod providers properly utilizing `ref.cacheFor` to prevent excessive network calls?"

### Refactor Feature
> "Please review `.ai-core/MIGRATION_GUIDE.md` and `docs/FILE_OWNERSHIP.md`. We need to extract the `[COMPONENT]` from `[FILE_A]` and move it to `lib/shared/widgets/`. Ensure all imports are updated and that the component does not contain any feature-specific business logic."

## 3. DevOps and Quality Assurance

### Generate Tests
> "Assume the role of **QA Engineer**. Generate widget tests for `[WIDGET_NAME]` covering its loading, error, and data states. Mock the Riverpod providers using `mockito`. Then generate unit tests for `[MODEL_NAME]` testing its `fromJson` and `toJson` methods."

### Build APK / Release
> "Assume the role of **DevOps Engineer**. Please walk me through `.ai-core/QUALITY_GATES.md` and `docs/RELEASE_CHECKLIST.md`. Confirm that `flutter analyze`, `dart format`, and `flutter test` pass, then provide the exact command to build the production Android App Bundle."

### Fix Analyzer
> "Run `flutter analyze` and `dart run custom_lint`. Provide a patch to fix all resulting warnings and errors, strictly adhering to `docs/CODING_STANDARDS.md`."
