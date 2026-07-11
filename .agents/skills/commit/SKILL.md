---
name: commit
description: "Use for all git commits. Review and stage the intended files, then use this skill's validation script instead of invoking git commit directly. Creates atomic commits with required formatting and an explanatory body. Triggers: commit, commit the changes, commit staged changes, make a commit, create a commit, git commit, save changes, commit my work, commit this, commit code, committing, yes commit, go ahead and commit, lgtm commit."
---

## Context

- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff HEAD`

## Instructions

Analyze the changes above and create atomic commits. An atomic commit must
contain one logically coherent change: group all files required for that
change, but split unrelated changes into separate commits. If the intended
grouping is unclear, ask the user before staging. If no changes exist, inform
the user and stop.

## Commit Format

```
<scope>: <imperative description>

<body explaining the problem and rationale>
```

### Rules

- **Scope**: Identify the affected area using the lowest meaningful directory or package level (e.g., `service`, `cache`, or `fish`)
- **Outcome**: Describe the resulting behavior or purpose, not merely the files or mechanism involved
- **Lowercase** after the colon
- **Imperative mood**: add, fix, implement, refactor, remove (not added, fixes)
- **No period** at end of subject line
- **Subject line**: ≤50 characters
- **Body lines**: wrap at 72 characters

Prefer a specific outcome over a vague description:

```
cache: evict expired entries
```

Avoid titles that only describe the implementation or touched files:

```
cache: update code
```

### Body

**MUST always include a commit body unless one of the exceptions below
applies.** Commits serve as an audit log — the body captures the reasoning
behind a change so future readers understand WHY, not just what.

The body's job is to answer: **"Why was this change necessary?"** Include
the motivation, the problem, relevant context, and any important constraint
or consequence.

Do not turn the body into a file-by-file changelog. Mention what changed
when it is necessary to make the reasoning understandable. For a simple
change, one or two precise sentences are better than padding the body.

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

- Start with the problem, failure, or constraint that motivated the change.
- Explain why the existing behavior was insufficient or risky.
- Include the relevant rationale, tradeoff, or resulting guarantee.
- **WHY, not a changelog**: Do not restate the diff file by file; mention the change only as needed to explain the reasoning.
- Ask yourself: "If someone reads only this body (not the diff), do they understand the reason for this change?"
- Reference issue or incident identifiers when they provide useful context.
- Use bullet points for multiple related reasons
- Wrap lines at 72 characters

## Workflow

1. **Check for changes**: If `git status` shows no modifications, inform the user and stop.

2. **Stage specific files**: Never use `git add .` - explicitly stage files:
   When multiple logical changes exist, stage and commit one group at a time,
   then repeat this workflow for each remaining group.

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
   service: retry transient request failures

   Requests can arrive before the remote service has finished
   processing the preceding operation. Retry transient failures so
   callers do not receive a hard error for a timing issue.
   EOF
   ```
