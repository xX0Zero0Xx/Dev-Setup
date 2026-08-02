function Write-Info ($message) {
    Write-Host "[INFO] $message" -ForegroundColor Cyan
}

function Write-Success ($message) {
    Write-Host "[OK] $message" -ForegroundColor Green
}

function Write-Warning ($message) {
    Write-Host "[WARN] $message" -ForegroundColor Yellow
}

function Write-Error-Msg ($message) {
    Write-Host "[ERROR] $message" -ForegroundColor Red
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