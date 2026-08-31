<#
.SYNOPSIS
    VS Code setup-script (Windows).
    Installerer anbefalte extensions og kopierer felles settings inn i VS Code User-profilen.

.PARAMETER CodeCmd
    Navn/sti på VS Code CLI (default: "code"). Bruk "code-insiders" for Insiders-build.

.PARAMETER DryRun
    Vis hva som ville blitt gjort uten å faktisk installere/kopiere noe.

.EXAMPLE
    .\scripts\setup.ps1
.EXAMPLE
    .\scripts\setup.ps1 -CodeCmd code-insiders -DryRun
#>

[CmdletBinding()]
param(
    [string]$CodeCmd = "code",
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot  = Split-Path -Parent $ScriptDir

function Write-Log($msg) {
    Write-Host "[setup] $msg" -ForegroundColor Cyan
}

function Invoke-Step {
    param([scriptblock]$Action, [string]$Description)
    if ($DryRun) {
        Write-Host "  (dry-run) $Description"
    } else {
        & $Action
    }
}

# --- 1. Installer VS Code selv, hvis det ikke allerede finnes ---
$codePath = Get-Command $CodeCmd -ErrorAction SilentlyContinue
if (-not $codePath) {
    Write-Log "Fant ikke '$CodeCmd' — installerer VS Code..."

    $winget = Get-Command winget -ErrorAction SilentlyContinue
    $choco  = Get-Command choco -ErrorAction SilentlyContinue

    if ($winget) {
        Write-Log "Installerer VS Code via winget"
        Invoke-Step -Description "winget install -e --id Microsoft.VisualStudioCode" -Action {
            winget install -e --id Microsoft.VisualStudioCode --accept-package-agreements --accept-source-agreements
        }
    } elseif ($choco) {
        Write-Log "Installerer VS Code via Chocolatey"
        Invoke-Step -Description "choco install vscode -y" -Action {
            choco install vscode -y
        }
    } else {
        Write-Error "Fant verken winget eller choco. Installer VS Code manuelt: https://code.visualstudio.com/download"
        exit 1
    }

    if (-not $DryRun) {
        # Oppdater PATH i denne prosessen slik at 'code' kan bli funnet rett etter installasjon
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
        $codePath = Get-Command $CodeCmd -ErrorAction SilentlyContinue
        if (-not $codePath) {
            Write-Error "Installasjonen fullførte, men fant fortsatt ikke '$CodeCmd' i PATH. Åpne et nytt PowerShell-vindu og prøv igjen."
            exit 1
        }
    }
}

if ($codePath) {
    Write-Log "Bruker VS Code CLI: $($codePath.Source)"
} else {
    Write-Log "Bruker VS Code CLI: $CodeCmd (dry-run, ikke installert enda)"
}

# --- 2. Finn User-mappe for settings ---
$UserDir = Join-Path $env:APPDATA "Code\User"

# --- 3. Installer anbefalte extensions ---
$ExtFile = Join-Path $RepoRoot ".vscode\extensions.json"
if (Test-Path $ExtFile) {
    Write-Log "Leser anbefalte extensions fra $ExtFile"
    $raw = Get-Content $ExtFile -Raw
    # Fjern // linje-kommentarer (JSONC) før parsing
    $clean = ($raw -split "`n" | ForEach-Object { $_ -replace '//.*$', '' }) -join "`n"
    $json = $clean | ConvertFrom-Json
    $extensions = $json.recommendations | Sort-Object -Unique

    foreach ($ext in $extensions) {
        Write-Log "Installerer extension: $ext"
        Invoke-Step -Description "code --install-extension $ext --force" -Action {
            & $CodeCmd --install-extension $ext --force
        }
    }
} else {
    Write-Log "Fant ikke $ExtFile — hopper over extension-installasjon."
}

# --- 4. Kopier/merge settings.json inn i User-profilen ---
$SrcSettings  = Join-Path $RepoRoot ".vscode\settings.json"
$DestSettings = Join-Path $UserDir "settings.json"

if (Test-Path $SrcSettings) {
    if (-not (Test-Path $UserDir)) {
        Invoke-Step -Description "New-Item -ItemType Directory $UserDir" -Action {
            New-Item -ItemType Directory -Path $UserDir -Force | Out-Null
        }
    }

    if (Test-Path $DestSettings) {
        $backup = "$DestSettings.bak.$(Get-Date -Format 'yyyyMMddHHmmss')"
        Write-Log "Eksisterende settings.json funnet — tar backup til $backup"
        Invoke-Step -Description "Copy-Item $DestSettings $backup" -Action {
            Copy-Item $DestSettings $backup
        }
    }

    Write-Log "Kopierer settings.json til $DestSettings"
    Invoke-Step -Description "Copy-Item $SrcSettings $DestSettings" -Action {
        Copy-Item $SrcSettings $DestSettings -Force
    }
} else {
    Write-Log "Fant ikke $SrcSettings — hopper over settings-kopiering."
}

Write-Log "Ferdig! Åpne hovedarbeidsmappen din i VS Code og velg ønsket profil/tema."
