---
description: Generate tests
agent: test
subtask: false
---

Your job is to create reliable, maintainable, high-confidence tests that validate real behaviour and integrate cleanly with the existing codebase.

Before writing any tests, confirm that project context and reference files are already loaded in this conversation. If not, invoke `@context-scout` to discover project context and load relevant reference files from `~/dotfiles/opencode/references/` before proceeding. Tests built without context miss project conventions and produce unreliable results — verify context is present before writing a single assertion.

Prefer:

- Behavioural testing.
- Deterministic assertions.
- Realistic usage patterns.
- Meaningful edge case coverage.
- Maintainable test structure.
- Prefer realistic assertions over internal state inspection.
- Keep tests small and focused.
- Preserve readability and maintainability.

Avoid:

- Brittle implementation-coupled tests.
- Excessive mocking.
- Snapshot abuse.
- Arbitrary sleeps/timeouts.
- Low-value coverage inflation.

Cover:

- Expected behaviour.
- Edge cases.
- Failure paths.
- Validation logic.
- Error handling.
- State transitions.
- Important branching logic.
- Integration boundaries where appropriate.

Follow the project's existing conventions:

- Test framework, file structure, naming conventions.
- Mocking patterns, helper utilities, assertion style.
- Detect patterns from `package.json`, existing test files, test configuration, and project tooling.

Workflow:

1. Analyze the target implementation and dependencies.
2. Identify the behaviours that matter most.
3. Review existing testing patterns in the repository.
4. Generate tests that align with project conventions.
5. Mock external systems only where necessary.
6. Keep tests isolated, deterministic, and independently executable.
7. Validate that the tests meaningfully improve confidence.

Rules:

- Use the project's established tooling first.
- Never generate flaky tests.
- Never rely on arbitrary timing.
- Never couple tests tightly to implementation internals.
- Never duplicate existing coverage unnecessarily.
- Never mock what can be tested realistically.
- Never introduce brittle snapshot-heavy suites.
- Use descriptive test names.
- Ensure failures are easy to diagnose.
- Prefer existing conventions over personal preference.

Priorities (first match wins):

1. Ensure tests validate correct behaviour.
2. Ensure tests are deterministic and reliable.
3. Ensure tests follow existing project conventions.
4. Ensure important edge/error paths are covered.
5. Ensure tests remain readable and maintainable.
6. Optimize execution speed where practical.
7. Focus on confidence, correctness and maintainability, not raw coverage percentages.

Validation:

- Ensure tests run successfully.
- Ensure assertions are meaningful.
- Ensure mocks are justified.
- Ensure edge cases are covered.
- Ensure test structure matches the codebase.
- Ensure failures produce useful debugging information.

When complete, provide a final summary including:

- Generated coverage.
- Important behaviours tested.
- Notable edge cases covered.
- Assumptions or limitations.
- Any recommended follow-up testing.

Generate tests: $ARGUMENTS
