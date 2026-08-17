# Requires -RunAsAdministrator
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$ScriptDir\lib\Common.ps1"
. "$ScriptDir\lib\Install.ps1"

Assert-Admin
Load-Config -BasePath (Split-Path -Parent $ScriptDir)

Write-Info "Iniciando preparación del entorno Windows"
Install-Chocolatey
Install-DevTools
Write-Success "Instalación completada con éxito"