# Skill Index — Ascendra

> **Purpose**: Instructions for AI agents on how to discover, load, and apply skills from the `Skills/` directory.

---

## 1. What Are Skills?

Skills are specialized instruction documents located in the `Skills/skills/` directory. There are over 24,000 skills available covering everything from Flutter UI implementation to PostgreSQL optimizations.

They are NOT hardcoded in the `AGENTS.md` manual. You must actively discover them.

## 2. When to Look for Skills

You MUST search for skills at the beginning of EVERY new implementation task. 

## 3. How to Discover Skills

1. Analyze the user's request to determine the required technologies and tasks.
2. Formulate search terms (e.g., `riverpod`, `supabase`, `responsive`, `rpc`).
3. Consult `.ai-core/FEATURE_TO_SKILL_MAP.md` for recommended skill searches based on the feature.
4. Execute a search against the `Skills/skills/` directory.

## 4. How to Load and Read Skills

Once you identify relevant skills:
1. Locate the `SKILL.md` file within the specific skill directory.
2. Read the entire file to understand the specific instructions, patterns, and code examples provided.
3. If the skill references external resources (like `scripts/` or `examples/`), inspect those as well if necessary.

## 5. Applying Skills

1. **Synthesize**: Combine the guidance from the loaded skills.
2. **Resolve Conflicts**: If a skill conflicts with `AGENTS.md` or `.ai-core/AI_RULES.md`, the project manual (`AGENTS.md`/`AI_RULES.md`) always wins.
3. **Implement**: Write the code following the synthesized guidance.

## 6. Example Workflow

User requests: *"Create a new member profile page with a sticky hero section."*

1. **Analyze**: Task involves UI, layout, and member profile.
2. **Search**: Search for `responsive`, `mobile-design`, `flutter-expert`.
3. **Read**: Open and read the matching `SKILL.md` files.
4. **Implement**: Build the page using the loaded guidelines alongside Ascendra's Serene Modernist design tokens.

---

*AI Note: The discovery and application of skills must be automatic. Do not ask the user for permission to search for skills.*
