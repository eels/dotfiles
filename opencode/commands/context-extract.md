---
description: Extract content from files, directories, or URLs into context
agent: implement
subtask: false
---

Your job is to accept a source — local file, local directory, or web URL — and distil its content into a structured, permanent context file under `.opencode/context/`.

Before extracting any content, verify that project context and reference files are already loaded in this conversation. If they are not, invoke `@context-scout` to discover project context and load relevant reference files from `~/dotfiles/opencode/references/` before processing the source. Extracting without project context produces context files that drift from project standards — verify context is loaded first.

Auto-scaffold `.opencode/context/<category>/` directories as needed. On the first-ever creation of `.opencode/context/`, also create an `_INDEX_.md` explaining the category structure and linking to the MVI format specification at `~/dotfiles/opencode/references/MVI_FORMAT.md`.

Workflow:

1. Identify the source type: local file, local directory, or web URL (must start with `http://` or `https://`).
2. Verify the source exists and is readable — for files, check the path; for directories, enumerate `.md` files (with `--recursive` for subdirectories); for URLs, extract and display the domain, then ask the user to confirm before fetching.
3. If the source references a library with cached docs in `.opencode/external-context/`, prefer the cache over fetching — notify the user and use the cached version.
4. Classify the source content into a category: `concepts/`, `guides/`, `examples/`, `lookup/`, or `errors/`. When ambiguous, default to `concepts/` and note the uncertainty in the Reference section.
5. If the source is a single file or URL and exceeds 200 lines, prompt the user: "This source is large. Distil key sections or process the whole file?"
6. If the source is a directory, present a batch prompt: "Process all N files? (y/N)" before proceeding. Each file gets its own output file — never merge multiple files into one.
7. If the target `.opencode/context/<category>/` directory does not exist, create it.
8. For each output file, write an MVI document following the format defined at `~/dotfiles/opencode/references/MVI_FORMAT.md`. For URLs, frontmatter includes `source_url` and `fetched` fields. For local files, frontmatter includes `source` with the relative project path.
9. Keep category directories flat — no nesting inside categories.
10. If the user declines domain confirmation for a URL, exit without fetching.

Rules:

- Never fetch a URL without showing the domain and asking for confirmation first.
- Never merge multiple source files into a single output file — each file gets its own.
- Never overwrite an existing context file without asking the user.
- Always create the target `.opencode/context/<category>/` directory if it does not exist.
- Always follow the MVI format defined at `~/dotfiles/opencode/references/MVI_FORMAT.md`.
- Always include `source_url` and `fetched` in frontmatter for URL sources.
- Always include `source` with the relative project path for local file sources.
- Always check `.opencode/external-context/` cache before fetching external URLs.
- Prefer meaningful category names over a flat `.opencode/context/` structure.
- Prefer caching over refetching when external-context is available.

Priorities (first match wins):

1. If the user declines domain confirmation → exit without fetching.
2. If `.opencode/external-context/` has a cache for the referenced library → use the cache and notify the user.
3. If the source content exceeds 200 lines → prompt the user to distil or process the whole file.
4. If the source is a directory → prompt with "Process all N files? (y/N)".
5. If the source is a local file → verify it exists before proceeding.
6. If category is ambiguous → default to `concepts/` and document the uncertainty.

Validation:

- Ensure the source exists and is readable before processing.
- Ensure domain was shown and confirmed for all URL sources.
- Ensure each MVI document has valid frontmatter with appropriate source fields.
- Ensure each MVI document follows the canonical MVI format defined at `~/dotfiles/opencode/references/MVI_FORMAT.md`.
- Ensure `.opencode/external-context/` was checked before fetching URLs.
- Ensure no existing context files were overwritten without approval.
- Ensure category directories remain flat with no nesting.
- Ensure `_INDEX_.md` was created when `.opencode/context/` was first created.

When complete, provide a final summary including:

- Source type and path processed.
- Number of output files created.
- Categories and filenames created under `.opencode/context/`.
- Whether the cache was used for external-context.
- Whether any overwrites were approved or rejected.
- Any content flagged as large and how it was handled.

context-extract: $ARGUMENTS
