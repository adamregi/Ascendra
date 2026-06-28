# Plugin Index — Ascendra

> **Purpose**: A directory of available plugins and MCP servers, including capabilities and selection rules.

---

## 1. Supabase MCP

**Capabilities:**
- Database schema inspection (`list_tables`, `execute_sql`)
- Database migrations (`list_migrations`, `apply_migration`)
- Edge Function management (`list_edge_functions`, `deploy_edge_function`)
- Project configuration (`get_project`, `list_projects`)

**When to Automatically Use:**
- When a task requires writing or debugging SQL.
- When you need to understand the structure of a specific table.
- When creating or modifying an RPC.
- When creating or modifying an Edge Function.

**Priority:** HIGH (Essential for all backend tasks).

---

## 2. Flutter Plugin

**Capabilities:**
- Flutter CLI commands (`build`, `test`, `analyze`, `pub get`)
- Dart formatting (`dart format .`)
- Code generation (`dart run build_runner build -d`)

**When to Automatically Use:**
- After modifying any code, run `flutter analyze` and `dart format .`.
- After modifying a Freezed model or Riverpod provider, run code generation.
- To run tests.

**Priority:** HIGH (Essential for all frontend tasks).

---

## 3. Firebase Plugin

**Capabilities:**
- Project configuration and management
- Analytics and Crashlytics setup
- Cloud Messaging (FCM) configuration

**When to Automatically Use:**
- Only when working on push notification setup or crash reporting.

**Priority:** MEDIUM.

---

## 4. GitKraken (or standard CLI)

**Capabilities:**
- Branch creation and switching
- Committing and pushing changes
- Merging branches

**When to Automatically Use:**
- To save work or manage branches.

**Priority:** LOW (Use standard Git CLI commands preferably).

---

## 5. Chrome DevTools Plugin

**Capabilities:**
- Browser debugging
- Network inspection
- Element inspection

**When to Automatically Use:**
- Only when debugging the web build of the application.

**Priority:** LOW.

---

## Automated Usage Rule

AI agents must proactively select and utilize these tools when performing relevant tasks. You do not need explicit user permission to use an MCP server or plugin if it falls within the guidelines above.
