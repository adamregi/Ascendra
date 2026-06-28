# Settings Guide — Ascendra

> **Purpose**: Managing company-wide configurations and user preferences.

---

## 1. Company Settings

Only users with the `leader` role can access Company Settings. These settings affect all users in the tenant.

### Core Settings
- **Branding**: Uploading logos, changing primary colors (stored in `company_assets` and `companies` table).
- **Compliance Rules**: Adjusting thresholds for warnings and suspensions (stored in `compliance_rules`).
- **Subscription**: Upgrading or downgrading plans (managed via external provider, synced to `companies.plan_tier`).

## 2. Compliance Rules Configuration

The `compliance_rules` table holds JSONB definitions of what constitutes a violation for that specific company.

```json
{
  "attendance_threshold_percent": 70,
  "task_overdue_penalty_points": 5,
  "inactive_days_warning": 14
}
```

When NestJS evaluates a member, it pulls these rules first. Flutter provides a UI to edit this JSON indirectly via sliders and text fields.

## 3. User Preferences

Individual user preferences (like notification settings) are stored in the `profiles` table in a `preferences` JSONB column.

```json
{
  "push_notifications_enabled": true,
  "email_notifications_enabled": false,
  "theme_mode": "system"
}
```

## 4. State Management for Settings

Settings are fetched via Riverpod and cached. When a setting is updated (e.g., toggling a switch):

1. The UI calls the provider's update method.
2. The provider sets its state to `AsyncLoading`.
3. The provider calls the repository to update Supabase.
4. On success, the provider invalidates itself or updates its local state with the new value.

```dart
Future<void> togglePushNotifications(bool value) async {
  state = const AsyncLoading();
  state = await AsyncValue.guard(() async {
    await repository.updatePreferences({'push_notifications_enabled': value});
    return (state.value!).copyWith(pushNotificationsEnabled: value);
  });
}
```
