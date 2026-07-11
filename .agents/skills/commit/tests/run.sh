#!/bin/bash
# Zero-deps test runner for the commit skill scripts.
#
# Each test_* function in tests/*.test runs in its own subshell against an
# ephemeral git repo seeded by setup(). teardown() removes it. Helpers
# capture STATUS / STDOUT / STDERR for assertions.
#
# Usage: bash tests/run.sh [test_name_filter]

set -uo pipefail

TESTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(cd "$TESTS_DIR/.." && pwd)"
SCRIPT="$SKILL_DIR/scripts/validate-and-commit.sh"

FILTER="${1:-}"

# ---------- per-test fixtures ----------

setup() {
    TEST_TMP=$(mktemp -d -t claude-commit-test)
    TEST_REPO="$TEST_TMP/repo"
    TEST_TMPDIR="$TEST_TMP/tmp"
    mkdir -p "$TEST_REPO" "$TEST_TMPDIR"
    cd "$TEST_REPO"
    git init -q -b main
    git config user.email "test@example.com"
    git config user.name "Test User"
    git config commit.gpgsign false
    # Override any inherited core.hooksPath so .git/hooks/* in this repo
    # actually run during the test (tests install fixture hooks there).
    git config core.hooksPath .git/hooks
    export TMPDIR="$TEST_TMPDIR"
}

teardown() {
    cd /
    rm -rf "$TEST_TMP"
}

stage_change() {
    local name="${1:-file.txt}"
    local content="${2:-content}"
    printf '%s\n' "$content" > "$TEST_REPO/$name"
    git -C "$TEST_REPO" add "$name"
}

# Drive the repo into an in-progress merge (MERGE_HEAD present) whose
# conflict has been resolved and staged. resolution="ours" resolves to
# HEAD's content, leaving the index byte-identical to HEAD (the empty-
# resolution merge); resolution="custom" stages content differing from
# both parents.
setup_resolved_merge() {
    local resolution="${1:-ours}"
    printf 'base\n' > "$TEST_REPO/conflict.txt"
    git -C "$TEST_REPO" add conflict.txt
    git -C "$TEST_REPO" commit -q -m "base"
    git -C "$TEST_REPO" checkout -q -b side
    printf 'side\n' > "$TEST_REPO/conflict.txt"
    git -C "$TEST_REPO" commit -q -am "side change"
    git -C "$TEST_REPO" checkout -q main
    printf 'main\n' > "$TEST_REPO/conflict.txt"
    git -C "$TEST_REPO" commit -q -am "main change"
    git -C "$TEST_REPO" merge side >/dev/null 2>&1
    if [[ "$resolution" == "ours" ]]; then
        git -C "$TEST_REPO" checkout --ours conflict.txt
    else
        printf 'resolved\n' > "$TEST_REPO/conflict.txt"
    fi
    git -C "$TEST_REPO" add conflict.txt
}

# Run wrapper with stdin from arg 1 plus optional positional args.
run_script() {
    local stdin_input="$1"; shift
    local out_file err_file
    out_file=$(mktemp)
    err_file=$(mktemp)
    printf '%s' "$stdin_input" | "$SCRIPT" "$@" >"$out_file" 2>"$err_file"
    STATUS=$?
    STDOUT=$(<"$out_file")
    STDERR=$(<"$err_file")
    rm -f "$out_file" "$err_file"
}

# Run wrapper with no stdin (file-arg mode).
run_script_no_stdin() {
    local out_file err_file
    out_file=$(mktemp)
    err_file=$(mktemp)
    "$SCRIPT" "$@" </dev/null >"$out_file" 2>"$err_file"
    STATUS=$?
    STDOUT=$(<"$out_file")
    STDERR=$(<"$err_file")
    rm -f "$out_file" "$err_file"
}

# ---------- assertions ----------

fail() {
    printf '    %s\n' "$@"
    return 1
}

assert_status() {
    local expected="$1"
    [[ "$STATUS" == "$expected" ]] || fail \
        "expected status $expected, got $STATUS" \
        "stderr: $STDERR" \
        "stdout: $STDOUT"
}

assert_status_nonzero() {
    [[ "$STATUS" -ne 0 ]] || fail \
        "expected non-zero status, got 0" \
        "stdout: $STDOUT"
}

assert_stderr_contains() {
    local needle="$1"
    [[ "$STDERR" == *"$needle"* ]] || fail \
        "expected stderr to contain: $needle" \
        "actual stderr: $STDERR"
}

assert_no_commits() {
    local count
    count=$(git -C "$TEST_REPO" rev-list --count --all 2>/dev/null || echo 0)
    [[ "$count" == 0 ]] || fail "expected no commits, found $count"
}

assert_commit_message() {
    local expected="$1"
    local actual
    actual=$(git -C "$TEST_REPO" log -1 --format=%B)
    # git -log %B appends a trailing newline; strip it for comparison.
    actual="${actual%$'\n'}"
    [[ "$actual" == "$expected" ]] || fail \
        "commit message mismatch" \
        "expected: $(printf '%q' "$expected")" \
        "actual:   $(printf '%q' "$actual")"
}

assert_path_staged() {
    local path="$1"
    git -C "$TEST_REPO" diff --staged --name-only | grep -qx "$path" || \
        fail "expected $path to be staged"
}

assert_merge_in_progress() {
    git -C "$TEST_REPO" rev-parse -q --verify MERGE_HEAD >/dev/null || \
        fail "expected MERGE_HEAD to still exist (merge state consumed)"
}

assert_tmpdir_clean() {
    local leftovers
    leftovers=$(ls "$TEST_TMPDIR" 2>/dev/null | grep -E '^claude-commit-msg\.' || true)
    [[ -z "$leftovers" ]] || fail \
        "expected no leftover temp files, found: $leftovers"
}

# ---------- discover & run ----------

# shellcheck disable=SC1090
for f in "$TESTS_DIR"/*.test; do
    [[ -f "$f" ]] || continue
    source "$f"
done

passed=0
failed=0
failed_names=()

for fn in $(declare -F | awk '/^declare -f test_/ {print $3}' | sort); do
    if [[ -n "$FILTER" && "$fn" != *"$FILTER"* ]]; then
        continue
    fi

    output=$(
        {
            setup
            "$fn"
            rc=$?
            teardown
            exit $rc
        } 2>&1
    )
    rc=$?

    if [[ $rc -eq 0 ]]; then
        printf '  ok   %s\n' "$fn"
        ((passed++)) || true
    else
        printf '  FAIL %s\n' "$fn"
        if [[ -n "$output" ]]; then
            printf '%s\n' "$output" | sed 's/^/      /'
        fi
        ((failed++)) || true
        failed_names+=("$fn")
    fi
done

echo
echo "$passed passed, $failed failed"
[[ $failed -eq 0 ]]
