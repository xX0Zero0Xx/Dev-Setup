# Requires -RunAsAdministrator
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$ScriptDir\lib\Common.ps1"
. "$ScriptDir\lib\Install.ps1"

Assert-Admin
Write-Info "Iniciando preparación del entorno Windows"
Install-Chocolatey
Install-DevTools
Write-Success "Instalación completada con éxito"