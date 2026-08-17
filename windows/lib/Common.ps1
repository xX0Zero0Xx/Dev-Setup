$global:ScriptLibDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$global:ProjectRootDir = Split-Path -Parent (Split-Path -Parent (Resolve-Path $global:ScriptLibDir))
if (-not (Test-Path "$global:ProjectRootDir\logs")) {
    $global:ProjectRootDir = Split-Path -Parent (Resolve-Path $global:ScriptLibDir)
}
$global:LogDir = Join-Path $global:ProjectRootDir "logs"
if (-not (Test-Path $global:LogDir)) {
    New-Item -ItemType Directory -Path $global:LogDir -Force | Out-Null
}
$global:LogFile = Join-Path $global:LogDir ("setup_" + (Get-Date -Format "yyyy-MM-dd") + ".log")

function Log-ToFile ($level, $msg) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "[$timestamp] [$level] $msg" | Out-File -FilePath $global:LogFile -Append -Encoding UTF8 -ErrorAction SilentlyContinue
}

function Write-Info ($message) {
    Write-Host "[INFO] $message" -ForegroundColor Cyan
    Log-ToFile "INFO" $message
}

function Write-Success ($message) {
    Write-Host "[OK] $message" -ForegroundColor Green
    Log-ToFile "OK" $message
}

function Write-Warning ($message) {
    Write-Host "[WARN] $message" -ForegroundColor Yellow
    Log-ToFile "WARN" $message
}

function Write-Error-Msg ($message) {
    Write-Host "[ERROR] $message" -ForegroundColor Red
    Log-ToFile "ERROR" $message
}

function Test-Admin {
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Assert-Admin {
    if (-not (Test-Admin)) {
        Write-Error-Msg "Este script requiere ejecutarse como Administrador en PowerShell"
        exit 1
    }
}

function Load-Config {
    param([string]$BasePath)
    if (-not $BasePath) {
        $curr = Split-Path -Parent $MyInvocation.MyCommand.Path
        $BasePath = Split-Path -Parent (Split-Path -Parent (Resolve-Path $curr))
        if (-not (Test-Path "$BasePath\config\versiones.conf")) {
            $BasePath = Split-Path -Parent (Resolve-Path $curr)
        }
    }
    
    $versionFile = Join-Path $BasePath "config\versiones.conf"
    if (Test-Path $versionFile) {
        Get-Content $versionFile | ForEach-Object {
            $line = $_.Trim()
            if ($line -and -not $line.StartsWith("#") -and $line -match '^([A-Za-z0-9_]+)="?([^"]*)"?$') {
                $varName = $matches[1]
                $varVal = $matches[2]
                Set-Variable -Name $varName -Value $varVal -Scope Global
            }
        }
        Write-Info "Configuración de versiones cargada correctamente"
    } else {
        Write-Error-Msg "No se encontró el archivo $versionFile"
        exit 1
    }
}