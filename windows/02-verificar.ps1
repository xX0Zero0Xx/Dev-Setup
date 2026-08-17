$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$ScriptDir\lib\Common.ps1"
. "$ScriptDir\lib\Verify.ps1"

Load-Config -BasePath (Split-Path -Parent $ScriptDir)
Write-Info "Verificando entorno en Windows"
Verify-WindowsEnvironment