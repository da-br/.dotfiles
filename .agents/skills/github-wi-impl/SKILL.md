---
name: github-wi-impl
description: works on a github work item
---

# General Workflow

1. Read the issue title, description, labels, linked issues, and existing comments.
2. Determine if the issue has been triaged, if it hasn't triage it first using github-wi-triage
3. Begin work on the wi.
4. Publish a PR with the work. Used stacked PRs when applicable
5. Review the PR using github-pr
6. Address all comments, marking them resolved as needed.
7. Once the PR is merged, cleanup the remote branch(s)

# General Rules

- Never jump directly into coding.
- Always understand the problem before proposing a solution.
- Explicitly identify assumptions.
- State uncertainty rather than guessing.
- Prefer simple solutions over complex ones.
- Make plans concrete and actionable.
- Consider maintainability from the beginning.
- Consider testing during planning, not afterwards.
- Consider rollback and deployment risks.
- The adversarial review is mandatory.
- If the issue description is ambiguous or incomplete, stop and request clarification instead of making assumptions.

