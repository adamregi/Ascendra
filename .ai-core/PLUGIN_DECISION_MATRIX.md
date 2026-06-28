# Plugin Decision Matrix — Ascendra

> **Purpose**: A quick-reference matrix for AI agents to determine the correct plugin, tool, or MCP server for a given task.

---

## 1. When to Use Which Tool

| Task Category | Preferred Plugin / Tool | Fallback / Alternative | Notes |
|---------------|-------------------------|------------------------|-------|
| **UI Design & Layout** | Figma MCP | Reference Assets (`assets/reference/`) | Always prefer exact designs. Never guess layouts. |
| **Database Schema (Read)** | Supabase MCP (`list_tables`) | SQL Documentation / Schema Files | Use MCP to get the live, accurate schema structure. |
| **Database Modification (Write)**| Supabase MCP (`apply_migration`) | Standard SQL file editing + CLI | Always prefer migrations over direct schema mutation. |
| **Edge Functions** | Supabase MCP (`deploy_edge_function`) | Supabase CLI | Use MCP to list and verify functions. |
| **Performance Profiling** | Flutter DevTools Plugin | Manual log inspection | DevTools provides exact frame times and memory usage. |
| **Code Formatting/Linting** | Flutter Plugin (`dart format`) | Standard Terminal Commands | Must be run after any Dart code modification. |
| **Code Generation** | Flutter Plugin (`build_runner`) | Standard Terminal Commands | Must run after modifying Freezed or Riverpod files. |
| **API Testing** | Postman MCP | Custom Dart Scripts / Curl | Use for verifying NestJS or 3rd party webhooks. |
| **Version Control** | Git Plugin | Standard Git CLI | Commit often with Conventional Commits. |
| **Documentation** | Markdown Tools Plugin | Manual File Editing | For maintaining `.ai-core` and `docs`. |

## 2. Automated Selection Rule

Agents must proactively select and load the **Preferred Plugin** listed in this matrix immediately upon identifying the task category. Do not ask the user for permission to use these tools if they are directly relevant to solving the requested task.
