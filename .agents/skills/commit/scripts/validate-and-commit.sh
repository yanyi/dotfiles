#!/bin/bash
# validate-and-commit.sh — validate commit message format, then create the
# commit in one step. The skill's only entry point for committing, so the
# PreToolUse hook never has to see a bare `git commit` from the agent.
#
# Usage:
#   validate-and-commit.sh <<'EOF' ... EOF
#   validate-and-commit.sh path/to/message.txt
#
# Exit codes:
#   0   committed successfully
#   1   validation error, missing input, no staged changes, or a merge in
#       progress (merges are concluded via `git merge --continue`, not here)
#   N   propagated from `git commit` (e.g. pre-commit hook rejected)

set -o pipefail

commit_regex='^.{1,50}$'
body_regex='^.{0,72}$'

# Stage the authored message in a temp file we own so we can validate it,
# then hand the same bytes to `git commit -F`. Trap guarantees cleanup on
# every exit path (success, validation error, commit failure).
msg_file=$(mktemp -t claude-commit-msg.XXXXXX) || {
    echo "Error: could not create temporary message file." >&2
    exit 1
}
trap 'rm -f "$msg_file"' EXIT

if [[ $# -ge 1 && -f "$1" ]]; then
    cat "$1" > "$msg_file"
elif [[ ! -t 0 ]]; then
    cat > "$msg_file"
else
    echo "Usage: $0 <commit-message-file>" >&2
    echo "   or: $0 <<'EOF' ... EOF" >&2
    exit 1
fi

# Read only the authored message: ignore Git comment lines and stop before
# any verbose diff section.
lines=()
# `|| [[ -n "$line" ]]` catches a final line that lacks a trailing newline
# (heredocs without an explicit \n, agent-piped input, etc.) so we don't
# silently drop the last authored line during validation.
while IFS= read -r line || [[ -n "$line" ]]; do
    if [[ "$line" == diff\ --git\ * ]]; then
        break
    fi
    if [[ "$line" == \#* ]]; then
        continue
    fi
    lines+=("$line")
done < "$msg_file"

title="${lines[0]:-}"
errors=0

if ! [[ "$title" =~ $commit_regex ]]; then
    echo "Error: Commit title must be 1-50 characters" >&2
    echo "  Title: '$title' (${#title} chars)" >&2
    errors=$((errors + 1))
fi

for i in "${!lines[@]}"; do
    if [[ $i -gt 0 && -n "${lines[i]}" ]] && ! [[ "${lines[i]}" =~ $body_regex ]]; then
        echo "Error: Body line $((i + 1)) exceeds 72 characters" >&2
        echo "  Line: '${lines[i]}' (${#lines[i]} chars)" >&2
        errors=$((errors + 1))
    fi
done

if (( errors > 0 )); then
    echo "" >&2
    echo "Found $errors validation error(s). Please fix and try again." >&2
    exit 1
fi

# Merge conclusions do not go through this script: they are not authored
# commits (git generates the message from MERGE_MSG) and they can be valid
# even when the resolved tree is byte-identical to HEAD, which the staged-
# emptiness check below would wrongly reject. Route them to git's own verb.
if git rev-parse -q --verify MERGE_HEAD >/dev/null; then
    echo "Error: a merge is in progress; this script only creates authored commits." >&2
    echo "Conclude the merge with: git add <resolved files> && git merge --continue" >&2
    exit 1
fi

# Refuse to commit when nothing is staged so the agent gets a clear signal
# instead of git's "nothing to commit, working tree clean" message.
if git diff --staged --quiet; then
    echo "Error: no staged changes to commit." >&2
    echo "Stage files explicitly with 'git add <file>' first." >&2
    exit 1
fi

# Hand the validated message to git via -F so multi-line bodies and
# whitespace are preserved exactly. Propagate git's exit code so pre-commit
# hook failures (or any other commit-time error) surface to the caller.
git commit -F "$msg_file"
