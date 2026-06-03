# Install / Update Guide (for AI Agents)

> **Audience.** This document is written for AI agents and LLMs
> guiding a user through installing or updating the
> `agent-project-governance` skill. Humans may also read it, but the
> structure is a guided dialog plus copy-paste shell commands that an
> agent can run on the user's behalf.

The skill is a single directory named `agent-project-governance/`
that you place under the agent's skill directory. The agent's
loader discovers it at startup from the `name:` field in
`SKILL.md`. No package manager, no config-file edits, no network
calls beyond the install itself.

## 1. Decide where to install

Ask the user two questions, in order. If the user already knows
the answer, skip that question — do not ask both when one
suffices.

### Question 1: Which agent?

Present the user with these options. If their answer is not on
the list, fall back to **Other** — the directory is the same for
every tool that follows the [Agent Skills open standard](https://agentskills.io).

| If the user says… | Project-level directory | Global directory |
| --- | --- | --- |
| OpenCode | `.opencode/skills/` | `~/.config/opencode/skills/` |
| Claude Code | `.claude/skills/` | `~/.claude/skills/` |
| Cursor | `.agents/skills/` | `~/.agents/skills/` |
| GitHub Copilot | `.agents/skills/` | `~/.agents/skills/` |
| Codex | `.agents/skills/` | `~/.agents/skills/` |
| Amp | `.agents/skills/` | `~/.agents/skills/` |
| Other / "I don't know" | `.agents/skills/` | `~/.agents/skills/` |

### Question 2: Project or global?

| If the user says… | Use this directory |
| --- | --- |
| "Just this project" / "this repo" / "current project" | The **project-level** directory from Q1 |
| "All my projects" / "everywhere" / "globally" / "for my account" | The **global** directory from Q1 |
| "I don't know" | Recommend **project-level** — it never affects other repos, and a global install can always be added later |

Set shell variables for the rest of this guide:

```bash
SKILLS_DIR="<directory you chose>"
VERSION=v1.0.0
# Examples:
#   SKILLS_DIR=".opencode/skills"
#   SKILLS_DIR="$HOME/.config/opencode/skills"
#   VERSION=v1.0.0
```

## 2. Pick a version

Default to the latest published release. If the user names a
specific version, use that instead.

Use an exact release tag from
https://github.com/wjhuang88/agent-project-governance/releases,
for example `v1.0.0`. Avoid scraping the release API in restricted
environments; asking the user for the desired tag is more reliable
than introducing a local scripting dependency.

## 3. Install (fresh install)

Use this when the skill is not yet installed, or when you want to
fully replace a previous install. For in-place updates, see
section 4.

On Unix-like environments, prefer the zstd archive when `zstd` is
available; otherwise use `tar.gz`. On Windows, use the zip archive
in the PowerShell section.

```bash
# Ensure the parent directory exists.
mkdir -p "$SKILLS_DIR"
rm -rf "$SKILLS_DIR/agent-project-governance"

if command -v zstd >/dev/null 2>&1; then
  ARCHIVE=/tmp/agent-project-governance.tar.zst
  URL="https://github.com/wjhuang88/agent-project-governance/releases/download/${VERSION}/agent-project-governance-${VERSION}.tar.zst"
  curl -L --fail -o "$ARCHIVE" "$URL"
  zstd -dc "$ARCHIVE" | tar -xf - -C "$SKILLS_DIR"
else
  ARCHIVE=/tmp/agent-project-governance.tar.gz
  URL="https://github.com/wjhuang88/agent-project-governance/releases/download/${VERSION}/agent-project-governance-${VERSION}.tar.gz"
  curl -L --fail -o "$ARCHIVE" "$URL"
  tar -xzf "$ARCHIVE" -C "$SKILLS_DIR"
fi

rm "$ARCHIVE"
```

## 4. Update an existing install

A fresh archive always fully replaces the directory; it does **not**
merge with an existing install. Always wipe before extracting:

```bash
rm -rf "$SKILLS_DIR/agent-project-governance"
# Then re-run the install command from section 3.
```

If you skip the `rm -rf`, extracted files may merge with the old
install, and any files removed in the new version remain on disk.

## 5. Verify the installation

After section 3 or 4, every line below must print `OK:` — if
any line prints nothing, the install is broken; re-run from
section 3 (or 4 for an update).

```bash
test -f "$SKILLS_DIR/agent-project-governance/SKILL.md"          && echo OK: SKILL.md
test -d "$SKILLS_DIR/agent-project-governance/references"        && echo OK: references/
test -d "$SKILLS_DIR/agent-project-governance/scripts"           && echo OK: scripts/
test -d "$SKILLS_DIR/agent-project-governance/assets"            && echo OK: assets/
test -d "$SKILLS_DIR/agent-project-governance/agents"            && echo OK: agents/
grep -q '^name: agent-project-governance' \
  "$SKILLS_DIR/agent-project-governance/SKILL.md"                && echo OK: frontmatter-name
```

## 6. Use the skill

The agent's skill loader picks up the skill at startup from
`name: agent-project-governance`. No further configuration is
required.

After install, ask the user to reload the agent (or restart the
session) and trigger the skill with natural language, e.g.:

```text
Use $agent-project-governance to audit the current project's Agent
governance state. Analyse only; do not modify files.
```

For more example prompts, see
[README.md § Quick Start → Use the skill](README.md#use-the-skill).

## Windows PowerShell install

Use this when the user is on Windows and does not have a Unix-like
shell. Windows uses the release zip because PowerShell supports it
without extra archive tools. Set `$SkillsDir` from section 1 and
`$Version` from section 2:

```powershell
$SkillsDir = ".agents\skills"
$Version = "v1.0.0"
$ZipPath = Join-Path $env:TEMP "agent-project-governance.zip"
$Url = "https://github.com/wjhuang88/agent-project-governance/releases/download/$Version/agent-project-governance-$Version.zip"

New-Item -ItemType Directory -Force -Path $SkillsDir | Out-Null
Remove-Item -Recurse -Force (Join-Path $SkillsDir "agent-project-governance") -ErrorAction SilentlyContinue
Invoke-WebRequest -Uri $Url -OutFile $ZipPath
Expand-Archive -Path $ZipPath -DestinationPath $SkillsDir -Force
Remove-Item $ZipPath
```

Verify:

```powershell
Test-Path (Join-Path $SkillsDir "agent-project-governance\SKILL.md")
Test-Path (Join-Path $SkillsDir "agent-project-governance\references")
Test-Path (Join-Path $SkillsDir "agent-project-governance\scripts")
Test-Path (Join-Path $SkillsDir "agent-project-governance\assets")
Test-Path (Join-Path $SkillsDir "agent-project-governance\agents")
Select-String -Path (Join-Path $SkillsDir "agent-project-governance\SKILL.md") -Pattern "^name: agent-project-governance"
```

## Troubleshooting

| Symptom | Likely cause | Fix |
| --- | --- | --- |
| `curl: (22) The requested URL returned error: 404` / `Invoke-WebRequest` returns 404 | `${VERSION}` is not a real release tag, or that release does not include the selected archive | Re-run §2; copy the exact `vX.Y.Z` from the [Releases](https://github.com/wjhuang88/agent-project-governance/releases) page |
| Old files remain after update | Old install was not removed before extracting | Re-run §4 (`rm -rf` first), then §3 |
| Agent does not load the skill after install | Loader started before install, or wrong directory | Restart the agent's session; double-check `SKILLS_DIR` matches the agent's expected path |
| `Permission denied` writing under `~/.config/opencode/skills` | Path resolved to a system location instead of the user's home | Check `echo "$SKILLS_DIR"`; fall back to the project-level directory |
| User is on Windows (no shell, no unzip) | Unix shell commands are unavailable | Use the PowerShell install section above |
| Multiple installs detected (project + global both exist) | User installed at both scopes; agent may load the wrong one | Pick one and remove the other with `rm -rf <unwanted>/agent-project-governance`; project-level wins for that repo, global wins everywhere else |
| Old version still loaded after update | `rm -rf` was skipped before extracting the new archive | Re-run §4 properly, then restart the agent's session |
