# Performance Review

Review the entire codebase for genuine performance concerns. Only report something
backed by a concrete mechanism (an actual algorithmic, I/O, or resource cost on a
path that matters), not a vague feeling that something "might be slow."

Look for, in the context of the codebase's own existing patterns:

- N+1 query patterns, or loops issuing a DB/network call per iteration where a
  batched call is possible (especially if the rest of the codebase already batches
  equivalent calls).
- Algorithmic complexity problems: O(n^2) or worse on data that can realistically
  grow, on paths that actually run at that scale.
- Unbounded growth: caches, in-memory collections, queues, or logs with no
  eviction/limit on paths that run repeatedly or on user-controlled input.
- Synchronous/blocking calls on hot paths (request handlers, render loops, tight
  loops) where the rest of the codebase uses async/non-blocking equivalents.
- Large payloads: fetching/serializing more data than the code path needs (missing
  pagination, missing field selection) where the project elsewhere paginates or
  projects fields.
- Redundant work at scale: recomputation of values that could be cached, repeated
  parsing/serialization of the same data within a request/operation.
- Resource leaks: connections, file handles, timers, or subscriptions opened without
  a corresponding close/cleanup on all code paths (including error paths).
- Missing indexes or query patterns that full-scan tables that can realistically grow
  (where the schema/migrations are visible in the repo).
- Regressions to documented performance budgets, benchmarks, or load-bearing caches,
  if the project tracks any.

Weigh the path: a slow query in an admin script run monthly is not the same as one in
a per-request handler. Compare against how equivalent code elsewhere in the project
handles cost — if the code matches existing patterns (including tradeoffs the project
has already accepted), that's not a finding. Flag real risk, not theoretical
inefficiency with no realistic impact.

If nothing rises to a genuine, explainable concern: report no findings. That is a
correct and expected outcome.
