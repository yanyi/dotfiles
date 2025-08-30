---
allowed-tools: Bash(git add:*), Bash(GIT_PAGER= git status:*), Bash(git commit:*)
description: Create a git commit
---

## Context

- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff HEAD`

## Your Task

Based on the changes above, consult any dev plan and commit atomically. Follow the standards below on commit message style.

## Commit Standards

### Core Principles
- **Group related changes**: Stage implementation and test files together. Avoid `git add .` - be intentional about what goes in each commit
- **Atomic commits**: Each commit should be a complete, working unit that doesn't break the build
- **Clear messages**: Use format `component: action description` under 50 characters

### Message Format
- **Structure**: `[component]: [action] [description]` (e.g., `auth: add password validation`)
- **Component**: Use the specific module/package name
- **Action**: Imperative verbs like "add", "fix", "update", "remove", "refactor"
- **Body (optional)**: Add details when the change needs explanation - why it was needed, context, or breaking changes

### Workflow

1. **Review changes**:
   ```bash
   git status
   git diff
   ```

2. **Stage related files together**:
   ```bash
   git add src/components/button.js src/components/button.test.js
   ```

3. **Verify your commit scope**:
   ```bash
   git diff --staged
   ```

4. **Commit with clear message**:
   ```bash
   # Simple commit (most common)
   git commit -m "ui: add button hover animation"
   
   # With body when context is needed
   git commit -m "api: change user endpoint response format" -m "Updates response to include user preferences object. Breaking change for mobile clients - coordinate deployment."
   ```

Create commits that tell a clear story of what changed and why. Each commit should leave the codebase in a working state.
