# Environment Configuration — Ascendra

> **Purpose**: Details how environments (development, staging, production) are managed, where secrets are stored, and how the app is configured.

---

## 1. Environment Variables

Ascendra uses `--dart-define` for compile-time environment configuration. We do not use `.env` files in the Flutter client for security reasons.

### Required Variables

| Variable | Purpose | Location |
|----------|---------|----------|
| `SUPABASE_URL` | The URL of the Supabase instance | Supabase Dashboard > API |
| `SUPABASE_ANON_KEY` | The public anon key for PostgREST | Supabase Dashboard > API |
| `NESTJS_API_URL` | URL of the NestJS backend (Railway) | Railway Dashboard |
| `ENVIRONMENT` | String: `dev`, `staging`, or `prod` | Build script |

### Example Build Command

```bash
flutter build apk --release \
  --dart-define=SUPABASE_URL=https://your-project.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=eyJhbG... \
  --dart-define=NESTJS_API_URL=https://api.ascendra.app \
  --dart-define=ENVIRONMENT=prod
```

## 2. Configuration Class

In `lib/core/config/app_config.dart`, variables are read using `String.fromEnvironment`:

```dart
class AppConfig {
  static const supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'http://10.0.2.2:54321', // Local emulator fallback
  );
  
  static const supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'eyJhbG...',
  );
  
  static const environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'dev',
  );
  
  static bool get isProd => environment == 'prod';
}
```

## 3. Secret Management

### Client-Side
- The `SUPABASE_ANON_KEY` is **safe to expose** in client code. RLS protects the data.
- **NEVER** include the `SUPABASE_SERVICE_ROLE_KEY` in the Flutter app.
- User session tokens are stored securely using `flutter_secure_storage` (encrypted on Android via Keystore, on iOS via Keychain).

### Backend-Side (Supabase / NestJS)
- Service role keys, Twilio credentials, 100ms secrets, and Gemini API keys are stored as **Edge Function Secrets** or **Railway Environment Variables**.
- Access via `Deno.env.get('SECRET_NAME')` in Edge Functions.
- Access via `process.env.SECRET_NAME` in NestJS.

## 4. Local Development Environment

To run the full stack locally:

1. **Start Supabase**: `supabase start`
2. **Fetch Local Keys**: `supabase status`
3. **Run Flutter against Localhost**:
   - On Android emulator: Use `http://10.0.2.2:54321` (default in `AppConfig`)
   - On iOS simulator/Web: Use `http://127.0.0.1:54321`

*Note: You do not need to pass `--dart-define` for local development if the defaults point to the local emulator.*

## 5. Flavors (Android/iOS)

Currently, Ascendra does not use native Android/iOS flavors (product flavors / schemes). Environment separation is handled purely at compile-time via `--dart-define` and connected to completely separate Supabase projects (Dev vs. Prod).
