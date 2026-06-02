---
description: Commit changes in logical groups
agent: implement
---

Analyze all uncommitted changes in this repository by running `git status --short`, `git diff`, `git diff --cached`, and `git log --oneline -20`.

Your job is to group the changes into logical, independent commits and execute them one by one using `git add` then `git commit`.

**Rules:**
- Group unrelated changes into separate commits (e.g., dep bumps in one commit, feature work in another, fixes in another).
- Include untracked files where they belong to a logical group.
- Infer any existing message format convention from the recent `git log` output — match it.
- Use conventional commits format (`type(scope): description`) if not convention already exists.
- Use imperative mood, no trailing period.
- Commit automatically — do not ask for confirmation.
- Do NOT push.

**Priorities (first match wins):**
1. If ALL changes are in a single coherent concern → one commit.
2. If changes span multiple clear concerns → multiple commits.
3. If changes are interdependent → one commit with a broad scope.

After each commit confirm it succeeded. When finished print a summary:
- Number of commits made
- List of commit messages
- Any files left uncommitted (if any) and why
