$Extensions = @(
    # Desarrollo PHP & Laravel
    "bmewburn.vscode-intelephense-client",
    "onecentlin.laravel-blade",
    "onecentlin.laravel5-snippets",
    "amiralizadeh9480.laravel-extra-intellisense",

    # Productividad & Formato
    "esbenp.prettier-vscode",
    "eamodio.gitlens",
    "formulahendry.code-runner",
    "christian-kohler.path-intellisense",
    "cweijan.vscode-office",

    # Apariencia & UI
    "webdevnerdstuff.neon-bunny",
    "oderwat.indent-rainbow",
    "johnpapa.vscode-peacock",
    "emmanuelbeziat.vscode-great-icons"
)

function Install-VSCodeExtensions-Win {
    if (Get-Command code -ErrorAction SilentlyContinue) {
        Write-Info "Instalando extensiones de VS Code"
        foreach ($ext in $Extensions) {
            code --install-extension $ext --force | Out-Null
            Write-Success "Extensión '$ext' instalada"
        }
    } else {
        Write-Warning "El comando 'code' no está en el PATH de Windows."
    }
}

function Set-VSCodeSettings-Win {
    $targetDir = Join-Path $env:APPDATA "Code\User"
    $scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
    $baseDir = Split-Path -Parent (Split-Path -Parent (Resolve-Path $scriptDir))
    if (-not (Test-Path "$baseDir\config\vscode-settings.json")) {
        $baseDir = Split-Path -Parent (Resolve-Path $scriptDir)
    }

    $srcSettings = Join-Path $baseDir "config\vscode-settings.json"
    if (Test-Path $srcSettings) {
        Write-Info "Verificando configuración de VS Code en Windows..."
        if (-not (Test-Path $targetDir)) {
            New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
        }

        $targetFile = Join-Path $targetDir "settings.json"
        if (-not (Test-Path $targetFile)) {
            Copy-Item $srcSettings $targetFile -Force
            Write-Success "Configuración recomendada aplicada en $targetFile"
        } else {
            Write-Info "El archivo $targetFile ya existe. Las opciones recomendadas están en config\vscode-settings.json"
        }
    }
}