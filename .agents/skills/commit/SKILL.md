---
name: commit
description: "MANDATORY for ALL git commits — NEVER run git commit directly, ALWAYS invoke this skill instead. When the user says 'commit' (even as a single word with no other context), this skill MUST be used. Creates atomic commits with proper formatting following team conventions. Triggers: commit, commit the changes, commit staged changes, make a commit, create a commit, git commit, save changes, commit my work, commit this, commit code, committing, yes commit, go ahead and commit, lgtm commit."
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git diff:*), Bash($SKILL_BASE_DIR/scripts/*)
---

## Context

- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff HEAD`

## Instructions

Analyze the changes above and create an atomic commit. If no changes exist, inform the user and stop.

## Commit Format

```
<module>: <imperative description>

<body explaining WHY this change was made>

Co-authored-by: <Agent> <email>
```

### Rules

- **Scope**: Identify the affected area using the lowest meaningful directory or package level (e.g., `service`, `cache`, or `fish`)
- **Lowercase** after the colon
- **Imperative mood**: add, fix, implement, refactor, remove (not added, fixes)
- **No period** at end of subject line
- **Subject line**: ≤50 characters
- **Body lines**: wrap at 72 characters

### Body (REQUIRED)

**MUST always include a commit body.** Commits serve as an audit log — the body captures the reasoning behind a change so future readers understand WHY, not just what.

The body's job is to answer: **"Why was this change necessary?"** — the motivation, the problem, the context. NEVER list WHAT you changed — the diff already shows that. A body that restates the diff in prose is worthless.

Try your best to explain the motivation, context, or problem being solved. Even for seemingly simple changes, there is almost always a "why" worth capturing.

**Exceptions** (the ONLY cases where a body may be omitted):

- Pure mechanical renames with no behavioral change
- Dependency version bumps with no code changes
- Fixing a typo in comments or documentation

If in doubt, include the body. Err on the side of over-explaining.

#### BAD example (describes WHAT — useless, the diff shows this)

```
config: normalize relative paths

- Normalize path keys with filepath.Clean()
- Add tests for equivalent relative paths
- Simplify the lookup helper
```

This is a changelog of what was touched. A reader can see this from `git diff`. It does not explain WHY.

#### GOOD example (explains WHY — the reasoning behind the change)

```
config: normalize relative paths

Path lookups silently missed equivalent entries when paths used
inconsistent prefixes such as "./cache" and "cache". Normalizing
the keys gives lookups one representation and prevents false
missing-entry results.
```

#### GOOD example (non-obvious problem context)

```
service: retry transient request failures

Requests can arrive before the remote service has finished
processing the preceding operation. This transient timing issue
should not surface as a hard error to the caller.
```

#### Body guidelines

- **WHY, not what**: Explain the problem, motivation, or context — never restate the diff
- Ask yourself: "If someone reads only this body (not the diff), do they understand the reason for this change?"
- Reference Jira tickets for related work
- Use bullet points for multiple related reasons
- Wrap lines at 72 characters

### Co-authored-by trailer (REQUIRED)

Append a `Co-authored-by:` trailer at the end of the message, separated
from the body by a single blank line. The trailer attributes the AI agent
that authored the commit.

- **Claude Code** → `Co-authored-by: Claude <noreply@anthropic.com>`
- **Codex** → `Co-authored-by: Codex <noreply@openai.com>`

Use the line that matches the agent invoking this skill. If multiple
agents collaborated, include one trailer line per agent.

## Workflow

1. **Check for changes**: If `git status` shows no modifications, inform the user and stop.

2. **Stage specific files**: Never use `git add .` - explicitly stage files:

   ```bash
   git add pkg/cache/cache.go pkg/cache/cache_test.go
   ```

3. **Verify staged changes**:

   ```bash
   git diff --staged
   ```

4. **Validate and commit in one step**: Pipe the message into
   `validate-and-commit.sh` via heredoc. The script enforces title/body length
   limits, refuses to run if nothing is staged, and only then creates the
   commit. It exits non-zero on any failure — read the stderr, fix the
   message or staging, and re-run.

   Replace `$SKILL_BASE_DIR` with the actual "Base directory for this skill"
   path shown above. Do **not** call `git commit` directly — the project's
   PreToolUse hook blocks it; this wrapper is the only sanctioned path.

   ```bash
   $SKILL_BASE_DIR/scripts/validate-and-commit.sh <<'EOF'
   service: add retry for 400 not-ready errors

   When exponential backoff is enabled, the operation may be called
   before remote service has processed the request. Wraps this specific 400
   error with errors.Retry to trigger exponential backoff.

   Co-authored-by: Claude <noreply@anthropic.com>
   EOF
   ```
