---
description: Harvest workspace knowledge into permanent context files
agent: implement
subtask: false
---

Your job is to scan the project workspace for knowledge — both from existing markdown files and by auto-discovering the codebase itself — and distil it into permanent, structured context files under `.opencode/context/`.

Before harvesting any files, verify that project context and reference files are already loaded in this conversation. If they are not, invoke `@context-scout` to discover project context and load relevant reference files from `~/dotfiles/opencode/references/` before scanning the workspace. Harvesting without project context produces context files that drift from project standards — verify context is loaded first.

This command operates in two phases: codebase auto-discovery (Phase 1) and markdown harvest (Phase 2).

Use the MVI (Minimal Viable Information) format defined at `~/dotfiles/opencode/references/MVI_FORMAT.md` for all output files.

Auto-scaffold `.opencode/context/<category>/` directories as needed. On the first-ever creation of `.opencode/context/`, also create an `_INDEX_.md` explaining the category structure and MVI format.

Workflow:

Phase 1 — Codebase Auto-Discovery:

1. Probe the project root for configuration and registry files: `package.json`, `Cargo.toml`, `pyproject.toml`, `composer.json`, `Gemfile`, `go.mod`, `setup.py`, `CMakeLists.txt`, `tsconfig.json`, `.eslintrc*`, `prettier.config.*`, `vite.config.*`, `next.config.*`, `vitest.config.*`, `jest.config.*`, `.editorconfig`, `.nvmrc`, `.node-version`.
2. Perform a shallow directory scan (depth ≤ 3) to identify module boundaries — look for `src/`, `lib/`, `api/`, `app/`, `packages/`, `apps/`, `backend/`, `frontend/`, `services/`.
3. Glob for test files (`**/*.test.*`, `**/*.spec.*`, `__tests__/`) with a sampling limit of 10 to infer testing conventions.
4. From the information gathered, compose relevant categorised MVI-formatted context files in a similar fashion to Phase 2.
5. Present a pre-flight summary: "Auto-discovery found: {list of detected sources}. Create {N} context files? (Y/n)"
6. If confirmed, write files following the MVI format. If any file already exists, ask before overwriting. Include detected sources as `source` in frontmatter (e.g., "package.json, tsconfig.json").

Example outputs of auto-discovered context:

- `.opencode/context/concepts/tech-stack.md` — language, framework, key dependencies (runtime + dev), build tooling, package manager
- `.opencode/context/concepts/project-architecture.md` — module boundaries, architectural layers, monorepo structure, entry points
- `.opencode/context/concepts/project-conventions.md` — config conventions, test framework and patterns, naming conventions, export patterns, strictness settings

Phase 2 — Markdown Harvest:

1. Scan all `.md` files in the project recursively, excluding `node_modules/`, `.git/`, `dist/`, `build/`, `.opencode/`, and `.tmp/`.
2. Present a pre-flight summary: "Found {N} markdown files. Harvest all? (Y/n)" — if declined, skip Phase 2.
3. For each file, check whether existing context under `.opencode/context/` already covers the same topic — ask before overwriting; disambiguate with a distinct filename otherwise.
4. Classify each file into a category: `concepts/`, `guides/`, `examples/`, `lookup/`, `errors/`. When ambiguous, default to `concepts/`.
5. Write MVI-formatted file to `.opencode/context/<category>/<descriptive-name>.md` with `source` and `harvested` in frontmatter. Follow the MVI spec at `~/dotfiles/opencode/references/MVI_FORMAT.md`.
6. Leave original source files in place.

Rules:

- Never delete, move, or archive original source files.
- Never overwrite existing context without asking the user.
- Always follow the MVI format defined at `~/dotfiles/opencode/references/MVI_FORMAT.md`.
- Always include `source` and `harvested` frontmatter fields in every output file.
- Always auto-scaffold `.opencode/context/<category>/` if it does not exist.
- For auto-discovery: include the sources probed as `source` in frontmatter (e.g., "package.json, tsconfig.json").
- Keep category directories flat — no nesting inside categories.

Priorities (first match wins):

1. If existing context covers the same topic as a selected file → ask before overwriting.
2. If existing context covers a different topic → disambiguate with a distinct filename.
3. If auto-discovery finds no config files or detectable structure → report and skip Phase 1.
4. If the user declines the auto-discovery pre-flight prompt → skip Phase 1.
5. If the user declines the markdown harvest pre-flight prompt → skip Phase 2.

Validation:

- Ensure each MVI document follows the canonical MVI format with all required frontmatter fields.
- Ensure no original source files were deleted, moved, or archived.
- Ensure `.opencode/context/` directory structure remains coherent.
- For auto-discovery: validate that produced context reflects actual codebase contents.
- Confirm `_INDEX_.md` was created when `.opencode/context/` was first created.

When complete, provide a final summary including:

- Number of markdown files harvested and their categories.
- Auto-discovered context files created (or note if none were created).
- Whether any overwrites were approved or rejected.
- List of original files left in place.

context-harvest: $ARGUMENTS
