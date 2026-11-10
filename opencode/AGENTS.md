---
description: Defines how OpenCode AI agents operate within this repository - file loading conventions, development guidelines, working practices, and critical rules for consistent agent behaviour.
---

# Agent Configuration & Guidance

This document defines how OpenCode AI agents operate within this repository.

## Identity

Defines how OpenCode AI agents operate within this repository. All agents must follow these instructions alongside their specific agent definitions. You do not skip instructions in this file. Context files prevent hallucinations, specialists deliver better outcomes, references establish standards, and consistency prevents architecture rot. Load context matched to your role and task: primary and coordinating agents load broadly at startup; dispatched subagents load on-demand when their task genuinely touches that domain. Optimise for context completeness within your role's scope, specialist delegation, pattern consistency, and reference verification - never skip context the task actually needed, assume understanding, introduce unjustified patterns, or trust unloaded references.

## Context Architecture

OpenCode uses two separate context systems with different locations and purposes.

**Project Context (`.opencode/context/`)** - Per-project, optional. Discovered by `context-scout`. Contains project-specific standards, workflows, and patterns. If absent, context-scout returns nothing - that is correct behaviour.

**Global References (`~/dotfiles/opencode/references/`)** - Always available. Loaded directly by Step 3 of the startup sequence, not by `context-scout`. Contains architecture, design, and tech stack standards.

Both systems matter; neither replaces the other. Primary and coordinating agents load both at startup. Dispatched subagents load them on-demand when their task genuinely touches project standards or reference domains.

## Startup Sequence

Discovery is role-scoped. Primary agents and coordinating agents (the planner, the orchestrator/`@delegate`, session leads) run the full sequence on every invocation in plan or build mode. The orchestrator (`@delegate`) coordinates work despite its `mode: subagent` frontmatter - it is a coordinating agent for this purpose. Dispatched subagents receive context via the orchestrator's task prompt: Steps 1 and 4 apply to them universally, and they load Steps 2-3 context on-demand when their task genuinely touches that domain - a rich prompt may already carry what is needed.

1. **Load AGENTS.md** - This file, highest-priority guidance. Universal - every agent, every invocation, always succeeds.
2. **Discover Project Context** - Primary and coordinating agents run `@context-scout`, which searches `.opencode/context/`. If absent or empty, proceed - that is correct behaviour, not an error. Subagents run it on-demand when the task touches project conventions.
3. **Load Global References** - Primary and coordinating agents load relevant files from `~/dotfiles/opencode/references/` at startup. Subagents load on-demand when the task genuinely touches those domains. Keep in context for the duration.
4. **Report Failure Upward** - Missing files, broken references, unresponsive agents must be reported, not silently skipped. Silent failures violate the guarantees established by this sequence. Universal.

## Critical Rules

1. **Never commit automatically** - Committing is never an automatic task final step, no matter what: not when the task is complete, not when it seems like the obvious final step, not for small fixes. No agent may invoke `git commit` automatically during any workflow. Exactly two authorised paths exist for committing: the user's explicit request to commit in the current prompt, or the `/commit` command when the user explicitly invokes it. Git read commands (`status`, `diff`, `log`, `show`, `branch`) remain freely available - agents may still do git work when asked. Persist state by creating files on disk; do not stage or commit. The user will review and commit when ready.

2. **Never access `.env` files** - Agents must not read, load, or request access to live `.env` files under any circumstances. These files contain secrets and credentials that must not enter agent context. Use `.env.example` or `.env.template` files to understand expected configuration. If a project has no `.env.example`, flag this as a gap rather than reading the live file.

3. **Stay within approved file access boundaries** - Only read or write files within the current project directory, the OS temp directory (`$TMPDIR`), or explicitly configured reference paths (e.g. `~/dotfiles/opencode/references/`). Do not access arbitrary filesystem paths. If a task requires reading or writing to an external directory not listed in approved references, ask the user for explicit permission before proceeding. When temporary files are needed, always use `$TMPDIR` — never use `/tmp`.

4. **Preserve consistency** - Align with existing patterns before introducing new approaches. When uncertain, prefer the simpler established pattern. Never bypass standards without justification. Consistency is a force multiplier; every novel pattern increases cognitive overhead.

5. **Do the minimum work required** - Achieve the goal with the least amount of work necessary without compromising quality, maintainability, or requirements. Do not over-engineer solutions, introduce unnecessary abstractions, or add scope beyond what was asked. Follow existing conventions and patterns rather than inventing new ones. "Minimum" does not mean smallest at the expense of clarity — name things properly, structure code for readability, and maintain the quality bar. Work should be sleek, lean, and focused: high quality, but not lost in its own complexity.

6. **Match the tone and layout of technical writing** - When editing or creating documentation, command files, markdown content, or other technical writing, match the tone, style, heading format, and structural conventions of the existing file (if editing) or sibling files in the same directory (if creating new). The goal is that any written output reads as if it belongs in the same document set and was written by the same author.

7. **Validate against references** - Before completing work, verify alignment with reference documents. Flag conflicts; update references when decisions change.

8. **Use context-scout first when discovery applies** - Primary and coordinating agents run context-scout first; it searches `.opencode/context/` at the project level. If absent or empty, returns nothing - proceed to references. Subagents run it on-demand when their task touches project conventions or standards. Failure to load context the task needed produces output that does not match project standards.

9. **Load references before acting** - Primary agents load relevant global reference files from `~/dotfiles/opencode/references/` at startup. Subagents load them before acting on architecture, design, or technology decisions that depend on them. Keep loaded files in context for the duration.

10. **Follow reference hierarchy** - Conflicts resolve as: AGENTS.md → Direct task requirements → Reference files.

11. **External file loading** - Load references via Read tool on a need-to-know basis. Treat loaded content as mandatory instructions. Follow references recursively when needed.

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
- "Loading context takes too long" - on-demand means when the task needs it, not never; skipping context the task genuinely needed is the failure
- "I'll just commit this for you" - committing is the user's decision, never the agent's - forbidden even when the task looks finished, even when it feels helpful, even for a small fix
- "I just need to check the .env to understand the config" - use `.env.example` instead; live secrets must never enter agent context
- "I'll just run this command again next time" - script it if repeatable and non-trivial
- "This is too simple to script" - if repeatable and not a trivial one-liner, script it

## Quality Gates

Before considering work complete, verify:

- [ ] Context discovery matched the agent's role - eager for primary and coordinating agents at startup, on-demand for subagents when the task touched that domain
- [ ] Required context and reference files were loaded before the work that depended on them
- [ ] Work was delegated to specialist agents when appropriate
- [ ] Implementation aligns with existing project patterns and conventions
- [ ] Conflicts between references and implementation decisions were flagged
- [ ] Reference files were updated if architectural or technology decisions changed
- [ ] This file (AGENTS.md) was followed as the highest-priority guidance
- [ ] No automatic commits were made - all changes remain uncommitted for review
