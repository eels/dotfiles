---
description: Commit changed files
agent: implement
subtask: true
---

Analyze all uncommitted changes in this repository by running `git status --short`, `git diff`, `git diff --cached`, and `git log --oneline -20`.

Your job is to group the changes into logical, independent commits and execute them one by one using `git add` then `git commit`.

**Principles:**
- **Logical grouping** — group related changes, split unrelated ones.
- **Match convention** — follow the repo's existing commit style.
- **Self-explanatory** — commit body only when needed.
- **No attribution** — never add AI-generated credit.

**Workflow:**
1. Run `git status --short`, `git diff`, `git diff --cached`, and `git log --oneline -20`.
2. Group changes into logical, independent commits.
3. Commit each group using `git add` then `git commit`.
4. Confirm each commit succeeded.
5. Print a final summary.

**Rules:**
- Group unrelated changes into separate commits (e.g., dep bumps in one commit, feature work in another, fixes in another).
- Include untracked files where they belong to a logical group.
- Infer any existing message format convention from the recent `git log` output — match it.
- Default to the conventional commits format (`type(scope): description`) if no convention exists.
- Use imperative mood, no trailing period.
- Less than 50 characters is ideal with a hard cap around the 72 character limit.
- Skip adding a body when the subject is self-explanatory.
- Add a body only for non-obvious why, breaking changes, migration notes, linked issues.
- Commit automatically — do not ask for confirmation.
- Do NOT push.
- Never add any AI attribution.

**Priorities (first match wins):**
1. If ALL changes are in a single coherent concern → one commit.
2. If changes span multiple clear concerns → multiple commits.
3. If changes are interdependent → one commit with a broad scope.

**Validation:**
- Confirm each commit was created successfully.
- Verify no expected changes remain uncommitted.
- Ensure commit messages match the repository convention.

When complete, provide a final summary including:
- Number of commits made.
- List of commit messages.
- Any files left uncommitted (if any) and why.
