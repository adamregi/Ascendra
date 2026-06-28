# Feature to Plugin Map — Ascendra

> **Purpose**: Maps task categories to relevant plugins and MCP servers. AI agents use this to automatically discover which tools to leverage.

---

## Plugin Mapping

### Database & Backend Operations
**Plugin/MCP**: Supabase MCP
**Tools**: `execute_sql`, `list_tables`, `apply_migration`, `deploy_edge_function`
**When to use**: 
- Creating new RPCs
- Checking database schema
- Applying migrations
- Modifying Edge Functions

### Authentication
**Plugin/MCP**: Supabase MCP
**Tools**: `get_project`, `execute_sql`
**When to use**:
- Investigating auth schema (`auth.users`)
- Checking auth settings

### UI/Frontend Operations
**Plugin/MCP**: Flutter Plugin
**Tools**: `flutter build`, `flutter test`, `flutter analyze`
**When to use**:
- Building the app
- Running tests
- Static analysis

### Source Control
**Plugin/MCP**: GitKraken (or standard CLI)
**Tools**: `create_branch`, `merge_branch`
**When to use**:
- Creating feature branches
- Pushing commits

### Cloud Functions / Edge
**Plugin/MCP**: Supabase MCP
**Tools**: `list_edge_functions`, `deploy_edge_function`
**When to use**:
- Updating AI Assistant backend logic
- Notification routing

## Automated Selection Rules

When a task involves:
1. **Database schema or SQL**: ALWAYS use the Supabase MCP.
2. **Flutter UI/State**: Focus on `core/`, `shared/`, and `features/` files. The Supabase MCP is generally NOT needed for Flutter UI work unless you need to check an RPC signature.
3. **Running the app**: Use standard Flutter CLI commands.

---

*AI Note: Do not wait for user instruction to use an MCP server if it clearly applies to the task based on this mapping.*
