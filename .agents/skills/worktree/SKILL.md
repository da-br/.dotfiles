---
name: worktree
description: manage worktree
---

- Store all worktrees outside the repository in `../{project}_worktrees/`.
- Name worktrees after the branch (for example `../my-project_worktrees/feature-login`); replace `/` in branch names with `-` so the path stays a single directory.
- Never create worktrees inside the repository directory.
- Before creating a worktree, fetch the latest remotes and verify the branch does not already have a worktree (`git worktree list`).
- If a worktree already exists for the branch, reuse it (cd into it) instead of creating a duplicate.
- When asked to **clean**, fetch the default branch (`git fetch --prune`), identify worktrees whose branches have been fully merged into the default branch, remove those worktrees (`git worktree remove`), delete the corresponding local branches, and prune stale remote-tracking branches. Never delete unmerged worktrees.
- After removing a worktree, run `git worktree prune` to clear stale administrative files.
- If a worktree's working tree has uncommitted changes, stop and ask before removing it — never discard uncommitted work silently.

