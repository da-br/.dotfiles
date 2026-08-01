# Performance Review

Review the merged PRs and their surrounding context for genuine performance
concerns. Only report something backed by a concrete mechanism (an actual
algorithmic, I/O, or resource cost), not a vague feeling that something "might be
slow."

Look for, in the context of the broader codebase's existing patterns:

- New N+1 query patterns, or a loop that now issues a DB/network call per iteration
  where a batched call was possible (especially if the rest of the codebase already
  batches equivalent calls).
- Algorithmic complexity regressions: a change that moves an operation from O(n) to
  O(n^2) or worse on data that can realistically grow.
- Unbounded growth: caches, in-memory collections, or logs with no eviction/limit on
  a path that runs repeatedly or on user-controlled input.
- New synchronous/blocking calls on a hot path (request handler, render loop, tight
  loop) where the rest of the codebase uses async/non-blocking equivalents.
- Large payloads: fetching/serializing more data than the code path needs (missing
  pagination, missing field selection) where the project elsewhere paginates or
  projects fields.
- Redundant work: recomputation of a value already available, repeated
  parsing/serialization of the same data within a request/operation.
- Resource leaks: connections, file handles, timers, or subscriptions opened without
  a corresponding close/cleanup on all code paths (including error paths).
- Regressions to existing benchmarks, load-bearing caches, or documented performance
  budgets, if the project tracks any.

Compare against how equivalent code elsewhere in the project already handles cost —
if the new code matches existing patterns (including existing tradeoffs the project
has already accepted), that's not a finding. Flag regressions and new risk, not
theoretical inefficiency with no realistic impact.

If nothing rises to a genuine, explainable concern: report no findings. That is a
correct and expected outcome for most runs.
