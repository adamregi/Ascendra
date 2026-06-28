# Common Workflows — Ascendra

> **Purpose**: Step-by-step recipes for the most frequent development tasks in Ascendra.

---

## 1. Adding a New RPC and Connecting it to Flutter

**Step 1: Create the SQL Migration**
1. Create `supabase/migrations/0XX_<name>.sql`
2. Write the RPC function (follow `RPC_GUIDE.md`)
3. Run `supabase db reset` to apply locally

**Step 2: Create the Data Model**
1. Create `lib/features/<feature>/data/models/<name>_model.dart`
2. Use `@freezed` and `@JsonSerializable`
3. Run `dart run build_runner build -d`

**Step 3: Update the Repository**
1. Add method signature to `lib/features/<feature>/domain/repositories/<feature>_repository.dart`
2. Implement method in `lib/features/<feature>/data/repositories/<feature>_repository_impl.dart`
3. Wrap Supabase call in `try/catch` with `handleException()`

**Step 4: Create the Provider**
1. Create/update `lib/features/<feature>/presentation/providers/<feature>_providers.dart`
2. Write an `@riverpod` annotated function
3. Add `ref.cacheFor(const Duration(minutes: 5))`
4. Run `dart run build_runner build -d`

**Step 5: Consume in Widget**
1. Use `ConsumerWidget`
2. Call `ref.watch(providerName)`
3. Handle `.when(data:, loading:, error:)`

---

## 2. Creating a New UI Screen

**Step 1: Inspect References**
1. Check `assets/reference/<screen>/` for visuals and HTML/CSS logic

**Step 2: Build Reusable Components**
1. Identify parts of the screen that can be separate widgets
2. Create them in `lib/features/<feature>/presentation/widgets/`
3. Ensure they accept typed view models, not raw data

**Step 3: Build the Page Layout**
1. Create `lib/features/<feature>/presentation/pages/<name>_page.dart`
2. Use `ResponsiveBuilder` or `ResponsivePadding` if needed
3. Assemble the components

**Step 4: Add Routing**
1. Add the route to `lib/app/Router/app_router.dart`
2. Define the route path and builder

---

## 3. Modifying an Existing Model

**Step 1: Update the Freezed Class**
1. Open the model file
2. Add/remove fields
3. Update default values if necessary

**Step 2: Regenerate Code**
1. Run `dart run build_runner build -d`
2. Fix any compile errors in widgets that rely on the changed fields

**Step 3: Update the API Contract**
1. If the model represents an RPC response, ensure the SQL migration is also updated
2. *Note: Never modify an existing migration. Create a new one that uses `CREATE OR REPLACE FUNCTION`.*

---

## 4. Writing a Widget Test

**Step 1: Set up the Test File**
1. Create `test/features/<feature>/presentation/<name>_test.dart`

**Step 2: Create Mock Data**
1. Instantiate the required Freezed models with test data

**Step 3: Write the Test**
1. Use `testWidgets`
2. Pump the widget inside a `MaterialApp`
3. Use `find.text`, `find.byType`, etc., to verify rendering
4. Use `tester.tap` and `tester.pump` for interactions

---

*Follow these recipes to ensure consistency with the established architecture.*
