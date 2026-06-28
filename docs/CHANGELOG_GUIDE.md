# Changelog Guide — Ascendra

> **Purpose**: Instructions for maintaining the `CHANGELOG.md` file in the project root.

---

## 1. Format

Ascendra strictly follows the [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) format.

### Categories
For each version release, group changes into the following categories:
- `Added`: For new features.
- `Changed`: For changes in existing functionality.
- `Deprecated`: For soon-to-be removed features.
- `Removed`: For now removed features.
- `Fixed`: For any bug fixes.
- `Security`: In case of vulnerabilities.

## 2. Example Entry

```markdown
## [1.2.0] - 2023-10-25

### Added
- Image and PDF upload support for task proofs.
- Materialized views for faster dashboard loading.
- Leaderboard widget in the Member Profile Recognition tab.

### Changed
- Replay data aggregation moved to the backend (RPC `get_meeting_replay_view_model`).
- Upgraded `flutter_riverpod` to `^2.6.1`.

### Fixed
- Infinite redirect loop when session expires while offline.
- Overflow errors on iPhone SE in the Task Command Center.
```

## 3. When to Update

- **Developers**: Do NOT update the `CHANGELOG.md` in individual feature branches.
- **Release Managers (or AI Agents preparing a release)**: Update the changelog right before bumping the version number in `pubspec.yaml` and cutting the release branch.
- Summarize the commit history (using the `feat:` and `fix:` tags from Conventional Commits) to generate the changelog entries.
