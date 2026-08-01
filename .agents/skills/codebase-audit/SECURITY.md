# Security Review

Review the entire codebase for genuine security concerns. This is not a generic OWASP
checklist recital — only report something if you can point to the specific file/line
and explain the concrete exploit or exposure.

Look for, in the context of the codebase's own existing patterns:

- Handling of user input that skips validation/sanitization the rest of the codebase
  applies (injection: SQL, command, template, path traversal, XSS).
- Auth/authorization gaps: endpoints or code paths missing checks that equivalent
  paths have; privilege checks that can be bypassed; insecure defaults.
- Secrets or credentials: hardcoded keys/tokens, secrets logged, secrets committed to
  config checked into the repo.
- Cryptography: weak/deprecated algorithms, home-rolled crypto, insecure randomness
  for security-sensitive values (tokens, IDs used as capabilities).
- Deserialization of untrusted data, unsafe `eval`/dynamic code execution.
- Dependencies: anything unusually obscure, unmaintained, pinned to a version with
  known CVEs, or pulled without pinning/integrity checks.
- Attack surface: exposed endpoints, open ports, permissive CORS/CSP, disabled TLS
  verification, overly broad file/network permissions.
- Sensitive data handling: PII or credentials logged, cached, or sent to third
  parties without evident review; overly verbose error responses leaking internals.
- CI/CD, build scripts, or automation that allows supply-chain tampering (unpinned
  dependencies pulled at build time, curl-pipe-to-shell patterns).

Compare against how the codebase itself already handles the same concern — if it has
an established auth-check pattern and the code follows it, that's not a finding even
if it looks unusual in isolation. Flag deviations and real exposure, not conventions.
Also weigh exploitability: an issue in unreachable internal tooling ranks below one
on an internet-facing path, and may not be worth reporting at all.

If nothing rises to a genuine, explainable concern: report no findings. That is a
correct and expected outcome.
