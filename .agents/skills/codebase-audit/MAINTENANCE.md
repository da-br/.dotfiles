# Maintenance Review

Review the entire codebase for genuine maintainability concerns — things that cost
the team real time, not stylistic preference. A whole-repo sweep will surface many
imperfections; report only the ones with real ongoing cost.

Look for, in the context of the codebase's own existing patterns:

- Duplicated logic across modules that should share one implementation — especially
  copies that have already drifted apart.
- Multiple competing patterns for the same problem (e.g. three ways of doing config,
  error handling, or data access) with no documented reason — increases the cost of
  every future change.
- Missing or inadequate tests for non-trivial, load-bearing behavior — especially
  core paths where a regression would be caught late.
- Dead code, unused exports, stale feature flags/config, or commented-out blocks left
  with no cleanup path.
- Sprawling modules/functions whose size or complexity actively obstructs the changes
  the project is actually making (not just "this file is big").
- Undocumented non-obvious behavior: workarounds, subtle invariants, or a "why" that
  isn't captured anywhere and will confuse the next person touching it.
- Tight coupling between modules that should be independent, making changes riskier.
- Configuration, magic numbers, or environment-specific values hardcoded where the
  rest of the project centralizes such things.
- Public APIs/interfaces with breaking-change risk and no deprecation path, when the
  project otherwise maintains one.
- Stale or misleading docs/comments that contradict the code they describe.

Compare against existing conventions in the repo — if the code follows established
patterns, that's not a finding. Flag real future cost, not taste, and not a census of
every minor inconsistency.

If nothing rises to a genuine, explainable concern: report no findings. That is a
correct and expected outcome.
