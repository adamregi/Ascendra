# Riverpod Guide — Ascendra

> **Purpose**: Standard patterns for state management using Riverpod in Ascendra.

---

## 1. Code Generation is Mandatory

We use `riverpod_annotation` and `riverpod_generator` for ALL providers. Do not write providers manually using `Provider`, `FutureProvider`, etc.

### Why?
Code generation provides:
- Strong typing
- Automatic family parameter handling
- Auto-dispose by default
- Cleaner syntax

### How to use
Annotate functions or classes with `@riverpod` and run `dart run build_runner build -d`.

```dart
// The generated file
part 'auth_provider.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(Supabase.instance.client);
}
```

## 2. Types of Providers

### Data Providers (Async Fetching)
Used to fetch data from repositories. They return `Future<T>`.

```dart
@riverpod
Future<MemberProfileViewModel> memberProfile(
  Ref ref,
  String profileId, // This makes it a family provider automatically
) async {
  // 1. Add caching (CRITICAL)
  ref.cacheFor(const Duration(minutes: 5));
  
  // 2. Read dependencies
  final repo = ref.watch(memberProfileRepositoryProvider);
  
  // 3. Fetch data
  return repo.getMemberProfile(profileId);
}
```

### Local State Providers (Synchronous)
Used for UI state, filters, or form state. Use a class extending `_$ClassName`.

```dart
@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => ''; // Initial state

  void update(String query) {
    state = query; // Updating state triggers rebuilds
  }
}
```

## 3. TTL Caching (`cacheFor`)

By default, generated providers are auto-disposed as soon as the last widget stops watching them. In a navigation stack, this causes unnecessary refetching when popping back to a previous screen.

To fix this, Ascendra uses a custom `cacheFor` extension defined in `lib/core/extensions/ref_extensions.dart`.

**Rule: ALL data-fetching providers must use `ref.cacheFor(const Duration(minutes: 5));`.**

## 4. Provider Dependency Flow

Providers should depend on other providers to build a reactive pipeline.

```dart
// 1. Filter state
@riverpod
class StatusFilter extends _$StatusFilter {
  @override
  String? build() => null;
  void setFilter(String? status) => state = status;
}

// 2. Raw data (cached)
@riverpod
Future<List<Task>> allTasks(Ref ref) async {
  ref.cacheFor(const Duration(minutes: 5));
  return ref.watch(taskRepositoryProvider).getTasks();
}

// 3. Computed data (reacts to both)
@riverpod
Future<List<Task>> filteredTasks(Ref ref) async {
  final tasks = await ref.watch(allTasksProvider.future);
  final status = ref.watch(statusFilterProvider);
  
  if (status == null) return tasks;
  return tasks.where((t) => t.status == status).toList();
}
```

## 5. Mutation (Executing Actions)

When you need to update data (e.g., submit a form, delete an item), do it inside a Riverpod class or pass a callback that invalidates the relevant data provider.

```dart
@riverpod
class TaskController extends _$TaskController {
  @override
  FutureOr<void> build() {}

  Future<void> completeTask(String taskId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(taskRepositoryProvider).completeTask(taskId);
      // Invalidate the list so it refetches
      ref.invalidate(allTasksProvider);
    });
  }
}
```
