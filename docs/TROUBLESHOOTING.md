# Troubleshooting Guide — Ascendra

> **Purpose**: Solutions to common development and production issues in the Ascendra stack.

---

## 1. Flutter Build Issues

### Issue: `build_runner` fails with "Conflicting outputs"
**Cause**: Leftover generated files from a previous run or branch switch.
**Solution**:
```bash
dart run build_runner clean
dart run build_runner build -d
```

### Issue: Android Build Fails (Requires higher compileSdkVersion)
**Cause**: A new Flutter dependency requires a newer Android SDK.
**Solution**:
Open `android/app/build.gradle` and ensure `compileSdkVersion` and `targetSdkVersion` match the requirement (typically 34+ for Ascendra).

## 2. Riverpod State Issues

### Issue: Provider keeps resetting to initial state when navigating back
**Cause**: The provider is auto-disposing because it has no active listeners.
**Solution**:
Ensure you are using the `ref.cacheFor` extension in the provider body.
```dart
ref.cacheFor(const Duration(minutes: 5));
```

### Issue: UI does not update after calling a mutation method
**Cause**: The mutation updated the database, but the local provider state wasn't invalidated.
**Solution**:
After the repository call succeeds, invalidate the provider that feeds the UI.
```dart
ref.invalidate(memberProfileProvider(profileId));
```

## 3. Database & Supabase Issues

### Issue: RPC returns empty or null, but data exists
**Cause**: Row-Level Security (RLS) is blocking the read.
**Solution**:
1. Check the RPC's security definer/invoker setting.
2. Ensure the RLS policy on the target table explicitly allows the `company_id` of the caller.

### Issue: `PostgrestException: function <name> does not exist`
**Cause**: The RPC was created with different parameter names/types than what Flutter is sending.
**Solution**:
Check the exact signature in the database. Ensure Flutter is sending a `Map<String, dynamic>` where keys match the `p_<name>` arguments exactly.

## 4. 100ms Video Issues

### Issue: Cannot join meeting room
**Cause**: The 100ms token is invalid or expired, OR the Edge Function failed to create the room.
**Solution**:
1. Check Supabase Edge Function logs for `schedule-meeting`.
2. Verify that the 100ms Template ID and App Access Key are correctly set in the environment variables.
