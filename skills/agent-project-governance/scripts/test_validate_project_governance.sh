#!/bin/sh
set -u

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
VALIDATOR="$SCRIPT_DIR/validate_project_governance.sh"
TMP_ROOT="${TMPDIR:-/tmp}/agent-governance-validator-tests.$$"

pass_count=0
fail_count=0

cleanup() {
  rm -rf "$TMP_ROOT"
}

trap cleanup EXIT HUP INT TERM

fail() {
  printf 'FAIL: %s\n' "$1"
  fail_count=$((fail_count + 1))
}

pass() {
  printf 'PASS: %s\n' "$1"
  pass_count=$((pass_count + 1))
}

write_file() {
  path="$1"
  shift
  mkdir -p "$(dirname "$path")"
  printf '%s\n' "$@" > "$path"
}

make_valid_project() {
  root="$1"
  mkdir -p "$root/.agent-governance" "$root/docs/sop" "$root/docs/iterations" "$root/docs/decisions"
  write_file "$root/.agent-governance/manifest.yaml" \
    "profile: product" \
    "status: conformant" \
    "entrypoints:" \
    "  agent_guide: AGENTS.md" \
    "capabilities:" \
    "  task_router: conformant" \
    "  evolution_feedback: conformant" \
    "  testing_policy: conformant" \
    "  git_workflow: conformant" \
    "  requirement_intake: conformant" \
    "  iteration_workflow: conformant" \
    "  change_control: conformant" \
    "  decision_records: conformant" \
    "  release_workflow: conformant"
  write_file "$root/AGENTS.md" \
    "# Agent Guide" \
    "Hard Constraints" \
    "Coding Behavior" \
    "Git Rules" \
    'Format: type(scope): description (#story-id) [model:<model-name>]' \
    "Scope = crate name, package, component, or workspace." \
    "[model:<model-name>] required when Agent authored or assisted the commit." \
    "Task Router" \
    "Session End Checklist" \
    "docs/sop/EVOLUTION-FEEDBACK.md" \
    "docs/sop/TESTING.md" \
    "docs/sop/GIT-WORKFLOW.md" \
    "docs/sop/REQUIREMENT-INTAKE.md" \
    "docs/sop/START-ITERATION.md" \
    "docs/sop/ITERATION-WORKFLOW.md" \
    "docs/sop/CHANGE-CONTROL.md" \
    "docs/decisions/README.md" \
    "docs/sop/RELEASE.md"
  write_file "$root/EVOLUTION.md" "# Evolution"
  write_file "$root/README.md" "# Fixture"
  write_file "$root/docs/README.md" "# Docs"
  write_file "$root/docs/decisions/README.md" "# Decisions"
  for file in EVOLUTION-FEEDBACK TESTING GIT-WORKFLOW REQUIREMENT-INTAKE START-ITERATION ITERATION-WORKFLOW CHANGE-CONTROL RELEASE DOC-CHECK; do
    write_file "$root/docs/sop/$file.md" "# $file"
  done
}

run_validator() {
  root="$1"
  output_file="$TMP_ROOT/output.txt"
  sh "$VALIDATOR" "$root" > "$output_file" 2>&1
  status=$?
}

expect_status() {
  name="$1"
  expected="$2"
  if [ "$status" -eq "$expected" ]; then
    pass "$name status"
  else
    fail "$name status: expected $expected, got $status"
    sed 's/^/  /' "$output_file"
  fi
}

expect_contains() {
  name="$1"
  pattern="$2"
  if grep -Fq "$pattern" "$output_file"; then
    pass "$name output"
  else
    fail "$name output: missing '$pattern'"
    sed 's/^/  /' "$output_file"
  fi
}

expect_not_contains() {
  name="$1"
  pattern="$2"
  if grep -Fq "$pattern" "$output_file"; then
    fail "$name output: unexpected '$pattern'"
    sed 's/^/  /' "$output_file"
  else
    pass "$name output"
  fi
}

mkdir -p "$TMP_ROOT"

case_root="$TMP_ROOT/valid"
make_valid_project "$case_root"
run_validator "$case_root"
expect_status "valid project" 0
expect_contains "valid project" "Governance validation passed: 0 warning(s)."

