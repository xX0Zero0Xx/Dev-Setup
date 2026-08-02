# Requires -RunAsAdministrator
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$ScriptDir\lib\Common.ps1"

Assert-Admin
Write-Info "Actualizando paquetes instalados vía Chocolatey"
choco upgrade all -y --no-progress
Write-Success "Actualización completada"