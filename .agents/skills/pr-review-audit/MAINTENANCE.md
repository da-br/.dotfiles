# Maintenance Review

Review the merged PRs and their surrounding context for genuine maintainability
concerns — things that will cost the team real time later, not stylistic preference.

Look for, in the context of the broader codebase's existing patterns:

- Duplicated logic that already exists elsewhere in the project and should have
  reused an existing function/module instead of copy-pasting.
- New abstractions, patterns, or conventions that diverge from how the rest of the
  codebase solves the same problem, without a stated reason — increases the number
  of ways to do the same thing.
- Missing or inadequate tests for non-trivial new behavior, especially edge cases the
  diff itself suggests were considered (error branches, boundary conditions) but left
  untested.
- Dead code, unused exports, or feature flags/config left permanently on with no
  cleanup path.
- Sprawling functions/files, or a change that pushes an already-strained module past
  a reasonable size/complexity without splitting it.
- Insufficiently documented non-obvious behavior: a workaround, a subtle invariant, or
  a "why" that isn't captured anywhere and will confuse the next person touching it.
- Tight coupling introduced between modules that were previously independent, making
  future changes riskier.
- Configuration, magic numbers, or environment-specific values hardcoded where the
  rest of the project centralizes such things.
- Breaking changes to a public API/interface without a deprecation path, when the
  project otherwise maintains one.

Compare against existing conventions in the repo — if the PR follows established
patterns, that's not a finding. Flag divergence and real future cost, not taste.

If nothing rises to a genuine, explainable concern: report no findings. That is a
correct and expected outcome for most runs.
