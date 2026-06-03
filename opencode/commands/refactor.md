---
description: Refactor code
agent: delegate
subtask: true
---

Refactor: $ARGUMENTS

Your job is to improve maintainability, clarity, consistency, and long-term engineering quality without changing intended behaviour.

Do not introduce unnecessary abstractions, frameworks, or behavioural changes and reduce complexity where possible.

- **Single Responsibility Principle** Functions, modules, and components should have one clear purpose.
- **DRY (Don't Repeat Yourself)** Remove duplicated logic, validation, configuration, and business rules where appropriate.
- **KISS (Keep It Simple)** Prefer straightforward implementations over clever abstractions.
- **Composition Over Complexity** Extract reusable units only when they improve clarity and reduce cognitive load.
- **Consistency Over Preference** Follow existing project conventions, architecture, naming, and patterns.
- **Explicitness Over Implicitness** Make behaviour, data flow, and ownership obvious.

**Prioritize:**
- Readability.
- Simplicity.
- Consistency.
- Composability.
- Testability.
- Architectural alignment.

**Identify & Address:**
- Large or multi-purpose functions.
- Deeply nested conditionals.
- Duplicated logic.
- Unclear naming.
- Hidden side effects.
- Tightly coupled modules.
- Inconsistent patterns.
- Magic values.
- Unnecessary indirection.
- Dead code.
- Weak type safety.
- Implicit state mutation.
- Brittle logic.
- Poor separation of concerns.

**Workflow:**
1. Analyze the existing implementation and surrounding architecture.
2. Identify refactoring opportunities and potential risks.
3. Refactor incrementally in small safe steps.
4. Preserve existing behaviour unless explicitly instructed otherwise.
5. Ensure project conventions remain consistent.
6. Run or update tests where appropriate.
7. Verify the final implementation is simpler and easier to maintain.

**Rules:**
- Never change behaviour unintentionally.
- Never refactor blindly without understanding intent.
- Never introduce premature abstractions.
- Never sacrifice readability for cleverness.
- Never rewrite large sections unnecessarily.
- Prefer incremental improvements over giant rewrites.
- Preserve backwards compatibility unless explicitly instructed otherwise.

**Priorities (first match wins):**
1. Preserve correctness and behaviour.
2. Reduce complexity and cognitive load.
3. Improve readability and maintainability.
4. Strengthen consistency and architectural alignment.
5. Reduce duplication where beneficial.
6. Improve testability and type safety.
7. Optimize performance only where justified.

**Validation:**
- Ensure behaviour remains correct.
- Ensure tests still pass.
- Ensure complexity is reduced.
- Ensure naming is clearer.
- Ensure abstractions are justified.
- Ensure architectural consistency is preserved.

When complete, provide a final summary including:
- Summary of changes.
- Rationale behind major refactors.
- Notable complexity reductions.
- Risks or follow-up considerations.
- Any areas intentionally left unchanged and why.
