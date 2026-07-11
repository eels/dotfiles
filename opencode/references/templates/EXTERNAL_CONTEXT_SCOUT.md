---
description: Canonical file format template for persisted external documentation used by the @external-context-scout agent.
---

# External Context Scout File Format

This document provides the canonical file format for persisted external documentation. The `@external-context-scout` agent loads this on demand when writing fetched documentation to disk.

## Persisted File Format

Every file written to `.opencode/external-context/` must include a YAML frontmatter header with the fields below, followed by the filtered documentation content.

```markdown
---
source: Context7 API | DeepWiki | Official Documentation
library: {library-name}
package: {package-name}
topic: {topic}
fetched: {ISO timestamp}
official_docs: {link}
---

{filtered documentation content}
```

### Field Reference

| Field | Required | Description |
|-------|----------|-------------|
| `source` | Yes | Which source the documentation was fetched from |
| `library` | Yes | Human-readable library name |
| `package` | Yes | NPM or package identifier |
| `topic` | Yes | Specific topic or feature documented |
| `fetched` | Yes | ISO 8601 timestamp of when the content was fetched |
| `official_docs` | Yes | Link to the official documentation source |

All fields are required. The file must be written to `.opencode/external-context/{package-name}/{topic}.md`.

## Usage

When persisting fetched documentation, load this file and follow the Persisted File Format structure. Fill in each field with values specific to the library and content being persisted. Confirm the file exists on disk after writing.
