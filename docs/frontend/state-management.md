# State Management

## Purpose
Riverpod architecture.

## Provider Hierarchy
```text
Repository
↓
Provider
↓
Widget
```

## Rules
* Providers never know UI.
* Widgets never know repositories.
* Repositories never know Flutter.

## AsyncValue
Every async screen uses:
```dart
AsyncValue.when()
```

## Refresh Rules
* Initial load
* Pull-to-refresh
* Resume app

## Cache
**Dashboard**
* 5 minute TTL
* Resume refresh
* Manual refresh
* Bootstrap prefetch

## Error Handling
```text
Repository
↓
Provider
↓
AsyncError
↓
Error Widget
↓
Retry
```

## Logging
Every RPC logs:
* duration
* success
* exception
* user
* company
