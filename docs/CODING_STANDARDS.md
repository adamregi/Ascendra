# Coding Standards — Ascendra

> **Purpose**: Style, naming, and formatting rules for all Dart/Flutter code in Ascendra.

---

## 1. Naming Conventions

### Files and Directories
- Always use `snake_case` for files and directories.
- Add suffixes to indicate the type of file:
  - Models: `user_model.dart`
  - Repositories: `user_repository.dart`
  - Providers: `user_provider.dart`
  - Pages: `user_page.dart`

### Classes
- Always use `PascalCase`.
- Add suffixes matching the file type:
  - Models: `class UserModel`
  - Repositories: `abstract class UserRepository`
  - Pages: `class UserPage`

### Variables and Methods
- Always use `camelCase`.
- Prefix private variables and methods with an underscore: `_client`, `_handleTap()`.

### Providers (Riverpod)
- The provider definition function/class is `camelCase` or `PascalCase` based on type.
- The *generated* provider name will be `functionNameProvider` or `ClassNameProvider`.

## 2. Imports

Imports must be organized in a specific order. Group them and separate groups with blank lines.

```dart
// 1. Dart SDK
import 'dart:async';

// 2. Flutter SDK
import 'package:flutter/material.dart';

// 3. External packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// 4. Core (theme, constants)
import '../../../../core/constants/app_colors.dart';

// 5. Shared (shared widgets, models)
import '../../../../shared/widgets/app_card.dart';

// 6. Local Feature (models, providers, widgets from the same feature)
import '../providers/auth_provider.dart';
```

## 3. Formatting and Linting

- All code must pass `flutter analyze` with zero warnings or errors.
- All code must be formatted using `dart format .`.
- Ascendra uses `analysis_options.yaml` with strict rules (e.g., `prefer_const_constructors`, `require_trailing_commas`).
- Always add a trailing comma `,` to the end of multi-line function parameters or widget children to ensure proper formatting by `dart format`.

## 4. Documentation Comments

- Use `///` for documentation comments on public APIs, classes, and methods.
- Do not use standard `//` comments for API documentation.
- Focus on *why* the code exists or *how* it should be used, rather than what it does (which should be obvious from the name).

```dart
/// Calculates the time elapsed since the given [date].
///
/// Returns a human-readable string like "2 hours ago".
String timeAgo(DateTime date) { ... }
```

## 5. Extensions

If you find yourself writing utility functions that operate on primitive types or standard classes, use Dart `extension`s instead of utility classes.

```dart
// ✅ Correct
extension StringCapitalization on String {
  String get capitalizeFirst => '${this[0].toUpperCase()}${substring(1)}';
}

// ❌ Incorrect
class StringUtils {
  static String capitalizeFirst(String s) => '${s[0].toUpperCase()}${s.substring(1)}';
}
```
