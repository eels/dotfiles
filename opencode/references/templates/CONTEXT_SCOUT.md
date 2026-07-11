---
description: Canonical response format templates for the @context-scout agent output.
---

# Context Scout Response Templates

This document provides canonical response format templates for the `@context-scout` agent. The agent loads these on demand when returning context discovery results.

## Response Format

Use this structure when returning verified, priority-ranked context files to the caller. Every response must follow this format.

```markdown
# Context Files Found

## Critical Priority

**File**: `.opencode/context/path/to/file.md`
**Contains**: What this file covers — matching the user's intent

## High Priority

**File**: `.opencode/context/another/file.md`
**Contains**: What this file covers

## Medium Priority

**File**: `.opencode/context/optional/file.md`
**Contains**: What this file covers
```

Include only priority levels that have results. If no files match a priority level, omit it entirely.

## Cached External Context

When cached external docs exist for a framework or library with no internal coverage, append this section after the priority-ranked results.

```markdown
## Cached External Context Found

The framework **[Name]** has no internal coverage, but cached external docs exist.

**File**: `.opencode/external-context/[name]/...`

→ These docs are available locally. No fetch needed.
```

## External Scout Recommendation

When no internal or cached external context exists for a mentioned framework or library, append this section after the priority-ranked results.

```markdown
## @external-context-scout Recommendation

The framework **[Name]** has no internal or cached external context coverage.

→ Invoke `@external-context-scout` for [Name]: [user's question]
```

## Usage

When returning context discovery results, load this file and follow the Response Format structure. Append Cached External Context or External Scout Recommendation sections only when applicable. Fill in file paths and summaries with verified content specific to the user's intent.
