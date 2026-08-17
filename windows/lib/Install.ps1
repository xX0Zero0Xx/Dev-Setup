function Install-Chocolatey {
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Info "Instalando Chocolatey Package Manager..."
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        Write-Success "Chocolatey instalado correctamente"
    } else {
        Write-Success "Chocolatey ya está instalado"
    }
}

function Install-DevTools {
    Write-Info "Instalando herramientas de desarrollo según versiones configuradas..."

    # Git
    Write-Info "Instalando Git..."
    choco install git -y --no-progress

    # PHP
    if ($global:PHP_REQUIRED_VERSION) {
        Write-Info "Instalando PHP $global:PHP_REQUIRED_VERSION..."
        choco install php --version $global:PHP_REQUIRED_VERSION -y --no-progress
    } else {
        Write-Info "Instalando PHP..."
        choco install php -y --no-progress
    }

    # Composer
    Write-Info "Instalando Composer..."
    choco install composer -y --no-progress

    # Node.js
    if ($global:NODE_REQUIRED_VERSION) {
        Write-Info "Instalando Node.js $global:NODE_REQUIRED_VERSION..."
        choco install nodejs --version $global:NODE_REQUIRED_VERSION -y --no-progress
    } else {
        Write-Info "Instalando Node.js LTS..."
        choco install nodejs-lts -y --no-progress
    }

    # Configurar extensiones de PHP en php.ini
    Enable-PhpExtensions-Win

    Write-Success "Herramientas de desarrollo instaladas correctamente"
}

function Enable-PhpExtensions-Win {
    Write-Info "Configurando extensiones de PHP en php.ini para Windows..."
    $phpCmd = Get-Command php -ErrorAction SilentlyContinue
    if (-not $phpCmd) {
        return
    }

    $phpDir = Split-Path -Parent $phpCmd.Source
    $phpIni = Join-Path $phpDir "php.ini"
    $phpIniDev = Join-Path $phpDir "php.ini-development"
    $phpIniProd = Join-Path $phpDir "php.ini-production"

    if (-not (Test-Path $phpIni)) {
        if (Test-Path $phpIniDev) {
            Copy-Item $phpIniDev $phpIni
            Write-Info "Archivo php.ini creado a partir de php.ini-development"
        } elseif (Test-Path $phpIniProd) {
            Copy-Item $phpIniProd $phpIni
            Write-Info "Archivo php.ini creado a partir de php.ini-production"
        }
    }

    if (Test-Path $phpIni) {
        $extensionsToEnable = @("curl", "fileinfo", "gd", "intl", "mbstring", "openssl", "pdo_mysql", "pdo_sqlite", "sqlite3")
        $content = Get-Content $phpIni
        $content = $content -replace '^;extension_dir = "ext"', 'extension_dir = "ext"'

        foreach ($ext in $extensionsToEnable) {
            $content = $content -replace "^;extension=$ext\b", "extension=$ext"
        }

        $content | Set-Content $phpIni
        Write-Success "Extensiones clave de PHP habilitadas en $phpIni"
    }
}