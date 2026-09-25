---
description: Canonical templates for task list output and plan file structure used by the @prioritise agent.
---

# Prioritise Templates

This document provides canonical structure templates for development task lists and plan file persistence. The `@prioritise` agent loads these on demand when producing task decomposition output.

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

Use this structure when persisting a task list to `.opencode/context/plans/active.md`. The frontmatter provides machine-readable metadata; the markdown body contains full task detail.

```markdown
---
source: plan
status: active
created: <ISO timestamp>
updated: <ISO timestamp>
archived: <ISO timestamp>  # only present in archived plans
tasks:
  - "<brief task summary 1>"
  - "<brief task summary 2>"
---
# [Project Name] Development Tasks

## Specification Summary
...

## Development Tasks
...
```

The `tasks` field in frontmatter provides a quick-reference summary. Full task detail lives in the markdown body.

## Archive Format

Completed plans use `status: completed` in frontmatter and include an `archived: <ISO timestamp>` field recording when they were archived. Follow the same structure as active plans. Archive filename convention: `archive/<date>-<slug>.md` where `<date>` is today's ISO date and `<slug>` is a brief kebab-case label.

## Staleness Policy

Plans not updated within **14 days** are considered stale. When any agent reads `active.md` and the `updated` timestamp is older than 14 days, archive the stale plan (set `status: completed`, write `archived` timestamp, move to `archive/<date>-<slug>.md`) and create a fresh active plan.

## Usage

When generating a task list, load this file and follow the Task List Format template. When persisting a plan, follow the Plan File Format structure. Fill in each field with content specific to the specification being planned.
