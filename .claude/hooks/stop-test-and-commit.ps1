Add-Content -Path ".claude/hooks/hook.log" -Value "[HOOK] Stop test and commit started"

$ErrorActionPreference = "Stop"
$git = "C:\Program Files\Git\cmd\git.exe"
$logPath = ".claude/hooks/hook.log"

function Write-HookLog {
    param([string]$Message)
    Add-Content -Path $logPath -Value $Message
}

function Fail-Hook {
    param([string]$Reason)
    Write-HookLog ("[HOOK] Stop failed: " + $Reason)
    exit 1
}

if (-not (Test-Path $git)) {
    Fail-Hook "git executable not found"
}

$statusLines = & $git status --short

if (-not $statusLines) {
    Write-HookLog "[HOOK] Stop commit skipped: no changes"
    exit 0
}

$changedFiles = @()
foreach ($line in $statusLines) {
    if ($line.Length -lt 4) {
        continue
    }

    $path = $line.Substring(3).Trim()
    if ($path.StartsWith('"') -and $path.EndsWith('"')) {
        $path = $path.Substring(1, $path.Length - 2)
    }

    if ($path -match '\.(html|py)$') {
        $changedFiles += $path
    }
}

if ($changedFiles.Count -eq 0) {
    Write-HookLog "[HOOK] Stop commit skipped: no html or py changes"
    exit 0
}

$uniqueFiles = $changedFiles | Select-Object -Unique

foreach ($file in $uniqueFiles) {
    if ($file -match '\.html$') {
        if (-not (Test-Path "index.html")) {
            Fail-Hook "index.html not found"
        }

        $content = Get-Content "index.html" -Raw -Encoding UTF8
        if ($content -notmatch '<html' -or $content -notmatch '<head' -or $content -notmatch '<body') {
            Fail-Hook "index.html missing required html/head/body tags"
        }
        continue
    }

    if ($file -match '\.py$') {
        & python -m py_compile $file
        if ($LASTEXITCODE -ne 0) {
            Fail-Hook ("python compile failed: " + $file)
        }
    }
}

& $git add .
if ($LASTEXITCODE -ne 0) {
    Fail-Hook "git add failed"
}

& $git commit -m "auto: Claude Code generated update"
if ($LASTEXITCODE -ne 0) {
    Fail-Hook "git commit failed"
}

$commitHash = & $git rev-parse --short HEAD
if ($LASTEXITCODE -ne 0) {
    Fail-Hook "failed to read commit hash"
}

Write-HookLog ("[HOOK] Stop commit hash: " + $commitHash)
