# Security Review

Review the merged PRs and their surrounding context for genuine security concerns.
This is not a generic OWASP checklist recital — only report something if you can point
to the specific line/behavior and explain the concrete exploit or exposure.

Look for, in the context of the broader codebase's existing patterns:

- New or modified handling of user input that skips validation/sanitization the rest
  of the codebase applies (injection: SQL, command, template, path traversal).
- Auth/authorization changes: new endpoints or code paths missing checks that
  equivalent existing endpoints have; privilege checks moved, weakened, or removed.
- Secrets or credentials: hardcoded keys/tokens, secrets logged, secrets committed to
  config checked into the repo.
- Cryptography: weak/deprecated algorithms, home-rolled crypto, insecure randomness
  for security-sensitive values (tokens, IDs used as capabilities).
- Deserialization of untrusted data, unsafe `eval`/dynamic code execution.
- New dependencies: anything unusually obscure, unmaintained, or with a broad known
  CVE footprint introduced without justification.
- Expanded attack surface: newly exposed endpoints, opened ports, relaxed CORS/CSP,
  disabled TLS verification, permissive file/network permissions.
- Sensitive data handling: PII or credentials now logged, cached, or sent somewhere
  new (third-party API, analytics) without evident review.
- Changes to CI/CD, build scripts, or automation that could allow supply-chain
  tampering (unpinned dependencies pulled at build time, curl-pipe-to-shell patterns).

Compare against how the rest of the project already handles the same concern — if the
codebase has an established auth-check pattern and the new code follows it, that's not
a finding even if it looks unusual in isolation. Flag deviations, not conventions.

If nothing rises to a genuine, explainable concern: report no findings. That is a
correct and expected outcome for most runs.
