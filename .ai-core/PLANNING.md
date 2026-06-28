# AI Planning Guide — Ascendra

> **Purpose**: Teaches AI agents how to plan an implementation before writing a single line of code. Diving straight into code without this process is strictly prohibited.

---

## 1. The Pre-Flight Checklist

Before generating code, an AI agent must construct an `implementation_plan.md` artifact that answers the following:

### Step 1: Complexity Estimation
- Is this a 1-hour UI tweak or a 3-day full-stack feature?
- Will this require backend migrations?
- *Rule*: If complexity is high, stop and ask the user to confirm the architectural approach.

### Step 2: Impact Analysis
- Which modules will this change affect? Check `.ai-core/FEATURE_REGISTRY.md`.
- Will altering this RPC break the dashboard? 
- *Rule*: Never alter shared `lib/shared/` components without checking for regressions globally.

### Step 3: Dependency Analysis
- Does this feature require a new package in `pubspec.yaml`?
- Does it require a new Supabase Edge Function?
- *Rule*: If it introduces a new external dependency, it must be explicitly highlighted to the user.

### Step 4: Risk Assessment
- **Data Loss**: Does this involve dropping a column or table?
- **Security**: Does this modify RLS or `auth.users`?
- **Performance**: Will this add a massive `ListView` or an unoptimized `JOIN`?

### Step 5: Implementation Order
Establish the sequence. Always follow Backend -> Data -> Presentation.
1. `supabase/migrations/`
2. `lib/features/.../data/models/`
3. `lib/features/.../data/repositories/`
4. `lib/features/.../presentation/providers/`
5. `lib/features/.../presentation/pages/`

### Step 6: Testing Strategy
- Will we use `mockito`?
- Are we writing Widget Tests or Unit Tests?
- *Rule*: All non-trivial logic must be paired with tests in `test/`.

### Step 7: Rollback Considerations
- If this migration fails, how do we revert?
- If this UI change causes a crash, what is the fallback?

---
*Once the plan is generated, await user approval before proceeding to implementation.*
