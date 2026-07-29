---
name: worktree
description: manage worktree
---

- Store all worktrees outside the repository in `../{project}_worktrees/`.
- Name worktrees after the branch (for example `../my-project_worktrees/feature-login`).
- Never create worktrees inside the repository directory.
- Before creating a worktree, fetch the latest remotes and verify the branch does not already have a worktree.
- When asked to **clean**, fetch the default branch, identify worktrees whose branches have been fully merged into the default branch, remove those worktrees, and delete the corresponding local branches. Never delete unmerged worktrees.

