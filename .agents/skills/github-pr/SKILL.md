---
name: github-pr
description: roasts and reviews a pr
---

## Purpose

This skill performs an intentionally adversarial review of a pull request before it is approved.

The objective is **not** to find reasons to reject the PR, but to identify every weakness, hidden assumption, unnecessary complexity, and potential future problem.

Assume the author is a competent engineer. Critique the code, not the person.

Do not be polite for the sake of politeness. Be direct, evidence-based, and constructive.

---

# Review Workflow

## Step 1 – Understand the Intent

Read:

- Pull request title
- Description
- Linked issue(s)
- Changed files
- Existing review comments

Determine:

- What problem is this PR trying to solve?
- Does it actually solve that problem?
- Is the implementation aligned with the issue?

If the purpose is unclear, state that before reviewing the implementation.

---

## Step 2 – High-Level Review

Evaluate the solution from an architectural perspective.

Ask:

- Is this the simplest possible solution?
- Is the change appropriately scoped?
- Has unnecessary functionality been included?
- Does it introduce unnecessary coupling?
- Does it increase maintenance burden?
- Would another engineer immediately understand this implementation?

Document any concerns before reviewing individual files.

---

## Step 3 – Spawn an Adversarial Reviewer

Spawn an adversarial review agent.

The reviewer's job is to assume the implementation is flawed until proven otherwise.

Review every change looking for:

### Correctness

- Logic errors
- Incorrect assumptions
- Missing edge cases
- Race conditions
- Null handling
- Error handling
- State inconsistencies

---

### Simplicity

Challenge every abstraction.

Ask:

- Why does this abstraction exist?
- Can this be deleted?
- Can two classes become one?
- Can this function become smaller?
- Is this configuration actually necessary?

Prefer deletion over addition.

---

### Maintainability

Look for:

- Complex logic
- Hidden behaviour
- Long methods
- Deep nesting
- Magic values
- Poor naming
- Duplicate code
- Premature abstraction

Assume someone unfamiliar with the project will need to maintain this in two years.

---

### Performance

Question:

- Expensive allocations
- Unnecessary database queries
- N+1 problems
- Blocking operations
- Inefficient algorithms
- Repeated work
- Excessive network calls

Do not recommend optimisation without evidence, but identify obvious concerns.

---

### Security

Look for:

- Input validation
- Authorization
- Authentication
- Secret handling
- Injection vulnerabilities
- Information leakage
- Logging sensitive information

Assume hostile input.

---

### Testing

Determine whether the tests actually prove correctness.

Look for:

- Missing tests
- Happy-path only tests
- Missing edge cases
- Missing regression tests
- Brittle tests
- Redundant tests

Ask whether the bug or feature could regress tomorrow.

---

### API Design

Challenge:

- Public API changes
- Breaking changes
- Naming consistency
- Backwards compatibility
- Error contracts

---

### Readability

Ask:

- Would this make sense six months from now?
- Would a junior engineer understand this?
- Does the code explain itself?
- Are comments compensating for confusing code?

---

## Step 4 – Challenge the Entire Design

After reviewing the implementation, ignore it completely.

Pretend it does not exist.

Design the feature again from scratch.

Ask:

- Would you build it differently?
- Would you delete code instead?
- Could existing components solve this?
- Is there a dramatically simpler implementation?
- Is this solving the wrong problem?

If a better design exists, explain it.

---

## Step 5 – Identify Risks

List:

- Technical debt introduced
- Hidden assumptions
- Future maintenance risks
- Migration risks
- Rollback concerns
- Operational concerns

---

## Step 6 – Produce the Roast

Summarise the review using the following sections.

### Concerns

The three most important issues.

---

### Changes Requests

Blocking issues that should be addressed before merging.

---

### Discussion

Design questions, trade-offs, or alternative approaches.

---

### Good Job

Identify good engineering decisions.

A good review should acknowledge strong work as well as weaknesses.

---

### If This Lands Today...

Predict the most likely future problems.

Examples:

- Future maintenance pain
- Bugs likely to appear
- Scaling concerns
- Operational risks
- Areas likely to confuse future engineers

---

### Overall Verdict

Choose one:

- Approve
- Approve with minor suggestions
- Request changes
- Strongly request redesign

Explain the reasoning.

--- 

If this is on a repository I own, post the roast to a comment and place comments on any code which needs to be changed. 

---

# Review Principles

- Assume good intent.
- Challenge every assumption.
- Prefer evidence over opinion.
- Prefer simpler solutions.
- Favour maintainability over cleverness.
- Consider long-term ownership.
- Review the design, not just the syntax.
- Don't merely identify problems—explain why they matter.
- If you recommend a change, suggest a better alternative where practical.
- Never approve a PR simply because it works. It should also be understandable, maintainable, and appropriately scoped.

