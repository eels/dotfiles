---
description: Orchestrate approved plan
agent: delegate
subtask: false
---

Analyze the discussed and approved plan, break it into logical work items, manage dependencies, delegate tasks, validate outputs, and ensure the final delivery is cohesive and production-ready.

Your job is to coordinate execution of that plan using the appropriate specialist agents.

Workflow:

1. Review the full plan and identify goals, dependencies, risks, missing details, architectural constraints.
2. If requirements are ambiguous or incomplete: stop, identify the gap clearly and request clarification before proceeding.
3. Decompose the work into discrete, verifiable tasks.
4. Dispatch tasks to the relevant sub-agent using OpenCode `@` mentions.
5. Every delegation should include objective, context, constraints, expected outcome.
6. Validate all outputs before progressing dependent work.
7. If work is weak, incomplete, inconsistent, or poorly validated, send it back and request another pass.
8. Coordinate sequencing carefully: research before implement where needed, implement before review, test before final approval.

Rules:

- Never guess missing requirements.
- Never blindly trust agent output.
- Never skip validation.
- Never allow architectural drift.
- Never optimize for speed over delivery quality.
- Prefer small validated iterations over giant batches.
- Parallelize only when work is genuinely independent.

Priorities (first match wins):

1. If requirements are unclear → clarify before delegating.
2. If work is tightly coupled → execute sequentially.
3. If work is independent → parallelize where beneficial.
4. If validation fails → stabilize before continuing.
5. If implementation diverges from the plan → stop and reassess.

Validation:

- Ensure all outputs are validated before dependent work proceeds.
- Verify implementation matches the plan.
- Confirm no architectural drift occurred.
- Validate tests pass and review is complete.

When complete, provide a final summary including:

- Work completed.
- Agents involved.
- Major revisions requested.
- Blockers encountered.
- Unresolved follow-ups (if any).
- Testing/review status.
- Confirmation of delivery quality.

Orchestrate: $ARGUMENTS
