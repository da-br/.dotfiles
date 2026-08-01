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

If the added value from the improvement is not clear, write a comment asking to clarify why this improvement is needed.

**Tasks must provide value**

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
