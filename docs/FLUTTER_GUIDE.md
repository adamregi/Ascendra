# Flutter Development Guide — Ascendra

> **Purpose**: The core principles and patterns for writing Flutter UI code in Ascendra.

---

## 1. The Presentation-Only Rule

In Ascendra, **Widgets are strictly for presentation.** 
They must never contain business logic, data fetching logic, or direct Supabase calls.

### The Correct Pattern
Widgets should receive typed view models (Freezed classes) or watch Riverpod providers.

```dart
// ✅ Correct: Widget is dumb. It only knows how to display MemberHeroModel.
class MemberHero extends StatelessWidget {
  final MemberHeroModel heroData;
  const MemberHero({super.key, required this.heroData});

  @override
  Widget build(BuildContext context) {
    return Text(heroData.firstName);
  }
}
```

### The Incorrect Pattern
Never do this. It tightly couples UI to the database.

```dart
// ❌ Incorrect: Widget fetches data directly.
class MemberHero extends StatelessWidget {
  final String userId;
  const MemberHero({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Supabase.instance.client.from('profiles').select().eq('id', userId),
      builder: (context, snapshot) {
        // ...
      }
    );
  }
}
```

## 2. Widget Lifecycle and State

### StatelessWidget First
Always prefer `StatelessWidget` or `ConsumerWidget`. Only use `StatefulWidget` or `ConsumerStatefulWidget` when you need to manage complex UI state (like scroll controllers, animations, or complex forms).

### Const Constructors
Use `const` for widget constructors wherever possible. This allows Flutter to cache the widget and significantly improves performance during rebuilds.

```dart
// ✅ Correct
const SizedBox(height: 16),
const Text('Title'),

// ❌ Incorrect
SizedBox(height: 16),
Text('Title'),
```

## 3. UI Composition

### Component-First Approach
Do not build monolithic 500-line pages. Break screens down into smaller, reusable components.
- If a component is specific to one feature, put it in `lib/features/<feature>/presentation/widgets/`.
- If it's used across multiple features, put it in `lib/shared/widgets/`.

### Avoid Deep Nesting
If a `build` method becomes deeply nested (e.g., Row > Column > Container > Row > Expanded), extract the inner parts into separate widgets or helper methods. 

## 4. Design System Tokens

Never hardcode colors, spacing, or typography. Always use the tokens defined in `lib/core/constants/`.

```dart
// ❌ Incorrect
Container(
  color: Color(0xFF181e1a),
  padding: EdgeInsets.all(16),
  child: Text('Hello', style: TextStyle(fontSize: 16, fontFamily: 'Inter')),
)

// ✅ Correct
Container(
  color: AppColors.primary,
  padding: EdgeInsets.all(AppSpacing.md),
  child: Text('Hello', style: AppTypography.body1),
)
```

## 5. Async UI Handling

When watching an asynchronous Riverpod provider, you must handle all three states: `data`, `loading`, and `error`.

```dart
Widget build(BuildContext context, WidgetRef ref) {
  final profileAsync = ref.watch(memberProfileProvider(profileId));

  return profileAsync.when(
    data: (profile) => ProfileView(profile: profile),
    loading: () => const ProfileShimmer(), // Create shimmer widgets for loading states
    error: (err, stack) => ErrorDisplay(message: err.toString()), // Use standard error widget
  );
}
```

## 6. Forms and Validation

- Use `Form` and `TextFormField` for all inputs.
- Validation logic should be simple. Complex rules (like "does this username exist?") should be handled by calling a provider method, not hardcoded in the validator.
- Show loading states on submit buttons while requests are in flight.
