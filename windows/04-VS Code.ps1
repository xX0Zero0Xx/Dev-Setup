$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$ScriptDir\lib\Common.ps1"
. "$ScriptDir\lib\VSCode.ps1"

Write-Info "Configurando extensiones de VS Code en Windows"
Install-VSCodeExtensions-Win