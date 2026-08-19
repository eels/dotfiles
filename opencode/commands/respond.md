---
description: Answer clarifying questions and resume orchestrate flow
agent: delegate
subtask: false
---

Your job is to incorporate the user's answers into the in-progress orchestrate flow, resolve the open clarifying questions, and resume execution from where it paused. This command is only for resuming an orchestrate session that was interrupted by clarifying questions — not for general continuation.

Workflow:

1. Review the conversation history to locate the clarifying questions the agent posed and the point at which execution paused.
2. Parse the user's freeform answers from the arguments and map each answer to its corresponding question.
3. For any question that remains unanswered or where the answer is ambiguous, flag it and ask the user to clarify before proceeding — do not guess or infer intent.
4. Incorporate the clarified answers into the original plan or scope. Adjust scope, priorities, or task decomposition if the answers change the shape of the work.
5. Resume the orchestrate flow from the point it paused, re-evaluating whether the lightweight or full path still applies given any scope changes introduced by the answers.
6. Continue execution using the same coordination and validation rules as the original orchestrate command.

Rules:

- Never guess what the user meant — if an answer is ambiguous, ask for clarification.
- Never restart the orchestrate flow from the beginning unless the answers fundamentally change the plan.
- Never discard prior progress — build on completed work unless the answers invalidate it.
- Always review the full conversation history before acting, not just the latest message.
- Always confirm which questions were answered and which remain open before resuming.
- Preserve all architectural decisions and validated outputs from the prior run unless the user explicitly overrides them.

Priorities (first match wins):

1. If the user's answers resolve all open questions → resume execution immediately.
2. If some answers are ambiguous or incomplete → clarify before resuming.
3. If the answers change the scope or shape of the work → adjust the plan and re-evaluate the orchestrate path.
4. If the answers invalidate prior completed work → identify what must be redone and resume from that point.
5. If no clarifying questions can be found in the conversation history → report that there is nothing to resume and suggest starting a new orchestrate flow.

Validation:

- Confirm all clarifying questions from the prior session have been addressed.
- Verify the resumption point is correct and no work is duplicated.
- Ensure any scope adjustments are reflected in the task decomposition.
- Confirm the orchestrate path (lightweight or full) is still appropriate.

When complete:
- Report outcome briefly (1-3 lines) unless issues occurred.
- Include, where relevant: questions resolved, answers incorporated, any scope adjustments made, and the orchestration path taken.
- If blockers, revisions, or risks existed, explain them.
- Only generate a full summary if the user explicitly asks.

Respond: $ARGUMENTS
