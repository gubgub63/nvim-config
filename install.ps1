# Install this Neovim config on Windows.
# Usage (PowerShell): irm https://raw.githubusercontent.com/__USER__/nvim-config/main/install.ps1 | iex
$ErrorActionPreference = "Stop"

$Repo = "https://github.com/__USER__/nvim-config.git"
$Target = Join-Path $env:LOCALAPPDATA "nvim"

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        winget install --id Git.Git -e --accept-source-agreements --accept-package-agreements
        $env:Path = [Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [Environment]::GetEnvironmentVariable("Path", "User")
    } else {
        throw "git is required: https://git-scm.com"
    }
}

if (-not (Get-Command nvim -ErrorAction SilentlyContinue)) {
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Host "nvim not found, installing..."
        winget install --id Neovim.Neovim -e --accept-source-agreements --accept-package-agreements
    } else {
        throw "Install Neovim (>= 0.10) manually: https://neovim.io"
    }
}

if (Test-Path $Target) {
    $Backup = "$Target.bak." + (Get-Date -Format "yyyyMMddHHmmss")
    Write-Host "Existing config moved to $Backup"
    Move-Item $Target $Backup
}

git clone $Repo $Target
Write-Host "Done. Restart the terminal, then run: nvim (plugins install on first launch)"
