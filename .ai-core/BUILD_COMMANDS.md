# Build Commands — Quick Reference

> All commands run from the project root: `distributor_os/`

---

## Daily Development

| Command | Purpose |
|---------|---------|
| `flutter pub get` | Install/update dependencies |
| `dart run build_runner build -d` | Generate code (Freezed, Riverpod, JSON) |
| `dart run build_runner watch -d` | Watch mode — regenerates on file changes |
| `dart format .` | Format all Dart files |
| `flutter analyze` | Static analysis (lint + type checking) |
| `flutter test` | Run all unit/widget tests |
| `flutter test integration_test` | Run integration tests |
| `flutter run` | Run app in debug mode |
| `flutter run -d chrome` | Run web version |

## Clean & Reset

| Command | Purpose |
|---------|---------|
| `flutter clean` | Delete build artifacts |
| `flutter pub get` | Re-fetch dependencies after clean |
| `dart run build_runner build -d` | Regenerate code after clean |

**Full clean sequence:**
```bash
flutter clean && flutter pub get && dart run build_runner build -d
```

## Build Artifacts

| Command | Output |
|---------|--------|
| `flutter build apk --debug` | `build/app/outputs/flutter-apk/app-debug.apk` |
| `flutter build apk --release` | `build/app/outputs/flutter-apk/app-release.apk` |
| `flutter build apk --split-per-abi` | Per-architecture APKs (smaller) |
| `flutter build appbundle --release` | `build/app/outputs/bundle/release/app-release.aab` |
| `flutter build ios --release` | iOS archive (macOS only) |
| `flutter build web --release` | `build/web/` |

## Asset Generation

| Command | Purpose |
|---------|---------|
| `dart run flutter_launcher_icons` | Generate app icons from `assets/branding/ascendra_logo.png` |
| `dart run flutter_native_splash:create` | Generate splash screen |

## Dependency Auditing

| Command | Purpose |
|---------|---------|
| `flutter pub outdated` | Check for outdated packages |
| `flutter pub upgrade` | Upgrade to latest compatible versions |
| `flutter pub upgrade --major-versions` | Upgrade including major versions |
| `flutter pub deps` | Show dependency tree |

## Supabase CLI

| Command | Purpose |
|---------|---------|
| `supabase start` | Start local Supabase |
| `supabase stop` | Stop local Supabase |
| `supabase db reset` | Reset local DB (reapplies all migrations) |
| `supabase migration new <name>` | Create new migration file |
| `supabase functions serve` | Serve Edge Functions locally |
| `supabase functions deploy <name>` | Deploy Edge Function |

## Common Workflows

### After modifying a Freezed model:
```bash
dart run build_runner build -d
```

### After adding a new @riverpod provider:
```bash
dart run build_runner build -d
```

### After modifying pubspec.yaml:
```bash
flutter pub get
```

### Full rebuild:
```bash
flutter clean && flutter pub get && dart run build_runner build -d
```

### Pre-commit check:
```bash
dart format . && flutter analyze && flutter test
```

---

*See also: [BUILD_GUIDE.md](../docs/BUILD_GUIDE.md), [RELEASE_GUIDE.md](../docs/RELEASE_GUIDE.md)*
