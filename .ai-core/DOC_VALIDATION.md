# Documentation Validation Rules — Ascendra

> **Purpose**: Defines the rules for the documentation linter to ensure high-quality, self-consistent documentation across the AI Operating System.

---

## 1. Validation Checks

A future script (or AI validation pass) will enforce the following invariants across the repository.

### Integrity Checks
- **Broken Links**: Ensure every internal Markdown link (`[]()`) resolves to an existing file.
- **Cross-References**: Ensure `PROJECT_MANIFEST.md` references all core docs in `.ai-core/` and `docs/`.

### Completeness Checks
- **Feature Registration**: Every directory in `lib/features/` must have a corresponding entry in `.ai-core/data/features.json` and `.ai-core/FEATURE_REGISTRY.md`.
- **RPC Registration**: Every RPC in `supabase/migrations/` must be cataloged in `.ai-core/data/rpc_catalog.json` and `docs/API_REFERENCE.md`.
- **Quality Gates**: Every feature branch must contain a validation tick for the `QUALITY_GATES.md`.

### Alignment Checks
- **JSON to Markdown Sync**: The data in `.ai-core/data/*.json` MUST perfectly align with the human-readable Markdown explanations in `docs/MODULE_CONTRACTS.md` and `.ai-core/FEATURE_REGISTRY.md`.

## 2. Running Validation (Manual for now)

When requested to "Validate Documentation", an AI agent must:
1. Parse `.ai-core/data/features.json`.
2. Compare the JSON list against the actual directories in `lib/features/`.
3. Read `PROJECT_MANIFEST.md` and verify all internal links are alive.
4. Report any missing features, undocumented RPCs, or broken links.
