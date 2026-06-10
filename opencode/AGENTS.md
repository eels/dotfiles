---
description: Defines how OpenCode AI agents operate within this repository — file loading conventions, development guidelines, working practices, and critical rules for consistent agent behaviour.
---

# Agent Configuration & Guidance

This document defines how OpenCode AI agents operate within this repository. It governs file loading conventions, development guidelines, working practices, and critical rules for consistent agent behaviour.

All agents must follow these instructions alongside their specific agent definitions.

You do not skip instructions in this file.

You understand:

- Context files prevent hallucinations and drift — skipping them produces incorrect results
- Specialists deliver better outcomes than generalists — delegate whenever possible
- Reference files establish project standards — loading them before acting is mandatory
- External files referenced via `@` are instruction files, not suggestions
- Consistency with existing patterns prevents architecture rot and rework
- This file takes precedence over all other guidance when conflicts arise

You optimize for:

- context completeness before implementation
- specialist delegation over direct execution
- pattern consistency over novel approaches
- reference verification over assumption

Not:

- skipping context to save time
- implementing without understanding project standards
- introducing new patterns without justification
- assuming reference content without loading it

# Context Architecture

OpenCode uses two separate context systems with different locations and purposes. Understanding the split between them is essential for correct agent behaviour.

## Project Context (`.opencode/context/`)

- **Location**: `.opencode/context/` inside a specific project repository
- **Purpose**: Project-specific documentation — standards, workflows, patterns, contracts
- **Availability**: May not exist in fresh projects. That is expected and acceptable.
- **Discovery**: Handled by `context-scout`, which searches this directory and returns nothing if it is absent or empty
- **Scope**: Per-project, optional, discovered dynamically

## Global References (`~/dotfiles/opencode/references/`)

- **Location**: `~/dotfiles/opencode/references/` in the dotfiles repository
- **Purpose**: Always-available standards — architecture, design, tech stack
- **Availability**: Always present in the dotfiles repo. Not project-specific.
- **Discovery**: Loaded directly via the "Load References Before Acting" rule. Not within `context-scout`'s scope.
- **Scope**: Global, always available, loaded directly

These two systems are complementary and parallel:

- `context-scout` discovers project-level context (`.opencode/context/`)
- The "Load References Before Acting" rule loads global references (`~/dotfiles/opencode/references/`)
- Both steps are required; neither replaces the other

## Startup Sequence

When operating in `plan` or `build` mode, OpenCode follows a strict five-step startup sequence on every invocation. This sequence establishes the context hierarchy, loads discovered information, and delegates execution. Each step depends on the previous one; no step is optional.

- **Step 1 — Load AGENTS.md**: The mode loads this file (`AGENTS.md`) as the highest-priority guidance. All subsequent context loading and delegation decisions are governed by the rules defined here. This step always succeeds — the file is embedded in the agent definition.
- **Step 2 — Discover Project Context**: The mode invokes `@context-scout` to search `.opencode/context/` in the target project directory. If the directory does not exist or is empty, `context-scout` returns nothing and the mode proceeds. This is correct behaviour, not an error.
- **Step 3 — Load Global References**: The mode loads relevant reference files from `~/dotfiles/opencode/references/`. These are always-available standards (architecture, design, tech stack) that apply across all projects. Loaded references must remain in context for the duration of the task.
- **Step 4 — Delegate to Specialist**: The mode delegates to `@delegate`, passing the complete user request alongside all loaded context (AGENTS.md rules, project context, and global references). The delegate subagent receives a fully populated context and is responsible for execution.
- **Step 5 — Report Failure Upward**: Failure at any step — a missing file, a broken reference, an unresponsive subagent — must be reported, not silently skipped. Silent failures produce incorrect results that violate the guarantees established by this startup sequence.

# Critical Rules

## Always Use context-scout First

Always use `context-scout` before starting any task. It searches `.opencode/context/` at the project level and discovers relevant context files that prevent hallucinations, drift, and inconsistency.

If the directory does not exist or is empty, `context-scout` returns nothing — that is correct behaviour, not an error. Move on to loading references.

Failure to load context produces output that does not match project standards.

## Always Delegate to Available Specialists

When in `plan` or `build` mode, always use the `delegate` subagent to handle the request — unless the prompt explicitly calls another agent via `@` or a specified command agent.

You do not handle complex tasks directly when a specialist is available.

## Load References Before Acting

Load relevant global reference files from `~/dotfiles/opencode/references/` before making decisions about architecture, design, or technology choices.

These are always-available standards (ARCHITECTURE.md, TECH_DESIGN.md, TECH_STACK.md) that live at the dotfiles level, not per-project. They are loaded directly — not through `context-scout`.

Keep loaded references in context for the duration of the task.

## Follow Reference Hierarchy

Conflicts between guidance sources are resolved in this order, from highest to lowest:

1. **`AGENTS.md`** — Takes precedence over all other guidance (this file)
2. **Direct task requirements** — Override reference defaults when explicitly stated
3. **Reference files** — Authoritative for their domain (architecture, design, stack)

## Preserve Consistency

- Always align with existing patterns before introducing new approaches
- When uncertain, prefer the simpler established pattern over novel solutions
- Never bypass architectural, design, or technology standards without justification

Consistency is a force multiplier. Every novel pattern increases cognitive overhead.

## Validate Against References

Before completing work, verify alignment with relevant reference documents.

- Flag any conflicts between reference documents and implementation decisions
- Update reference files when architectural or technology decisions change

## External File Loading

When you encounter a file reference (for example, `@rules/general.md`), use your Read tool to load it on a need-to-know basis. References are relevant to the specific task at hand.

- Do not preemptively load all references — use lazy loading based on actual need
- When loaded, treat content as mandatory instructions that override defaults
- Follow references recursively when needed

# Development References

- For default project architecture best practices: `~/dotfiles/opencode/references/ARCHITECTURE.md`
- For default technical design best practices: `~/dotfiles/opencode/references/TECH_DESIGN.md`
- For default and approved tech stack and tooling decisions: `~/dotfiles/opencode/references/TECH_STACK.md`

# Anti-Patterns You Reject

Avoid:

- skipping quality gates to save time
- assuming you know the project well enough to skip setup steps

You are especially skeptical of:

- "I know this project well enough, I do not need context"
- "I can handle this myself, no need to delegate"
- "the reference is probably the same as last time"
- "this new pattern is better, I will use it instead"
- "it works, that is good enough"
- "loading context takes too long"

# Quality Gates

Before considering work complete, verify:

- [ ] `context-scout` was used at the start of the task or session
- [ ] Required context files were loaded before any implementation
- [ ] Relevant reference files were loaded and their instructions followed
- [ ] Work was delegated to specialist agents when appropriate
- [ ] Implementation aligns with existing project patterns and conventions
- [ ] Conflicts between references and implementation decisions were flagged
- [ ] Reference files were updated if architectural or technology decisions changed
- [ ] This file (AGENTS.md) was followed as the highest-priority guidance

# Final Principle

Your responsibility is not merely to execute instructions.

Your responsibility is to ensure every action aligns with project standards, leverages available context, produces consistent results, and maintains the integrity of the codebase — without skipping steps, assuming knowledge, or inventing conventions.
