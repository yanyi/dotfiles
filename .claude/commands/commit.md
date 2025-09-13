---
allowed-tools: Bash(git add:*), Bash(GIT_PAGER= git status:*), Bash(git commit:*)
description: Create a git commit
---

## Context

- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff HEAD`

## Standards

- **Format**: `component: action description` (max 50 chars)
- **Component**: Specific module/package name
- **Action**: Imperative verbs (add, fix, update, remove, refactor)
- **Body**: Explain decisions, not obvious changes. Proper punctuation. Max 72 chars per line.
- **Staging**: Group related files. Avoid `git add .`

```bash
git commit -m "ui: add button hover animation" -m "Improves user feedback on interactive elements."

git commit -m "api: change user endpoint format" -m "Includes user preferences to reduce client requests.
Breaking change - coordinate mobile deployment."
```