case_root="$TMP_ROOT/missing-evolution-feedback-route"
make_valid_project "$case_root"
write_file "$case_root/AGENTS.md" \
  "# Agent Guide" \
  "Hard Constraints" \
  "Coding Behavior" \
  "Git Rules" \
  'Format: type(scope): description (#story-id) [model:<model-name>]' \
  "Scope = crate name, package, component, or workspace." \
  "[model:<model-name>] required when Agent authored or assisted the commit." \
  "Task Router" \
  "Session End Checklist" \
  "docs/sop/TESTING.md" \
  "docs/sop/GIT-WORKFLOW.md" \
  "docs/sop/REQUIREMENT-INTAKE.md" \
  "docs/sop/START-ITERATION.md" \
  "docs/sop/ITERATION-WORKFLOW.md" \
  "docs/sop/CHANGE-CONTROL.md" \
  "docs/decisions/README.md" \
  "docs/sop/RELEASE.md"
run_validator "$case_root"
expect_status "missing evolution feedback route" 1
expect_contains "missing evolution feedback route" "ERROR: conformant evolution_feedback is not routed from AGENTS.md: docs/sop/EVOLUTION-FEEDBACK.md"

case_root="$TMP_ROOT/missing-agent-commit-format"
make_valid_project "$case_root"
write_file "$case_root/AGENTS.md" \
  "# Agent Guide" \
  "Hard Constraints" \
  "Coding Behavior" \
  "Git Rules" \
  "Task Router" \
  "Session End Checklist" \
  "docs/sop/TESTING.md" \
  "docs/sop/GIT-WORKFLOW.md" \
  "docs/sop/REQUIREMENT-INTAKE.md" \
  "docs/sop/START-ITERATION.md" \
  "docs/sop/ITERATION-WORKFLOW.md" \
  "docs/sop/CHANGE-CONTROL.md" \
  "docs/decisions/README.md" \
  "docs/sop/RELEASE.md"
run_validator "$case_root"
expect_status "missing agent commit format" 1
expect_contains "missing agent commit format" "ERROR: AGENTS.md Git Rules must include the Agent commit model tag format"

case_root="$TMP_ROOT/missing-manifest"
mkdir -p "$case_root"
run_validator "$case_root"
expect_status "missing manifest" 1
expect_contains "missing manifest" "ERROR: missing .agent-governance/manifest.yaml"

case_root="$TMP_ROOT/broken-link"
make_valid_project "$case_root"
write_file "$case_root/README.md" "# Fixture" "[Broken](missing.md)"
run_validator "$case_root"
expect_status "broken link" 1
expect_contains "broken link" "ERROR: broken Markdown link: README.md -> missing.md"

case_root="$TMP_ROOT/claim-no-evidence"
make_valid_project "$case_root"
write_file "$case_root/docs/iterations/iteration-001.md" "# Iteration" "Status: complete"
run_validator "$case_root"
expect_status "completion without evidence" 0
expect_contains "completion without evidence" "WARNING: iteration claims completion but records no validation evidence"

case_root="$TMP_ROOT/bad-board"
make_valid_project "$case_root"
write_file "$case_root/docs/BOARD.md" "# Project Board" "" "| Item | State | Link | Condition |" "|---|---|---|---|"
run_validator "$case_root"
expect_status "bad board" 0
expect_contains "bad board derived view" "WARNING: docs/BOARD.md exists but is not explicitly marked as a derived operating view"
expect_contains "bad board owner doc" "WARNING: docs/BOARD.md exists but does not include an Owner Doc column"
expect_contains "bad board gate" "WARNING: docs/BOARD.md exists but does not include a Gate column"

case_root="$TMP_ROOT/good-board"
make_valid_project "$case_root"
write_file "$case_root/docs/iterations/example.md" "# Example Iteration"
write_file "$case_root/docs/BOARD.md" \
  "# Project Board" \
  "" \
  "This board is a derived operating view. It is not the source of truth." \
  "" \
  "| Item | State | Owner Doc | Gate |" \
  "|---|---|---|---|" \
  "| Example | Now | [Iteration](iterations/example.md) | Exit when reviewed |"
run_validator "$case_root"
expect_status "good board" 0
expect_not_contains "good board" "WARNING:"

printf '%s\n' "Validator tests: $pass_count passed, $fail_count failed."
if [ "$fail_count" -gt 0 ]; then
  exit 1
fi
