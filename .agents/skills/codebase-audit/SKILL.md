---
name: codebase-audit
description: Audits the entire codebase for security, maintenance, and performance concerns, and files a GitHub issue per genuine finding. Use when asked to audit/review the whole codebase, run a full code health check, or invoked as /codebase-audit.
---

# Purpose

Audit the *entire* codebase (not a diff) across three lenses — security, maintenance,
performance — and file a GitHub issue for each genuine finding. Findings are optional:
a run that surfaces nothing is a correct, successful run. Never invent a finding to
have something to report.

This is the whole-repo counterpart of `pr-review-audit`. The difference in kind: a
codebase-wide sweep can surface far more findings than a 24h PR window, and old issues
may be long-known and accepted. Bias hard toward signal: report only problems with a
concrete mechanism and real impact, not a census of every imperfection.

# Step 1 — Resolve repo

Determine `OWNER/REPO` from the cwd's git remote (`git remote get-url origin`, or
`gh repo view --json nameWithOwner`). If cwd is not a git repo or has no recognizable
GitHub remote, stop and ask the user which repo to target.

# Step 2 — Map the codebase

Before reviewing, build a working map of the project:

- Identify the stack and layout: manifests/lockfiles, top-level directories, entry
  points, test layout, CI config.
- Partition the project into reviewable **areas** — coherent modules/directories that
  can be audited independently (e.g. `src/auth`, `src/api`, `src/db`, `web/`,
  `ci/`). Aim for areas small enough for one agent to review thoroughly.
- Identify the load-bearing areas: request handlers / entry points, auth and
  authorization boundaries, data-access layer, hot paths, anything handling secrets
  or user input, build/deploy automation.
- Note project conventions (how errors, auth, caching, config are handled) — findings
  are judged against these, not against generic best practice.

Keep this map compact (a page, not an essay). It exists to route the review passes to
the right files.

# Step 3 — Filter by recency

For each mapped area, check whether anything under it changed in the last 7 days:

```
git log --since="7 days ago" --name-only --pretty=format: -- <area-path> | sort -u
```

Areas with **no changes in the last week are skipped** — do not review them. Record
them as skipped in the final summary so the user knows what was and wasn't covered.

Caveats that override the skip:

- First-ever run on a repo (no prior audit to compare against): ask the user whether
  to review everything anyway or apply the filter. Default to the filter if they
  don't care.
- Cross-cutting changes: if a shared dependency (lockfile, shared util, base config,
  CI) changed, include the areas that depend on it even if their own files are
  untouched.
- If *every* area is unchanged, report that plainly and stop — no reviews, no issues.

# Step 4 — Run the reviews (fan-out per area × lens)

For each **surviving area**, run one subagent per review lens — i.e. an
area × lens grid of parallel review agents:

1. Security — follow `SECURITY.md`
2. Maintenance — follow `MAINTENANCE.md`
3. Performance — follow `PERFORMANCE.md`

Each agent gets: the area's scope (files/dirs), the codebase map for context, the
lens file to follow, and (where relevant) the recent diff for that area
(`git log --since="7 days ago" -p -- <area-path>`) so it knows what's fresh. Launch
the grid in parallel batches rather than reading everything in the main thread.

Every finding must be genuine and specific — tied to an actual file, line, or
behavior in the codebase, with a concrete impact mechanism. Do not report stylistic
nitpicks, hypothetical concerns with no evidence, or deviations from generic best
practice that match the project's own established conventions.

# Step 5 — Merge and triage findings

Merge the per-agent results into one list before filing:

1. Deduplicate: the same problem surfaced by multiple agents (same file/line, or a
   security and a maintenance take on one root cause) becomes **one** issue.
2. Rank by severity/impact and drop anything that is genuinely trivial or clearly an
   accepted tradeoff documented in the repo (comments, ADRs, README).
3. If more than ~10 findings survive, stop and present the ranked list to the user,
   and ask which to file — do not open a flood of issues unprompted.

# Step 6 — File issues

For each genuine finding (or each user-approved finding, if Step 5.3 applied), create
exactly one GitHub issue:

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

- **What**: the specific problem, in the specific file/line.
- **Why it matters**: concrete impact (what breaks, degrades, or becomes risky),
  not generic boilerplate.
- **Where**: the file/line (permalink to the default branch where useful).
- **Suggested fix**: a concrete direction, not "consider improving this."

Do not file an issue for something already tracked by an open issue — search first
(`gh issue list --repo OWNER/REPO --search "<keyword>"`) and skip duplicates.

# Step 7 — Summarize

Report to the user: the scope reviewed (areas covered, and which were skipped as
unchanged), how many findings per category, and a link to each issue created. If a
category had no findings, say so plainly — that is a normal, good outcome, not a gap
to fill.
