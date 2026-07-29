# Bug Workflow

Applies to issues labelled:

- bug

## Step 1 – Validate the Report

Determine whether there is enough information to investigate.

Required information includes:

- Expected behaviour
- Actual behaviour
- Steps to reproduce
- Environment
- Logs or error messages
- Screenshots (if applicable)
- Component affected

If essential information is missing:

- Stop.
- Create a GitHub comment requesting the missing information.
- Do not attempt implementation.

---

## Step 2 – Understand the Problem

Summarise:

- What appears to be broken
- What is known
- What is unknown
- Possible areas involved

Clearly separate facts from assumptions.

---

## Step 3 – Produce an Investigation Plan

Create an investigation plan.

Include:

- Components to inspect
- Areas of code to review
- Logging to add
- Tests to create
- How to reproduce consistently
- Possible root causes (ordered by likelihood)

Do not propose a fix until the root cause has been identified.

---

## Step 4 – Adversarial Review

Spawn an adversarial reviewer.

Challenge the investigation by asking:

- Is this actually a bug?
- Could this be configuration?
- Could this be user error?
- Are reproduction steps incomplete?
- Could this be timing or concurrency?
- Are there environmental differences?
- Are we making assumptions?

Look for alternative explanations before committing to a diagnosis.

---

## Step 5 – Refine the Investigation Plan

Update the investigation plan based on the review.

Document any remaining uncertainty.

---

## Step 6 – Publish

Post the investigation plan as a comment on the GitHub issue.

The comment should contain:

1. Understanding of the problem
2. Reproduction strategy
3. Investigation approach
4. Likely root causes
5. Risks
6. Outstanding questions

Implementation should only begin after the investigation has been completed and the root cause is understood.
