# Supabase Integration Guide — Ascendra

> **Purpose**: Guidelines for interacting with Supabase from the Flutter client.

---

## 1. Client Initialization

The Supabase client is initialized once in `lib/main.dart` before `runApp`.

```dart
await Supabase.initialize(
  url: AppConfig.supabaseUrl,
  anonKey: AppConfig.supabaseAnonKey,
  // We use flutter_secure_storage for the local storage instance
  localStorage: const SecureLocalStorage(), 
);
```

You can access the singleton client anywhere, but in Ascendra, **only Repository classes should access it**.

```dart
// Inside a repository implementation
final _client = Supabase.instance.client;
```

## 2. API Access Methods

There are two primary ways to fetch data from Supabase in Ascendra.

### Method 1: RPC (Remote Procedure Calls) - *Preferred*
Almost all reads and complex writes in Ascendra should use RPCs. This moves business logic and aggregation to the database.

```dart
final response = await _client.rpc(
  'get_member_profile',
  params: {'p_profile_id': profileId},
);
// response is a dynamic Map/List, cast it before parsing
final data = response as Map<String, dynamic>;
return MemberProfileModel.fromJson(data);
```

### Method 2: PostgREST (Table queries) - *Simple CRUD only*
Use direct table queries only for simple, single-table reads without complex logic.

```dart
final response = await _client
    .from('tasks')
    .select()
    .eq('assignee_id', userId)
    .order('created_at', ascending: false);
```

## 3. Realtime Subscriptions

Ascendra uses Supabase Realtime to listen for database changes (e.g., when a meeting starts, or a new task is assigned).

```dart
// In a repository
Stream<List<TaskModel>> watchTasks(String userId) {
  return _client
      .from('tasks')
      .stream(primaryKey: ['id'])
      .eq('assignee_id', userId)
      .map((maps) => maps.map((m) => TaskModel.fromJson(m)).toList());
}
```

*Note: Avoid overusing streams. Use them only for data that needs immediate UI updates (like active meeting status or chat messages). For other data, rely on `cacheFor` TTL and pull-to-refresh.*

## 4. Edge Functions

Edge Functions are used for 3rd-party integrations (e.g., Twilio OTP, 100ms room creation) or heavy operations that shouldn't run in PostgreSQL.

```dart
final response = await _client.functions.invoke(
  'schedule-meeting',
  body: {'title': 'Weekly Sync', 'start_time': '2023-10-25T10:00:00Z'},
);
```

## 5. Storage

Use Supabase Storage for task proofs (images/PDFs) and profile avatars.

```dart
// Uploading a file
final path = await _client.storage.from('task_proofs').upload(
  'user_id/task_id/filename.jpg',
  file,
  fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
);

// Getting a public URL (if the bucket is public)
final url = _client.storage.from('task_proofs').getPublicUrl(path);

// Getting a signed URL (if the bucket is private)
final signedUrl = await _client.storage.from('task_proofs').createSignedUrl(path, 3600);
```

## 6. Error Handling

Always wrap Supabase calls in a `try/catch` and use `handleException` from `BaseRepository`. Supabase throws `PostgrestException` for database errors, `AuthException` for auth errors, and `StorageException` for storage errors. The base repository converts these into domain `Failure` objects.
