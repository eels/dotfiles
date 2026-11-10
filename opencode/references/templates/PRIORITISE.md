---
description: Canonical templates for task list output and decision log persistence used by the @prioritise agent.
---

# Prioritise Templates

This document provides canonical structure templates for development task lists and decision log persistence. The `@prioritise` agent loads these on demand when producing task decomposition output.

## Task List Format

Use this template when generating a development task list from a specification. Each task must be independently implementable with testable acceptance criteria.

```markdown
# [Project Name] Development Tasks

## Specification Summary
**Original Requirements**: [Quote key requirements from spec]
**Technical Stack**: [Framework, libraries, dependencies]
**Target Timeline**: [From specification]

## Development Tasks

### [ ] Task 1: [Task Name]
**Description**: [Clear, specific description of what to build]
**Acceptance Criteria**:
- [Testable criterion 1]
- [Testable criterion 2]
- [Testable criterion 3]

**Files to Create/Edit**:
- [File path 1]
- [File path 2]

**Reference**: Section X of specification

### [ ] Task 2: [Task Name]
**Description**: [Clear, specific description]
**Acceptance Criteria**:
- [Testable criterion 1]
- [Testable criterion 2]

**Reference**: Section Y of specification

## Quality Requirements
- [ ] All requirements from specification are addressed
- [ ] Acceptance criteria are testable
- [ ] Scope matches specification exactly
- [ ] Technical stack requirements are documented

## Technical Notes
**Development Stack**: [Exact requirements from spec]
**Special Instructions**: [Client or project-specific requests]
```

## Plan File Format

Use this structure when persisting a decision log to `.opencode/context/plans/active.md`. The frontmatter provides machine-readable metadata; the markdown body records what was decided, assumed, and verified in a single short artifact.

```markdown
---
source: plan
status: active
created: <ISO timestamp>
updated: <ISO timestamp>
---
# [Project Name] Decision Log

## Decided
- [Decision 1 and why]
- [Decision 2 and why]

## Assumed
- [Assumption 1 and its basis]
- [Assumption 2 and its basis]

## Verified
- [What was checked and how]
- [What was checked and how]
```

Keep the body short. Record only what future sessions need: the decisions made, the assumptions they rest on, and what was verified. Do not expand it into a task list or a strategic brief.

## Archive Format

Rotation is a file move. When a decision log is complete or superseded, move `active.md` to `archive/<date>-<slug>.md`, where `<date>` is today's ISO date and `<slug>` is a brief kebab-case label. Do not create a separate archive document, duplicate content, or edit frontmatter during rotation — the log moves as written.

## Rotation Timing

When a session begins persistence and `active.md` exists, rotate it to `archive/<date>-<slug>.md` before writing the new decision log.

## Usage

When generating a task list, load this file and follow the Task List Format template. When persisting a decision log, follow the Plan File Format structure. Fill in each field with content specific to the specification being planned.
