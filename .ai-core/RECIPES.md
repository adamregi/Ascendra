# Implementation Recipes — Ascendra

> **Purpose**: Step-by-step guides for executing common structural changes and additions in the Ascendra codebase.

---

## 1. Create a New Feature Module

Follow this recipe when adding a completely new feature (e.g., "Announcements").

1. **Create Folder Structure**:
   - `lib/features/<feature_name>/data/models/`
   - `lib/features/<feature_name>/data/repositories/`
   - `lib/features/<feature_name>/domain/repositories/`
   - `lib/features/<feature_name>/presentation/pages/`
   - `lib/features/<feature_name>/presentation/providers/`
   - `lib/features/<feature_name>/presentation/widgets/`
2. **Create Entities/Models**: Define Freezed classes in `data/models/`.
3. **Create Repository Interface**: Define abstract methods in `domain/repositories/`.
4. **Create Repository Impl**: Implement the interface in `data/repositories/`.
5. **Create Providers**: Create `@riverpod` providers in `presentation/providers/`.
6. **Create Pages**: Build the main screen in `presentation/pages/`.
7. **Add to Router**: Register the new page route in `lib/app/Router/app_router.dart`.
8. **Update Registry**: Add the new feature to `.ai-core/FEATURE_REGISTRY.md`.

## 2. Create a Database RPC (Backend-for-Frontend)

1. **Create Migration**: Run `supabase migration new <name>`.
2. **Define Function**: Open the migration file. Write `CREATE OR REPLACE FUNCTION get_<feature>_view_model() RETURNS json...`
3. **Set Security**: Add `SECURITY INVOKER` and ensure the language is `plpgsql` (or `sql`).
4. **Enforce Isolation**: Use `where company_id = get_user_company_id()`.
5. **Return JSON**: Use `json_build_object` to structure the exact payload Flutter needs.
6. **Test Locally**: Apply migration via `supabase db push` or `supabase db reset`.

## 3. Create a Shared UI Component

1. **Check Catalog**: Ensure a similar component doesn't already exist in `docs/COMPONENT_CATALOG.md`.
2. **Create File**: Create `lib/shared/widgets/<component_name>.dart`.
3. **Stateless Default**: Extend `StatelessWidget`.
4. **Apply Tokens**: Use `AppColors`, `AppTypography`, and `AppSpacing` exclusively. No hardcoded hex codes.
5. **Add to Catalog**: Document the new component in `docs/COMPONENT_CATALOG.md`.

## 4. Add Storage Upload Capability

1. **Storage RLS**: Ensure the target bucket in Supabase has correct RLS policies for `INSERT` and `SELECT`.
2. **Flutter Picker**: Use `image_picker` or `file_picker` in the UI to get the local file.
3. **Repository Method**: Create a method in the relevant repository.
4. **Upload Call**: Use `Supabase.instance.client.storage.from('<bucket>').upload()`.
5. **Save Path**: Store the returned path in the relevant database table (e.g., `task_proofs`).
6. **Provider State**: Handle loading states in the Riverpod provider while the upload is in progress.
