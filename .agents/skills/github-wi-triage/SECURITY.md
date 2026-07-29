## Step 1 – Understand the Risk

Read the issue carefully.

Determine:

- What vulnerability or risk is being addressed?
- What assets or systems are affected?
- Who could exploit it?
- What is the potential impact?
- Has this issue already been exploited?

Clearly distinguish between confirmed facts and assumptions.

---

## Step 2 – Assess Severity

Document:

- Risk level
- Impact
- Likelihood
- Affected users or systems
- Temporary mitigations (if any)

If the severity is unclear, document why.

---

## Step 3 – Produce a Remediation Plan

Create an implementation plan that includes:

- Components affected
- Security controls to implement
- Authentication or authorization changes
- Configuration changes
- Database or secret changes
- Logging and auditing improvements
- Testing strategy
- Rollout considerations

Avoid writing code.

---

## Step 4 – Adversarial Review

Spawn an adversarial reviewer.

Challenge the proposal by looking for:

- New attack surfaces
- Privilege escalation risks
- Missing validation
- Insecure defaults
- Backwards compatibility concerns
- Information leakage
- Incomplete mitigations
- Failure scenarios

---

## Step 5 – Refine

Update the remediation plan based on the review.

Document any remaining risks.

---

## Step 6 – Publish

Post the final remediation plan as a comment on the GitHub issue.

The comment should contain:

1. Summary of the risk
2. Impact assessment
3. Proposed remediation
4. Risks
5. Testing strategy
6. Outstanding questions

Implementation should only begin once the remediation plan has been reviewed.


