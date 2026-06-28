# Git Workflow — Ascendra

> **Purpose**: Standard procedures for version control and collaboration.

---

## 1. Branching Strategy

Ascendra uses a simplified feature-branch workflow.

- `main`: The production-ready codebase. Deploys to Production.
- `staging`: The pre-production integration branch. Deploys to Staging.
- `feature/<name>`: For new features (e.g., `feature/task-comments`).
- `bugfix/<name>`: For non-critical bug fixes.
- `hotfix/<name>`: For critical production bugs. Branches off `main`.

## 2. Commit Messages

We follow Conventional Commits.

**Format:**
`<type>(<scope>): <subject>`

**Types:**
- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation only changes
- `style`: Changes that do not affect the meaning of the code (white-space, formatting)
- `refactor`: A code change that neither fixes a bug nor adds a feature
- `test`: Adding missing tests or correcting existing tests
- `chore`: Changes to the build process or auxiliary tools

**Examples:**
- `feat(tasks): add image proof support`
- `fix(auth): resolve infinite redirect loop on login`
- `docs(ai): update RAG architecture diagram`

## 3. Pull Requests & Code Review

1. **Self-Review**: Before opening a PR, the author must use the checklist in `.ai-core/CHECKLISTS.md` to ensure architectural compliance.
2. **CI Pipeline**: All PRs must pass the GitHub Actions CI pipeline, which runs:
   - `flutter analyze`
   - `dart format --set-exit-if-changed .`
   - `flutter test`
3. **Approval**: At least one other developer (or an AI agent acting as a reviewer) must approve the PR.
4. **Squash and Merge**: PRs should be squashed into a single commit when merging to `staging` or `main` to keep the history clean.

## 4. Handling Database Migrations in Git

Database migrations (`supabase/migrations/*.sql`) are strictly chronological.

If two developers create a migration on separate branches concurrently (e.g., `065_add_tasks.sql` and `065_add_meetings.sql`), this will cause a conflict.

**Resolution:**
The second developer to merge must rename their migration file to the next available number (e.g., `066_add_meetings.sql`) before merging.
