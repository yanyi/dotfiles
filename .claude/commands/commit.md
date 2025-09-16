---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*)
description: Create a git commit
---

## Context

- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff HEAD`

## Standards

- **Format**: `component: action description` (max 50 chars).
- **Component**: Specific module/package name.
- **Action**: Imperative verbs (add, fix, update, remove, refactor).
- **Body**: Explain decisions, not obvious changes. Proper punctuation. **STRICT 72 chars per line limit**.
- **Staging**: Group related files. Avoid `git add .`.
- **Line wrapping**: Break long body text across multiple lines, each under 72 chars.

```bash
git commit -m "$(cat <<'EOF'
ui: add button hover animation

Improves user feedback on interactive elements.
EOF
)"

git commit -m "$(cat <<'EOF'
api: change user endpoint format

Includes user preferences to reduce client requests.

Breaking change - coordinate mobile deployment.
EOF
)"

# Template with character limit guides:
git commit -m "$(cat <<'EOF'
component: action description (max 50 chars)

Body line 1 (max 72 chars)
Body line 2 (max 72 chars)
EOF
)"
```
