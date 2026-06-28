# Clean Architecture Guide — Ascendra

> **Purpose**: Defines how the Clean Architecture pattern is implemented in Ascendra to ensure separation of concerns and testability.

---

## 1. The Core Principle

Dependencies must point **inwards** towards the domain layer. 

```
Presentation Layer (UI)  →  Domain Layer (Rules)  ←  Data Layer (APIs/DB)
```

- **Domain** knows nothing about Presentation or Data.
- **Presentation** knows about Domain, but nothing about Data.
- **Data** knows about Domain, but nothing about Presentation.

## 2. Layer Breakdown

### The Domain Layer (`lib/features/<feature>/domain/`)
This is the heart of the feature. It defines *what* the feature does, without knowing *how* it's done.

**Contents:**
- `entities/`: Pure Dart classes representing core business objects. In Ascendra, these are often identical to our Freezed models in the data layer since we rely heavily on the backend for logic.
- `repositories/`: Abstract classes (interfaces) defining the methods the feature needs.

```dart
// domain/repositories/task_repository.dart
abstract class TaskRepository {
  Future<List<TaskModel>> getTasks();
  Future<void> completeTask(String taskId);
}
```

### The Data Layer (`lib/features/<feature>/data/`)
This layer implements the domain interfaces and handles external communication (Supabase, Dio, local storage).

**Contents:**
- `models/`: Freezed classes with `@JsonSerializable`. DTOs (Data Transfer Objects) that map directly to API/RPC responses.
- `repositories/`: Implementations of the abstract repositories. These contain the actual Supabase/API calls.

```dart
// data/repositories/task_repository_impl.dart
class TaskRepositoryImpl extends BaseRepository implements TaskRepository {
  final SupabaseClient _client;
  TaskRepositoryImpl(this._client);

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      final response = await _client.rpc('get_tasks');
      return (response as List).map((json) => TaskModel.fromJson(json)).toList();
    } catch (e, stack) {
      handleException(e, stack); // From BaseRepository
    }
  }
}
```

### The Presentation Layer (`lib/features/<feature>/presentation/`)
This layer is responsible for displaying data and handling user input.

**Contents:**
- `providers/`: Riverpod providers that call repository methods and expose state.
- `pages/`: Full-screen widgets.
- `widgets/`: Reusable UI components for this feature.

## 3. Why Not Use "Use Cases"?

In traditional Clean Architecture, there is a `usecases` folder in the domain layer (e.g., `CompleteTaskUseCase`).

**In Ascendra, we typically skip Use Cases.**
Why? Because Ascendra's business logic (compliance, networking, scoring) lives in PostgreSQL RPCs and NestJS. The Flutter client is a "dumb" presentation layer. Adding Use Case classes that merely call `repository.completeTask()` adds boilerplate without value.

Providers directly call Repositories.

## 4. The Base Repository Pattern

All repository implementations must extend `BaseRepository` from `lib/core/repositories/base_repository.dart`.

This provides:
- Standardized error handling (`handleException`)
- Mapping of Supabase `PostgrestException` to custom domain failures (`ServerFailure`, `AuthFailure`)
- Logging hooks
