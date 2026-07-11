---
description: Defines how OpenCode AI agents operate within this repository - file loading conventions, development guidelines, working practices, and critical rules for consistent agent behaviour.
---

# Agent Configuration & Guidance

This document defines how OpenCode AI agents operate within this repository.

## Identity

Defines how OpenCode AI agents operate within this repository. All agents must follow these instructions alongside their specific agent definitions. You do not skip instructions in this file. Context files prevent hallucinations, specialists deliver better outcomes, references establish standards, and consistency prevents architecture rot. Optimise for context completeness, specialist delegation, pattern consistency, and reference verification - never skip context, assume understanding, introduce unjustified patterns, or trust unloaded references.

## Context Architecture

OpenCode uses two separate context systems with different locations and purposes.

**Project Context (`.opencode/context/`)** - Per-project, optional. Discovered by `context-scout`. Contains project-specific standards, workflows, and patterns. If absent, context-scout returns nothing - that is correct behaviour.

**Global References (`~/dotfiles/opencode/references/`)** - Always available. Loaded directly by Step 3 of the startup sequence, not by `context-scout`. Contains architecture, design, and tech stack standards.

Both steps are required; neither replaces the other.

## Startup Sequence

On every invocation in plan or build mode:

1. **Load AGENTS.md** - This file, highest-priority guidance. Always succeeds.
2. **Discover Project Context** - `@context-scout` searches `.opencode/context/`. If absent or empty, proceed - that is correct behaviour, not an error.
3. **Load Global References** - Load relevant files from `~/dotfiles/opencode/references/`. Keep in context for the duration.
4. **Report Failure Upward** - Missing files, broken references, unresponsive agents must be reported, not silently skipped. Silent failures violate the guarantees established by this sequence.

## Critical Rules

1. **Always use context-scout first** - Searches `.opencode/context/` at the project level. If absent or empty, returns nothing - proceed to references. Failure to load context produces output that does not match project standards.

2. **Load references before acting** - Load relevant global reference files from `~/dotfiles/opencode/references/` before architecture, design, or technology decisions. Keep them in context for the duration.

3. **Follow reference hierarchy** - Conflicts resolve as: AGENTS.md → Direct task requirements → Reference files.

4. **Preserve consistency** - Align with existing patterns before introducing new approaches. When uncertain, prefer the simpler established pattern. Never bypass standards without justification. Consistency is a force multiplier; every novel pattern increases cognitive overhead.

5. **Validate against references** - Before completing work, verify alignment with reference documents. Flag conflicts; update references when decisions change.

6. **External file loading** - Load references via Read tool on a need-to-know basis. Treat loaded content as mandatory instructions. Follow references recursively when needed.

7. **Never commit automatically** - Only the user commits (manually or via `/commit`). No agent may invoke `git commit` during any workflow. Persist state by creating files on disk; do not stage or commit. The user will review and commit when ready.

## Development References

- Architecture: `~/dotfiles/opencode/references/standards/ARCHITECTURE.md`
- Technical design: `~/dotfiles/opencode/references/standards/TECH_DESIGN.md`
- Tech stack and tooling: `~/dotfiles/opencode/references/standards/TECH_STACK.md`

## Anti-Patterns

- Skipping quality gates to save time
- Assuming you know the project well enough to skip setup steps
- "I know this project well enough, I do not need context"
- "I can handle this myself, no need to delegate"
- "The reference is probably the same as last time"
- "This new pattern is better, I will use it instead"
- "It works, that is good enough"
- "Loading context takes too long"
- "I'll just commit this for you" - committing is the user's decision, not the agent's

## Quality Gates

Before considering work complete, verify:

- [ ] `context-scout` was used at the start of the task or session
- [ ] Required context and reference files were loaded before implementation
- [ ] Work was delegated to specialist agents when appropriate
- [ ] Implementation aligns with existing project patterns and conventions
- [ ] Conflicts between references and implementation decisions were flagged
- [ ] Reference files were updated if architectural or technology decisions changed
- [ ] This file (AGENTS.md) was followed as the highest-priority guidance
- [ ] No automatic commits were made - all changes remain uncommitted for review
