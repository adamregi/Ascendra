# Release Checklist — Ascendra

> **Purpose**: The mandatory steps to perform before cutting a production release.

---

## 1. Code Quality & Tests

- [ ] Run `flutter analyze`. Must have 0 errors and 0 warnings.
- [ ] Run `dart run custom_lint`. Fix any Riverpod or architecture violations.
- [ ] Run `flutter test`. All unit and widget tests must pass.
- [ ] Run `supabase test db`. All pgTAP database tests must pass.
- [ ] Verify there are no `TODO` or `FIXME` comments left for critical paths.

## 2. Versioning

Ascendra uses Semantic Versioning (`MAJOR.MINOR.PATCH`).

- [ ] Update `pubspec.yaml` version (e.g., `1.2.0+15`). The `+15` is the build number and MUST be incremented on every release for App Store/Play Store upload.
- [ ] Generate a new changelog entry in `CHANGELOG.md` detailing the new features, fixes, and breaking changes.

## 3. Environment Variables

- [ ] Ensure the CI/CD pipeline (GitHub Actions) has the correct `SUPABASE_URL` and `SUPABASE_ANON_KEY` for the **Production** Supabase project.
- [ ] Ensure the `--dart-define=ENVIRONMENT=prod` flag is set in the release build command.

## 4. Backend (Supabase & NestJS)

- [ ] Apply all pending migrations to the Production database (`supabase db push`).
- [ ] Deploy Edge Functions (`supabase functions deploy`).
- [ ] Deploy the NestJS workers to the Production environment (e.g., Railway).
- [ ] Verify that all required environment variables (e.g., 100ms keys, Gemini API keys, Twilio credentials) are set in the Production Supabase and NestJS environments.

## 5. Build Generation

- [ ] Generate Android App Bundle (AAB) for Play Store: `flutter build appbundle --release --dart-define=...`
- [ ] Generate iOS IPA for App Store (requires macOS): `flutter build ipa --release --dart-define=...`
- [ ] (Optional) Generate Web build if applicable: `flutter build web --release --dart-define=...`

## 6. Post-Release

- [ ] Create a GitHub Release tag (e.g., `v1.2.0`).
- [ ] Monitor Sentry / Crashlytics for the first 24 hours for unexpected spikes in errors.
