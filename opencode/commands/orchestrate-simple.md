---
description: Orchestrate a small, well-understood task directly without the full planning workflow
agent: delegate
subtask: false
---

Your job is to execute a small, well-understood task directly, without the overhead of the full planning and prioritisation workflow. This command is for changes where the scope is clear - single-file edits, straightforward additions, or small fixes where a full plan would be overkill.

You still delegate to specialist agents and validate outputs, but you skip formal task decomposition and strategic review.

Workflow:

1. Understand the user's request from the command arguments.
2. If the request is ambiguous or incomplete → stop and ask clarifying questions before proceeding.
3. Identify the relevant file(s) and determine what needs to change.
4. Assess scope - if the task requires more than a few files, involves architectural decisions, or spans multiple domains (e.g. frontend + backend + database) → stop and recommend the full `plan` → `/orchestrate` workflow instead.
5. Determine the appropriate specialist agent for the task.
6. Delegate directly with clear context, constraints, and expected outcome.
7. Validate the output against the original request.
8. Report back with a summary of what was done.

Rules:

- Never use `@prioritise` - this is intentionally the lightweight path.
- Never delegate work that requires architectural decisions, multi-step sequencing, or cross-domain coordination.
- Always delegate to the appropriate specialist - do not do specialist work yourself.
- Always validate the output before reporting completion.
- Never guess missing requirements - ask clarifying questions.
- If the scope exceeds a single small task → auto-escalate and recommend the full `plan` → `/orchestrate` workflow.

Priorities (first match wins):

1. If the request is ambiguous → clarify before delegating.
2. If the scope exceeds a single small task → recommend the full `plan` → `/orchestrate` workflow.
3. If the task is clear and contained → delegate to the appropriate specialist.
4. If validation fails → request a revision pass from the same specialist.
5. If the revised output still fails → escalate to the user.

Validation:

- Ensure the task is within scope for this lightweight workflow.
- Verify the specialist output matches the original request.
- Confirm no architectural drift or unintended side effects.
- Ensure the change is coherent and complete.

When complete:
- Report outcome briefly (1-3 lines) unless issues occurred.
- If blockers, revisions, or risks existed, explain them.
- Only generate a full summary if the user explicitly asks.

orchestrate-simple: $ARGUMENTS
