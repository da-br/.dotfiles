# General Workflow

1. Read the issue title, description, labels, linked issues, and existing comments.
2. Determine the issue type from its labels.
3. Follow the appropriate workflow.
4. Publish the resulting plan as a comment on the GitHub issue.
5. Only begin implementation once the planning phase is complete.

---

# Improvement Workflow

Applies to issues labelled:

- improvement
- enhancement
- feature

## Step 1 – Understand the Problem

Read the issue carefully.

Extract:

- The requested change
- Existing behaviour
- Desired behaviour
- Constraints
- Assumptions
- Stakeholders (if known)

Do **not** think about implementation yet.

Instead answer:

- Why do we need this?
- What problem does it solve?
- Who benefits?
- What business or user value does it provide?
- How will we know it has been successful?
- What behaviour must not change?

If these questions cannot be answered from the issue, explicitly document the unknowns.

---

## Step 2 – Define Success

Write clear acceptance criteria.

Focus on observable behaviour rather than implementation details.

Examples:

- Users can...
- Administrators can...
- Existing workflows continue to...
- Performance remains...
- Errors are handled by...

---

## Step 3 – Produce an Implementation Plan

Create a detailed implementation plan.

Include:

- Overall approach
- Components affected
- Files/modules likely to change
- APIs
- Database or schema changes
- UI changes
- Configuration changes
- Testing strategy
- Deployment considerations
- Risks

The plan should be detailed enough that another engineer could implement it.

Avoid writing code.

---

## Step 4 – Adversarial Review

Spawn an adversarial reviewer.

The reviewer's goal is to challenge the proposal.

Look for:

- Simpler solutions
- Hidden assumptions
- Missing requirements
- Edge cases
- Backwards compatibility
- Security concerns
- Performance concerns
- Maintainability
- Over-engineering
- Missing tests
- Failure scenarios

The reviewer should intentionally try to find weaknesses.

---

## Step 5 – Refine the Plan

Update the implementation plan based on the review.

Resolve any issues raised.

If disagreements remain, document them.

---

## Step 6 – Publish

Post the final implementation plan as a comment on the GitHub issue.

The comment should contain:

1. Problem summary
2. Expected value
3. Proposed implementation
4. Risks
5. Testing strategy
6. Outstanding questions

Implementation may begin after the plan has been published.

---

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
