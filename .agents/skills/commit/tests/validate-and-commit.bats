#!/usr/bin/env bats

bats_require_minimum_version 1.5.0

# Bats coverage for scripts/validate-and-commit.sh.

setup() {
    SKILL_DIR="$(cd "$BATS_TEST_DIRNAME/.." && pwd)"
    SCRIPT="$SKILL_DIR/scripts/validate-and-commit.sh"

    TEST_REPO="$BATS_TEST_TMPDIR/repo"
    TEST_TMPDIR="$BATS_TEST_TMPDIR/tmp"
    mkdir -p "$TEST_REPO" "$TEST_TMPDIR"
    cd "$TEST_REPO"
    git init -q -b main
    git config user.email "test@example.com"
    git config user.name "Test User"
    git config commit.gpgsign false
    git config core.hooksPath .git/hooks
    export TMPDIR="$TEST_TMPDIR"
}

teardown() {
    cd /
}

stage_change() {
    local name="${1:-file.txt}"
    local content="${2:-content}"
    printf '%s\n' "$content" > "$TEST_REPO/$name"
    git -C "$TEST_REPO" add "$name"
}

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
    git -C "$TEST_REPO" merge side >/dev/null 2>&1 || true
    if [[ "$resolution" == "ours" ]]; then
        git -C "$TEST_REPO" checkout --ours conflict.txt
    else
        printf 'resolved\n' > "$TEST_REPO/conflict.txt"
    fi
    git -C "$TEST_REPO" add conflict.txt
}

run_script() {
    local stdin_input="$1"
    shift

    run --separate-stderr "$SCRIPT" "$@" <<<"$stdin_input"
}

run_script_no_stdin() {
    run --separate-stderr "$SCRIPT" "$@" </dev/null
}

assert_status() {
    [ "$status" -eq "$1" ]
}

assert_status_nonzero() {
    [ "$status" -ne 0 ]
}

assert_stderr_contains() {
    [[ "$stderr" == *"$1"* ]]
}

assert_no_commits() {
    [ "$(git -C "$TEST_REPO" rev-list --count --all)" -eq 0 ]
}

assert_commit_message() {
    local expected="$1"
    local actual
    actual="$(git -C "$TEST_REPO" log -1 --format=%B)"
    actual="${actual%$'\n'}"
    [ "$actual" = "$expected" ]
}

assert_path_staged() {
    git -C "$TEST_REPO" diff --staged --name-only | grep -qx "$1"
}

assert_merge_in_progress() {
    git -C "$TEST_REPO" rev-parse -q --verify MERGE_HEAD >/dev/null
}

assert_tmpdir_clean() {
    local leftovers=("$TEST_TMPDIR"/claude-commit-msg.*)
    [ ! -e "${leftovers[0]}" ]
}

@test "rejects long title" {
    stage_change
    run_script 'this title is way way way way way way way way way too long for the limit'
    assert_status_nonzero
    assert_stderr_contains "1-50 characters"
    assert_no_commits
}

@test "rejects long body line" {
    stage_change
    run_script 'subject

this body line is way way way way way way way way way way way way way too long for the limit'
    assert_status_nonzero
    assert_stderr_contains "exceeds 72"
    assert_no_commits
}

@test "reports multiple validation errors" {
    stage_change
    run_script 'this title is way way way way way way way way way too long for the limit

this body line is way way way way way way way way way way way way way too long for the limit'
    assert_status_nonzero
    assert_stderr_contains "1-50 characters"
    assert_stderr_contains "exceeds 72"
    assert_no_commits
}

@test "ignores long comment lines" {
    stage_change
    run_script 'subject

# this is a # comment line that is way way way way way way way way way too long for the limit
short body line'
    assert_status 0
}

@test "rejects long merge-titled authored commits" {
    stage_change
    run_script "Merge branch 'feature/some-very-long-feature-name-that-exceeds-fifty-chars'"
    assert_status_nonzero
    assert_stderr_contains "1-50 characters"
    assert_no_commits
}

@test "refuses a merge in progress" {
    setup_resolved_merge custom
    run_script "Merge branch 'side'"
    assert_status_nonzero
    assert_stderr_contains "merge is in progress"
    assert_stderr_contains "git merge --continue"
    assert_merge_in_progress
}

@test "refuses a merge whose resolution matches HEAD" {
    setup_resolved_merge ours
    run_script "Merge branch 'side'"
    assert_status_nonzero
    assert_stderr_contains "git merge --continue"
    assert_merge_in_progress
}

@test "errors when nothing is staged" {
    run_script 'subject

body'
    assert_status_nonzero
    assert_stderr_contains "no staged changes"
    assert_no_commits
}

@test "commits with the exact authored message" {
    stage_change
    local msg='module: subject line

body line one
body line two'
    run_script "$msg"
    assert_status 0
    assert_commit_message "$msg"
}

@test "preserves staging after validation failure" {
    stage_change "kept.txt"
    run_script 'this title is way way way way way way way way way too long for the limit'
    assert_status_nonzero
    assert_no_commits
    assert_path_staged "kept.txt"
}

@test "cleans up temp files on success" {
    stage_change
    run_script 'subject

body'
    assert_status 0
    assert_tmpdir_clean
}

@test "cleans up temp files on failure" {
    stage_change
    run_script 'this title is way way way way way way way way way too long for the limit'
    assert_status_nonzero
    assert_tmpdir_clean
}

@test "propagates a git commit failure" {
    stage_change
    cat > "$TEST_REPO/.git/hooks/pre-commit" <<'HOOK'
#!/bin/bash
echo "pre-commit rejected" >&2
exit 1
HOOK
    chmod +x "$TEST_REPO/.git/hooks/pre-commit"

    run_script 'subject

body'
    assert_status_nonzero
    assert_no_commits
}

@test "accepts stdin input" {
    stage_change
    run_script 'subject

body'
    assert_status 0
}

@test "accepts a file argument" {
    stage_change
    local msg_file="$BATS_TEST_TMPDIR/msg.txt"
    cat > "$msg_file" <<'EOF'
subject

body
EOF
    run_script_no_stdin "$msg_file"
    assert_status 0
    assert_commit_message 'subject

body'
}
