#!/bin/sh
set -eu

usage() {
  printf 'Usage: %s [release-tag]\n' "$0" >&2
}

case "${1:-}" in
  -h|--help)
    usage
    exit 0
    ;;
esac

release_tag="${1:-}"
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
repo_root=$(CDPATH= cd -- "$script_dir/.." && pwd)

cd "$repo_root"

error() {
  printf 'ERROR: %s\n' "$1" >&2
  exit 1
}

require_file() {
  [ -f "$1" ] || error "required file is missing: $1"
}

require_dir() {
  [ -d "$1" ] || error "required directory is missing: $1"
}

require_command() {
  command -v "$1" >/dev/null 2>&1 || error "required command is missing: $1"
}

skill_dir="skills/agent-project-governance"
skill_file="$skill_dir/SKILL.md"
release_workflow=".github/workflows/release.yml"
manifest_schema="$skill_dir/assets/manifest.schema.json"

require_dir "$skill_dir"
require_file "$skill_file"
require_file "$skill_dir/agents/openai.yaml"
require_file "$manifest_schema"
require_file "$release_workflow"
require_file "$skill_dir/scripts/validate_project_governance.sh"
require_file "$skill_dir/scripts/test_validate_project_governance.sh"
require_file "$skill_dir/scripts/validate_project_governance.ps1"
require_file "$skill_dir/scripts/test_validate_project_governance.ps1"

require_command ruby
require_command sh
require_command pwsh

ruby -e 'require "yaml"; text=File.read("skills/agent-project-governance/SKILL.md"); YAML.safe_load(text.split("---",3)[1]); puts "skill frontmatter ok"'
ruby -e 'require "yaml"; YAML.load_file("skills/agent-project-governance/agents/openai.yaml"); puts "openai yaml ok"'
ruby -e 'require "yaml"; YAML.load_file(".github/workflows/release.yml"); puts "workflow yaml ok"'
ruby -e 'require "json"; JSON.parse(File.read("skills/agent-project-governance/assets/manifest.schema.json")); puts "manifest schema json ok"'

sh -n "$skill_dir/scripts/validate_project_governance.sh"
sh -n "$skill_dir/scripts/test_validate_project_governance.sh"
sh "$skill_dir/scripts/test_validate_project_governance.sh"

pwsh -NoProfile -Command '& { $files = @("skills/agent-project-governance/scripts/validate_project_governance.ps1", "skills/agent-project-governance/scripts/test_validate_project_governance.ps1"); foreach ($file in $files) { $tokens = $null; $errors = $null; [System.Management.Automation.Language.Parser]::ParseFile($file, [ref]$tokens, [ref]$errors) | Out-Null; if ($errors.Count) { $errors | ForEach-Object { Write-Error $_.Message }; exit 1 } }; "powershell syntax ok" }'
pwsh -NoProfile -File "$skill_dir/scripts/test_validate_project_governance.ps1"

stale_patterns='INSTALL\.zh-CN|validate_project_governance\.py|git clone|git pull|latest release zip'
stale_matches=$(
  find . \
    -path './.git' -prune -o \
    -path './AGENTS.md' -prune -o \
    -path './scripts/validate_repository_harness.sh' -prune -o \
    -type f -print |
    xargs grep -En "$stale_patterns" 2>/dev/null || true
)
if [ -n "$stale_matches" ]; then
  printf '%s\n' "$stale_matches" >&2
  error "stale install or validator reference found"
fi
printf '%s\n' "stale reference check ok"

if [ -n "$release_tag" ]; then
  case "$release_tag" in
    v[0-9]*.[0-9]*.[0-9]*) ;;
    *) error "release tag must look like vMAJOR.MINOR.PATCH: $release_tag" ;;
  esac
  release_version=${release_tag#v}
  skill_version=$(
    awk '
      /^[[:space:]]*version:[[:space:]]*/ {
        sub(/^[[:space:]]*version:[[:space:]]*/, "")
        gsub(/^["'\'']|["'\'']$/, "")
        print
        exit
      }
    ' "$skill_file"
  )
  [ "$skill_version" = "$release_version" ] ||
    error "SKILL.md metadata.version ($skill_version) does not match $release_tag"

  release_notes="releases/$release_tag.md"
  require_file "$release_notes"
  for heading in "## Summary" "## Notable Changes" "## Upgrade Notes"; do
    grep -Fxq "$heading" "$release_notes" ||
      error "$release_notes is missing required heading: $heading"
  done
  printf '%s\n' "release artifact metadata ok"
fi

printf '%s\n' "repository harness validation passed"
