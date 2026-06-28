# Storage Guide — Ascendra

> **Purpose**: Guidelines for managing file uploads and static assets using Supabase Storage.

---

## 1. Storage Buckets

Ascendra uses distinct buckets for different types of files to manage security and caching effectively.

| Bucket | Visibility | Purpose | Path Structure |
|--------|------------|---------|----------------|
| `avatars` | Public | User profile pictures | `avatars/<user_id>.jpg` |
| `task_proofs` | Private | Images/PDFs uploaded for tasks | `task_proofs/<task_id>/<user_id>_<timestamp>.<ext>` |
| `knowledge_base` | Private | Documents for AI RAG | `knowledge_base/<company_id>/<doc_id>.<ext>` |
| `company_assets` | Public | Company logos, branding | `company_assets/<company_id>/logo.png` |

## 2. Security (Storage RLS)

Private buckets must have Storage RLS policies applied in the database to prevent unauthorized access.

```sql
-- Example: Users can only read task proofs for tasks assigned to them or if they are the leader
create policy "Task proof visibility"
on storage.objects for select
using (
  bucket_id = 'task_proofs' and 
  (
    -- Check if user is assigned to the task
    -- Or if user is the upline leader of the assignee
    public.can_view_task_proof(auth.uid(), (storage.foldername(name))[1]::uuid)
  )
);
```

## 3. Flutter Implementation

### Uploading Files

Use the `image_picker` or `file_picker` packages to get the file, then upload via Supabase.

```dart
Future<String> uploadTaskProof(String taskId, File file, String extension) async {
  final userId = Supabase.instance.client.auth.currentUser!.id;
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final path = '$taskId/${userId}_$timestamp.$extension';
  
  await Supabase.instance.client.storage.from('task_proofs').upload(
    path,
    file,
    fileOptions: const FileOptions(upsert: false),
  );
  
  return path;
}
```

### Retrieving Files

#### Public Buckets (e.g., Avatars)
Store the generated public URL directly in the database (`avatar_url` column).
```dart
final url = _client.storage.from('avatars').getPublicUrl('avatars/$userId.jpg');
```

#### Private Buckets (e.g., Task Proofs)
Store the relative path in the database. When the client needs to display it, generate a signed URL that expires.

```dart
final signedUrl = await _client.storage
    .from('task_proofs')
    .createSignedUrl(proofPath, 3600); // 1 hour expiry
```

## 4. Image Caching

Always use `cached_network_image` to display images from storage to prevent unnecessary network requests and save bandwidth.

```dart
CachedNetworkImage(
  imageUrl: avatarUrl,
  placeholder: (context, url) => const CircularProgressIndicator(),
  errorWidget: (context, url, error) => const Icon(Icons.error),
  fit: BoxFit.cover,
)
```
