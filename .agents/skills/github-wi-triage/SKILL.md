---
name: github-wi-triage
description: analyzes a GitHub issue and produces an implementation plan
---

# General Workflow

1. Read the issue title, description, labels, linked issues, and existing comments.
2. Determine the issue type from its labels, if it does not have a label, try to determine what it is and set the label.
3. Follow the appropriate workflow.
4. Publish the resulting plan as a comment on the GitHub issue.
5. Set the milestone
6. Set the relationships to other tasks
7. Set a priority and an effort

A score is the importance/impact the issue will have. The higher the number the larger the impact. Anything below a 3 is a nice to have.

---

# Improvement Workflow

Applies to issues labelled:

- improvement
- enhancement
- feature

Read IMPROVEMENT.md

---

# Bug Workflow

Applies to issues labelled:

- bug

Read BUG.md

---

# Security Workflow

Applies to issues labelled:

- security
- vulnerability
- authentication
- authorization


Read SECURITY.md

# Documentation Workflow

Applies to issues labelled:

- documentation
- docs

Read DOCUMENTATION.md

---

# Infrastructure Workflow

Applies to issues labelled:

- infrastructure
- devops
- deployment
- ci
- cd
- operations

Read INFRASTRUCTURE.md

---

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

