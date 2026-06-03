param()

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Validator = Join-Path $ScriptDir "validate_project_governance.ps1"
$TmpRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("agent-governance-validator-tests-" + [guid]::NewGuid())
$PassCount = 0
$FailCount = 0
$Status = 0
$Output = ""

function Write-FixtureFile {
    param([string]$Path, [string[]]$Lines)
    $Parent = Split-Path -Parent $Path
    if ($Parent) {
        New-Item -ItemType Directory -Force -Path $Parent | Out-Null
    }
    Set-Content -LiteralPath $Path -Value $Lines -Encoding UTF8
}

function Add-Pass {
    param([string]$Name)
    Write-Output "PASS: $Name"
    $script:PassCount++
}

function Add-Fail {
    param([string]$Name)
    Write-Output "FAIL: $Name"
    $script:FailCount++
    if ($script:Output) {
        $script:Output -split "`r?`n" | ForEach-Object { Write-Output "  $_" }
    }
}

function New-ValidProject {
    param([string]$Root)
    New-Item -ItemType Directory -Force -Path (Join-Path $Root ".agent-governance") | Out-Null
    New-Item -ItemType Directory -Force -Path (Join-Path $Root "docs/sop") | Out-Null
    New-Item -ItemType Directory -Force -Path (Join-Path $Root "docs/iterations") | Out-Null
    New-Item -ItemType Directory -Force -Path (Join-Path $Root "docs/decisions") | Out-Null
    Write-FixtureFile (Join-Path $Root ".agent-governance/manifest.yaml") @(
        "profile: product",
        "status: conformant",
        "entrypoints:",
        "  agent_guide: AGENTS.md",
        "capabilities:",
        "  task_router: conformant",
        "  evolution_feedback: conformant",
        "  testing_policy: conformant",
        "  git_workflow: conformant",
        "  requirement_intake: conformant",
        "  iteration_workflow: conformant",
        "  change_control: conformant",
        "  decision_records: conformant",
        "  release_workflow: conformant"
    )
    Write-FixtureFile (Join-Path $Root "AGENTS.md") @(
        "# Agent Guide",
        "Hard Constraints",
        "Coding Behavior",
        "Git Rules",
        "Format: type(scope): description (#story-id) [model:<model-name>]",
        "Scope = crate name, package, component, or workspace.",
        "[model:<model-name>] required when Agent authored or assisted the commit.",
        "Task Router",
        "Session End Checklist",
        "docs/sop/TESTING.md",
        "docs/sop/GIT-WORKFLOW.md",
        "docs/sop/REQUIREMENT-INTAKE.md",
        "docs/sop/START-ITERATION.md",
        "docs/sop/ITERATION-WORKFLOW.md",
        "docs/sop/CHANGE-CONTROL.md",
        "docs/decisions/README.md",
        "docs/sop/RELEASE.md"
    )
    Write-FixtureFile (Join-Path $Root "EVOLUTION.md") @("# Evolution")
    Write-FixtureFile (Join-Path $Root "README.md") @("# Fixture")
    Write-FixtureFile (Join-Path $Root "docs/README.md") @("# Docs")
    Write-FixtureFile (Join-Path $Root "docs/decisions/README.md") @("# Decisions")
    foreach ($File in @("TESTING", "GIT-WORKFLOW", "REQUIREMENT-INTAKE", "START-ITERATION", "ITERATION-WORKFLOW", "CHANGE-CONTROL", "RELEASE", "DOC-CHECK")) {
        Write-FixtureFile (Join-Path $Root "docs/sop/$File.md") @("# $File")
    }
}

function Invoke-ValidatorCase {
    param([string]$Root)
    $script:Output = (& pwsh -NoProfile -File $Validator $Root 2>&1) -join "`n"
    $script:Status = $LASTEXITCODE
}

function Expect-Status {
    param([string]$Name, [int]$Expected)
    if ($script:Status -eq $Expected) {
        Add-Pass "$Name status"
    }
    else {
        Add-Fail "$Name status: expected $Expected, got $script:Status"
    }
}

function Expect-Contains {
    param([string]$Name, [string]$Pattern)
    if ($script:Output.Contains($Pattern)) {
        Add-Pass "$Name output"
    }
    else {
        Add-Fail "$Name output: missing '$Pattern'"
    }
}

try {
    New-Item -ItemType Directory -Force -Path $TmpRoot | Out-Null

    $Root = Join-Path $TmpRoot "valid"
    New-ValidProject $Root
    Invoke-ValidatorCase $Root
    Expect-Status "valid project" 0
    Expect-Contains "valid project" "Governance validation passed: 0 warning(s)."

    $Root = Join-Path $TmpRoot "missing-agent-commit-format"
    New-ValidProject $Root
    Write-FixtureFile (Join-Path $Root "AGENTS.md") @(
        "# Agent Guide",
        "Hard Constraints",
        "Coding Behavior",
        "Git Rules",
        "Task Router",
        "Session End Checklist",
        "docs/sop/TESTING.md",
        "docs/sop/GIT-WORKFLOW.md",
        "docs/sop/REQUIREMENT-INTAKE.md",
        "docs/sop/START-ITERATION.md",
        "docs/sop/ITERATION-WORKFLOW.md",
        "docs/sop/CHANGE-CONTROL.md",
        "docs/decisions/README.md",
        "docs/sop/RELEASE.md"
    )
    Invoke-ValidatorCase $Root
    Expect-Status "missing agent commit format" 1
    Expect-Contains "missing agent commit format" "ERROR: AGENTS.md Git Rules must include the Agent commit model tag format"

    $Root = Join-Path $TmpRoot "missing-manifest"
    New-Item -ItemType Directory -Force -Path $Root | Out-Null
    Invoke-ValidatorCase $Root
    Expect-Status "missing manifest" 1
    Expect-Contains "missing manifest" "ERROR: missing .agent-governance/manifest.yaml"

    $Root = Join-Path $TmpRoot "broken-link"
    New-ValidProject $Root
    Write-FixtureFile (Join-Path $Root "README.md") @("# Fixture", "[Broken](missing.md)")
    Invoke-ValidatorCase $Root
    Expect-Status "broken link" 1
    Expect-Contains "broken link" "ERROR: broken Markdown link: README.md -> missing.md"

    $Root = Join-Path $TmpRoot "claim-no-evidence"
    New-ValidProject $Root
    Write-FixtureFile (Join-Path $Root "docs/iterations/iteration-001.md") @("# Iteration", "Status: complete")
    Invoke-ValidatorCase $Root
    Expect-Status "completion without evidence" 0
    Expect-Contains "completion without evidence" "WARNING: iteration claims completion but records no validation evidence"
}
finally {
    Remove-Item -LiteralPath $TmpRoot -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Output "PowerShell validator tests: $PassCount passed, $FailCount failed."
if ($FailCount -gt 0) {
    exit 1
}
