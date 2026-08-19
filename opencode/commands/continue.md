---
description: Resume an interrupted task from where execution stopped
agent: delegate
subtask: false
---

Your job is to determine what task was in progress when execution stopped unexpectedly, then resume from where it left off without restarting or repeating completed work.

Workflow:

1. Review conversation history to identify the most recent task, its current state, and what was completed before interruption.
2. Check if `.opencode/context/plans/active.md` exists and read it to determine whether a structured plan was being executed and which steps remain.
3. Synthesise findings from both sources to build a clear picture of what was done, what is in progress, and what remains.
4. If the interrupted task is unambiguous, pick up from the next incomplete step without re-doing completed work.
5. If the interrupted task is ambiguous or multiple tasks were in flight, ask the user to clarify which task to resume.
6. If neither conversation history nor plan files reveal a clear task, ask the user what was being done.
7. Continue execution using the appropriate approach for the task — delegate to specialist agents as needed, following existing project conventions and standards.

Rules:

- Never restart a task from scratch when partial progress exists — always attempt to resume from the last incomplete step.
- Never assume or fabricate what was being done — verify from history or plan files first.
- Never skip reading the active plan file if it exists — it may contain more precise state than conversation history.
- Always prefer the plan file over conversation history when the two conflict — the plan is the authoritative record of intent.
- Always ask the user when context is insufficient rather than guessing.
- Preserve all existing work and validated outputs — do not discard or redo completed steps.

Priorities (first match wins):

1. If `.opencode/context/plans/active.md` exists and clearly indicates the task → resume using the plan as the source of truth.
2. If conversation history clearly shows an interrupted task → resume from the last incomplete step.
3. If both plan and history exist but conflict → ask the user to clarify.
4. If no clear task can be determined → ask the user what was being done.
5. If the task requires a specialist agent → delegate using the appropriate agent, passing accumulated context.
6. If the task is simple enough for direct execution → proceed without delegation.

Validation:

- Ensure the resumed task matches what was actually in progress.
- Ensure no completed work was discarded or repeated.
- Ensure plan file state (if used) is consistent with actual progress.
- Ensure the user is asked when ambiguity exists rather than guessing.

When complete:
- Report outcome briefly (1-3 lines) unless issues occurred.
- Include, where relevant: what was identified as the interrupted task, which steps were already complete, and what was resumed.
- If blockers, revisions, or risks existed, explain them.
- Only generate a full summary if the user explicitly asks.

continue: $ARGUMENTS
