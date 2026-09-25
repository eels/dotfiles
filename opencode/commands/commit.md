---
description: Commit changed files
agent: build
subtask: false
---

Your job is to group the changes into logical, independent commits and execute them one by one using `git add` then `git commit`.

Phase 1 - Overview (grouping decisions only):

Run these three commands to understand the scope of changes. Do NOT fetch diffs yet.

1. `git status --short` — file list with status (M, A, D, ??)
2. `git diff --stat` — file-level insertions/deletions per file
3. `git log --oneline -20` — recent commit style reference

Using only this lightweight output, group related files into logical commits. Filenames, paths, status, and change magnitude are usually sufficient for grouping — you do not need the full diff content.

Priorities (first match wins):

1. If ALL changes are in a single coherent concern → one commit.
2. If changes span multiple clear concerns → multiple commits.
3. If changes are interdependent → one commit with a broad scope.

Principles:

- **Logical grouping** - group related changes, split unrelated ones.
- **Match convention** - follow the repo's existing commit style.
- **Self-explanatory** - commit body only when needed.
- **No attribution** - never add AI-generated credit.

Rules:

- Group unrelated changes into separate commits (e.g., dep bumps in one commit, feature work in another, fixes in another).
- Include untracked files where they belong to a logical group.
- Infer any existing message format convention from the recent `git log` output - match it.
- Default to the conventional commits format (`type(scope): description`) if no convention exists.
- Use imperative mood, no trailing period.
- Less than 50 characters is ideal with a hard cap around the 72 character limit.
- Skip adding a body when the subject is self-explanatory.
- Add a body only for non-obvious why, breaking changes, migration notes, linked issues.
- Do NOT push.
- Never add any AI attribution.

Phase 2 - Targeted diff per group (message writing only):

For each group decided in Phase 1:

1. Run `git diff -- <file1> <file2> ...` scoped to only the files in that group. Do not fetch diffs for the entire repo.
2. Read the targeted diff to craft an accurate commit message.
3. Run `git add` for the group's files, then `git commit` with the crafted message.
4. Confirm the commit succeeded.

Repeat for each group, committing one group at a time.

Validation:

- Confirm each commit was created successfully.
- Verify no expected changes remain uncommitted.
- Ensure commit messages match the repository convention.

When complete:

- Report outcome briefly (1-3 lines) unless issues occurred.
- Include, where relevant: number of commits made and their messages, and any files left uncommitted and why.
- If blockers, revisions, or risks existed, explain them.
- Only generate a full summary if the user explicitly asks.
