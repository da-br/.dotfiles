---
name: pr-review-audit
description: Reviews PRs merged in the last 24 hours for security, maintenance, and performance concerns, considered against the broader codebase, and files a GitHub issue per genuine finding. Use when asked to audit recent PRs, run a daily/nightly review, or invoked as /pr-review-audit.
---

# Purpose

Audit the last 24 hours of merged PRs across three lenses — security, maintenance,
performance — and file a GitHub issue for each genuine finding. Findings are optional:
a run that surfaces nothing is a correct, successful run. Never invent a finding to
have something to report.

# Step 1 — Resolve repo

Determine `OWNER/REPO` from the cwd's git remote (`git remote get-url origin`, or
`gh repo view --json nameWithOwner`). If cwd is not a git repo or has no recognizable
GitHub remote, stop and ask the user which repo to target.

# Step 2 — Collect merged PRs in the last 24 hours

Compute the window start as `now - 24h` in ISO 8601 (UTC). Use `gh` to list PRs merged
at or after that timestamp — check `gh pr list --help` / `gh search prs --help` for the
exact merged-date query syntax (search qualifiers evolve; see the `github-cli` skill
for general `gh` patterns). Fetch at minimum: number, title, url, mergedAt, author,
baseRefName, and changed files.

If zero PRs merged in the window: report that clearly to the user and **stop**. Do not
proceed to the review steps, do not create issues, do not fabricate findings.

# Step 3 — Gather context per PR

For each merged PR:

- Pull its diff (`gh pr diff <n>`).
- Pull its description/body — it often states intent, which matters for judging
  whether a change is a deliberate tradeoff vs. an oversight.
- Read enough of the surrounding codebase (not just the diff hunks) to judge the
  change in the context of existing patterns, architecture, and conventions —
  e.g. does this change match how error handling / auth / caching is done
  elsewhere, does it touch a hot path, does it introduce a pattern the project
  has otherwise avoided. A diff-only review misses this; that context is the
  point of this skill.

If there are many PRs, batch this efficiently (e.g. one Explore agent per PR or per
small group) rather than reading everything in the main thread.

# Step 4 — Run the three reviews

Run these three passes. They are independent lenses over the *same* set of merged
PRs and gathered context, not a pipeline — run them in parallel (e.g. three
`general-purpose` Agent calls in a single message) for speed.

1. Security — follow `SECURITY.md`
2. Maintenance — follow `MAINTENANCE.md`
3. Performance — follow `PERFORMANCE.md`

Each pass must explicitly consider the broader project scope (existing conventions,
adjacent code, prior art in the repo), not just the raw diff. Each pass reports a list
of findings (possibly empty). Every finding must be genuine and specific — tied to an
actual line, file, or behavior change in one of the reviewed PRs. Do not report
stylistic nitpicks, hypothetical concerns with no evidence in the change, or anything
already flagged in the PR's own review comments.

# Step 5 — File issues

For each genuine finding, create exactly one GitHub issue:

```
gh issue create --repo OWNER/REPO \
  --title "<concise, specific title>" \
  --body "<description>" \
  --label "<label>"
```

Labels (verbatim, do not correct the spelling):

- Security findings → `review:security`
- Maintenance findings → `review:maintance`
- Performance findings → `review:performace`

Before filing, confirm the label exists on the repo (`gh label list --repo OWNER/REPO
--search "<label>"`); if missing, create it (`gh label create <label> --repo OWNER/REPO
--color <hex> --description "..."`) rather than letting issue creation fail.

Each issue body should include:

- **What**: the specific problem, in the specific file/PR.
- **Why it matters**: concrete impact (what breaks, degrades, or becomes risky),
  not generic boilerplate.
- **Where**: link to the PR and the file/line.
- **Suggested fix**: a concrete direction, not "consider improving this."

Do not file an issue for something already tracked by an open issue — search first
(`gh issue list --repo OWNER/REPO --search "<keyword>"`) and skip duplicates.

# Step 6 — Summarize

Report to the user: how many PRs were reviewed, how many findings per category, and a
link to each issue created. If a category had no findings, say so plainly — that is a
normal, good outcome, not a gap to fill.
