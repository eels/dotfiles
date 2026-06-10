---
description: Defines the canonical MVI (Minimal Viable Information) document format used by the context-harvest and context-extract commands.
---

# MVI Document Format

This document defines the canonical specification for MVI (Minimal Viable Information) documents. MVI is the output format produced by the `context-harvest` and `context-extract` OpenCode commands. Every MVI document must conform to the structure, sectioning, and validation rules defined here.

## Frontmatter Fields

Every MVI document must begin with YAML frontmatter. The following fields are recognised:

| Field | Required | Condition | Description |
|---|---|---|---|
| `source` | Yes | Always | Origin file path (relative to project root) or URL |
| `harvested` | Yes | For context-harvest | ISO 8601 timestamp when content was extracted |
| `fetched` | Yes | For context-extract URLs | ISO 8601 timestamp when URL was fetched |
| `source_url` | Yes | For URL sources | The full URL the content was fetched from |

All required fields must be present when their condition is met. Additional custom fields are permitted but not required.

## Core Concept

1-3 sentences capturing the essential idea. Not a summary -- the minimal understanding needed to recognise when this context applies. Must stand alone without the rest of the document.

The reader should be able to read only this section and know whether the document is relevant to their current task.

## Key Points

3-5 bullet points ordered by importance. Must be specific and actionable. No generic filler.

Preferred patterns:

- concrete statements with measurable outcomes
- direct guidance the reader can apply immediately
- caveats and constraints where they affect decisions

Avoid:

- phrases like "it is important to" or "this helps with"
- passive introductory filler
- restating the core concept in list form

## Example

A minimal working example, preferably 20 lines or fewer. Must be copy-paste usable when applicable. Use fenced code blocks with a language tag.

When an example is not applicable (for example, the topic is purely conceptual), include a brief explanation of why and what the reader should reference instead.

Preferred:

- realistic inputs and outputs
- copy-paste runnable snippets
- inline comments for non-obvious behaviour
- clear demonstration of the concept

Avoid:

- examples that require significant setup not shown
- truncated or pseudo-code that cannot run
- examples exceeding 20 lines without strong justification

## Reference

Source attribution and cross-references. The reference section must include the originating source, and may include related context files.

Format:

```
- Source: path/to/origin/file.md
- Related: concepts/related-topic.md
- Related: guides/adjacent-workflow.md
```

The `source` field in the frontmatter and the Source line in this section must match.

## Validation Rules

All MVI documents must pass the following validation checks:

| Rule | Enforcement | Notes |
|---|---|---|
| Frontmatter must be valid YAML | Hard | Parser must not error |
| All four sections present and non-empty | Hard | Core Concept, Key Points, Example, Reference must all exist |
| `source` field matches actual origin | Hard | File path or URL must be accurate |
| `harvested`/`fetched` fields valid ISO 8601 | Hard | Compliant timestamps required when present |
| Example section 20 lines or fewer | Soft | Exceptions require justification |
| Output in `.opencode/context/<category>/` | Hard | No loose files at the context root |
| File does not exceed 200 lines | Hard | Total document length limit |

Hard rules produce a validation failure. Soft rules produce a warning.

## Category Structure

MVI output files must reside in one of five standard categories under `.opencode/context/`:

| Category | Purpose |
|---|---|
| `concepts/` | Architectural and design rationale |
| `guides/` | How-to instructions and workflows |
| `examples/` | Code-focused demonstrations |
| `lookup/` | API signatures, configuration schemas, quick references |
| `errors/` | Recurring errors, debugging patterns, resolutions |

Every MVI document must be placed in the category that best matches its primary purpose. A document may link to documents in other categories via the Related field in its Reference section, but it must have exactly one primary category.

## Final Principle

Your responsibility is not merely to produce machine-readable context files.

Your responsibility is to ensure every MVI document is structurally valid, self-contained, discoverable by category, and useful to the agent or human that reads it next.
