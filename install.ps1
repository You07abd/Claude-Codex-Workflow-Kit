# Claude+Codex workflow installer
# Run this from inside the target project:
#   powershell -ExecutionPolicy Bypass -File path\to\install.ps1

param(
    [string]$Target = (Get-Location).Path,
    [string]$Source = $PSScriptRoot
)

Write-Host "Installing Claude+Codex workflow into: $Target"

# Copy tasks/ directory
$tasksSource = Join-Path $Source "tasks"
$tasksDest   = Join-Path $Target "tasks"
if (-not (Test-Path $tasksDest)) {
    Copy-Item -Recurse $tasksSource $tasksDest
    Write-Host "  Created tasks/"
} else {
    Copy-Item (Join-Path $tasksSource "_template.md") (Join-Path $tasksDest "_template.md") -Force
    Write-Host "  Updated tasks/_template.md"
}

# Merge or create CLAUDE.md
$sourceClaudeMd = Get-Content (Join-Path $Source "CLAUDE.md") -Raw
$destClaudeMd   = Join-Path $Target "CLAUDE.md"

if (Test-Path $destClaudeMd) {
    $existing = Get-Content $destClaudeMd -Raw
    if ($existing -notlike "*Claude + Codex Workflow*") {
        Add-Content $destClaudeMd "`n`n---`n`n$sourceClaudeMd"
        Write-Host "  Merged workflow into existing CLAUDE.md"
    } else {
        Write-Host "  CLAUDE.md already contains workflow — skipped"
    }
} else {
    Copy-Item (Join-Path $Source "CLAUDE.md") $destClaudeMd
    Write-Host "  Created CLAUDE.md"
}

Write-Host ""
Write-Host "Done. Open the project in Claude Code — the workflow is active."
Write-Host "Next: copy tasks/_template.md -> tasks/your-task.md and fill it in."
