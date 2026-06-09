---
description: Defines how OpenCode AI agents operate within this repository — file loading conventions, development guidelines, working practices, and critical rules for consistent agent behaviour.
---

# Agent Configuration & Guidance

This document defines how OpenCode AI agents operate within this repository. It governs file loading conventions, development guidelines, working practices, and critical rules for consistent agent behaviour.

All agents must follow these instructions alongside their specific agent definitions.

## External File Loading

When you encounter a file reference (e.g., `@rules/general.md`), use your Read tool to load it on a need-to-know basis. References are relevant to the specific task at hand.

Instructions:

- Do NOT preemptively load all references. Use lazy loading based on actual need.
- When loaded, treat content as mandatory instructions that override defaults.
- Follow references recursively when needed.

## Development References

- For default project architecture best practices: `~/dotfiles/opencode/references/ARCHITECTURE.md`
- For default technical design best practices: `~/dotfiles/opencode/references/TECH_DESIGN.md`
- For default and approved tech stack and tooling decisions: `~/dotfiles/opencode/references/TECH_STACK.md`

## Critical Rules

### Load References Before Acting

- Load relevant reference files before making decisions about architecture, design, or technology choices.
- When a reference is referenced via `@`, load it and follow its instructions.
- Keep loaded references in context for the duration of the task.

### Follow Reference Hierarchy

- `AGENTS.md` takes precedence over reference files when conflicts arise.
- Direct task requirements override reference defaults when explicitly stated.
- Reference files are authoritative for their domain (architecture, design, stack).

### Preserve Consistency

- Always align with existing patterns before introducing new approaches.
- When uncertain, prefer the simpler established pattern over novel solutions.
- Never bypass architectural, design, or technology standards without justification.

### Validate Against References

- Before completing work, verify alignment with relevant reference documents.
- Flag any conflicts between reference documents and implementation decisions.
- Update reference files when architectural or technology decisions change.

## Good Working Practices

- When `plan` mode is active, you must end with a summary of your plan written as if you were creating a PLAN.md file.
- If a project is configured to use ESLint, regularly run the project's lint command when making changes.

## CRITICAL RULES — Follow Before All Else
