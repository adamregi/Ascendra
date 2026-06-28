# Development Workflow — Ascendra

> **Purpose**: The end-to-end process for implementing a new feature in Ascendra.

---

## 1. Feature Inception

Before writing any code, a feature must be defined.
1. Review the requirement (e.g., "Add the ability to comment on tasks").
2. Check the `Skills/` directory for any pre-existing patterns related to this (e.g., commenting systems, realtime updates).
3. If this requires UI, locate the reference designs in `assets/reference/`.

## 2. Backend First (The Contract)

Because Ascendra relies heavily on the database for logic, **you must start at the backend**.

1. **Database Schema**: Add required tables/columns via a new migration in `supabase/migrations/`.
2. **RLS Policies**: Write Row-Level Security policies for the new tables.
3. **RPCs (Backend-for-Frontend)**: Write the stored procedure that the Flutter client will call. This RPC defines the exact JSON contract.
4. **Seed Data**: (Optional but recommended) Update `supabase/seed.sql` with mock data for local testing.

## 3. Flutter Data Layer

With the JSON contract defined by the RPC, move to the Flutter client.

1. **Models**: Create the Freezed models in `lib/features/<feature>/data/models/` that exactly match the RPC JSON output. Run `build_runner`.
2. **Repositories**: Define the interface in `domain/repositories/`, then implement it in `data/repositories/`. The implementation should call the new RPC.

## 4. Flutter Presentation Layer

1. **Providers**: Create the Riverpod providers (`@riverpod`) that call the repository. Remember to use `ref.cacheFor`. Run `build_runner`.
2. **Components**: Build reusable UI widgets in `presentation/widgets/` following the reference design.
3. **Pages**: Assemble the widgets into a full-screen page in `presentation/pages/`.
4. **Routing**: Add the new page to GoRouter in `lib/app/Router/app_router.dart`.

## 5. Verification

1. Run `flutter analyze` and fix all issues.
2. Run `dart format .`.
3. Write widget tests for complex UI components.
4. Write unit tests for complex Provider logic (if any).
5. Test manually on an Android emulator or iOS simulator.

## 6. The "Definition of Done"

A feature is not complete until:
- [ ] Backend migrations are written and tested locally.
- [ ] RLS policies exist and isolate tenant data.
- [ ] Flutter code follows Clean Architecture.
- [ ] No business logic exists in widgets.
- [ ] UI is responsive down to 360px.
- [ ] Design system tokens (colors, spacing, typography) are used exclusively.
- [ ] Code is formatted and passes the analyzer.
