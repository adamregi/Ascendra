# AI Change Impact Analysis — Ascendra

> **Purpose**: A pre-edit questionnaire that AI agents MUST answer before modifying existing code to predict the blast radius of the proposed changes.

---

## The Impact Questionnaire

Before executing `run_command` (sed) or `replace_file_content` on an existing file, generate a brief scratchpad answering the following:

### 1. Module Impact
*Which modules are directly and indirectly affected?*
- Check `docs/FEATURE_DEPENDENCY_MATRIX.md`. If you are editing `members`, you might break `dashboard`.

### 2. Provider Impact
*Which Riverpod providers depend on this file?*
- Run `grep_search` on the file name to see which providers import it.
- If editing a `Repository`, expect all connected `Providers` to require a refactor.

### 3. RPC Impact
*Does this change the JSON contract?*
- If adding a field to a Freezed model, does the backend RPC in `supabase/migrations/` supply that field?
- If modifying an RPC, does the `json_build_object` match the expected Freezed DTO?

### 4. Test Impact
*Which tests will this break?*
- Check `test/features/<module>/`. If you add a required parameter to a widget, the widget tests will fail to compile.

### 5. Documentation Impact
*Which metadata files need updating?*
- See `.ai-core/DOC_GENERATION.md`. Are you adding a new RPC or shared widget?

### 6. Quality Gate Impact
*Does this change risk violating a rule in `ARCHITECTURAL_RULES.yaml`?*
- e.g., Are you passing a `BuildContext` down to a provider? Are you hardcoding a color?

---
*By answering these questions, you transition from reactive debugging to proactive engineering.*
