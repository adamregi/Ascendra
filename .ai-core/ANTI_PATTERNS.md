# AI Anti-Patterns — Ascendra

> **Purpose**: A critical list of forbidden practices. AI agents must NEVER execute these actions.

---

## 1. Flutter Anti-Patterns

### 🚫 Business Logic Inside UI
**Forbidden**: Calculating compliance scores, filtering lists manually, or determining authentication state directly inside a widget's `build` method.
**Why**: Violates Clean Architecture. UI must be dumb and only display what the Provider/ViewModel tells it to display.

### 🚫 Direct Supabase Calls from UI
**Forbidden**: Calling `Supabase.instance.client.from('...').select()` inside a `FutureBuilder` within a Widget.
**Why**: Tightly couples the UI to the database schema, making it impossible to test or mock, and bypassing the Repository layer.

### 🚫 Nested FutureBuilders / StreamBuilders
**Forbidden**: Nesting multiple asynchronous builders in the UI.
**Why**: Leads to unreadable "pyramid of doom" code and redundant network calls. Use Riverpod's `AsyncValue.when` or combine streams in the Provider layer instead.

### 🚫 Magic Numbers for Styling
**Forbidden**: Using `Color(0xFF...)`, `padding: EdgeInsets.all(12)`, or `fontSize: 18`.
**Why**: Breaks the Serene Modernist design system. Always use `AppColors`, `AppSpacing`, and `AppTypography`.

### 🚫 Duplicating Components
**Forbidden**: Copy-pasting a button or card design instead of using `AppButton` or `AppCard`.
**Why**: Creates massive tech debt when the design system needs to be updated. Check `COMPONENT_CATALOG.md` first.

## 2. Backend & Data Anti-Patterns

### 🚫 Local KPI Calculations
**Forbidden**: Fetching thousands of rows (e.g., all tasks) to the Flutter client just to calculate a completion percentage.
**Why**: Destroys app performance and eats bandwidth. KPIs MUST be calculated on the backend via PostgreSQL Materialized Views.

### 🚫 Manual JSON Parsing
**Forbidden**: Writing `user.firstName = json['first_name']` manually.
**Why**: Error-prone and fragile. Always use `@freezed` and `@JsonSerializable()` to generate `fromJson` methods.

### 🚫 Bypassing RLS
**Forbidden**: Writing an RPC with `security definer` just to avoid writing a proper RLS policy.
**Why**: Massive security vulnerability. Only use `security definer` when absolutely necessary (e.g., auth resolution before login).

## 3. Workflow Anti-Patterns

### 🚫 Ignoring Reference UIs
**Forbidden**: Inventing a new screen layout without checking `assets/reference/`.
**Why**: Leads to inconsistent user experiences.

### 🚫 Skipping Skills
**Forbidden**: Attempting to implement a complex feature (like video calling or RAG) without first querying the `.ai-core/SKILL_CATEGORIES.md` and loading the specific `SKILL.md` file.
**Why**: Bypasses the project's accumulated knowledge base and leads to subpar, generic implementations.

### 🚫 Creating Components Without Searching
**Forbidden**: Creating a new UI widget without first using `grep_search` in `lib/shared/widgets/`.
**Why**: Bloats the codebase with redundant widgets.
