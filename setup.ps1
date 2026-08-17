<#
.SYNOPSIS
    Script maestro interactivo de automatización Dev-Setup para Windows.
.DESCRIPTION
    Permite aprovisionar, verificar y configurar el entorno de desarrollo completo.
.PARAMETER All
    Ejecuta el flujo completo (Sistema + Verificación + VS Code).
.PARAMETER System
    Instala dependencias del sistema, PHP, Node.js y Composer.
.PARAMETER Check
    Verifica las herramientas y versiones instaladas.
.PARAMETER VSCode
    Instala extensiones y aplica settings recomendados en VS Code.
.PARAMETER Update
    Actualiza los paquetes instalados vía Chocolatey.
#>

[CmdletBinding()]
param(
    [switch]$All,
    [switch]$System,
    [switch]$Check,
    [switch]$VSCode,
    [switch]$Update,
    [switch]$Help
)

$ScriptRoot = $PSScriptRoot
. "$ScriptRoot\windows\lib\Common.ps1"

function Show-Banner {
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Host "       🚀 Dev-Setup - Gestor de Entornos          " -ForegroundColor Cyan
    Write-Host "==================================================" -ForegroundColor Cyan
}

function Show-Help-Menu {
    Show-Banner
    Write-Host "Uso: .\setup.ps1 [-All] [-System] [-Check] [-VSCode] [-Update] [-Help]`n"
    Write-Host "Parámetros:"
    Write-Host "  -All       Ejecutar aprovisionamiento completo (Sistema + Verificación + VS Code)"
    Write-Host "  -System    Instalar herramientas base (Git, PHP, Node.js, Composer)"
    Write-Host "  -Check     Verificar estado de herramientas y versiones instaladas"
    Write-Host "  -VSCode    Instalar extensiones y configuración de VS Code"
    Write-Host "  -Update    Actualizar paquetes de Chocolatey"
    Write-Host "  -Help      Mostrar esta ayuda"
    Write-Host "`nSi no se pasa ningún parámetro, se abrirá el menú interactivo."
}

function Run-System-Setup {
    & "$ScriptRoot\windows\01-sistema.ps1"
}

function Run-Check-Setup {
    & "$ScriptRoot\windows\02-verificar.ps1"
}

function Run-VSCode-Setup {
    & "$ScriptRoot\windows\04-vscode.ps1"
}

function Run-Update-Setup {
    & "$ScriptRoot\windows\03-actualizar.ps1"
}

function Run-All-Setup {
    Show-Banner
    Write-Info "Iniciando aprovisionamiento completo del entorno Windows..."
    Write-Host ""
    Run-System-Setup
    Write-Host ""
    Run-Check-Setup
    Write-Host ""
    Run-VSCode-Setup
    Write-Host ""
    Write-Success "🎉 ¡Entorno de desarrollo en Windows configurado con éxito!"
}

function Show-Interactive-Menu {
    while ($true) {
        Clear-Host
        Show-Banner
        Write-Host "Selecciona una opción:"
        Write-Host "  1) 🌟 Instalación completa (Sistema + Verificación + VS Code)"
        Write-Host "  2) 📦 Instalar dependencias del sistema (Git, PHP, Node, Composer)"
        Write-Host "  3) 🔍 Verificar estado de herramientas y versiones"
        Write-Host "  4) 🎨 Configurar VS Code (Extensiones y Settings)"
        Write-Host "  5) 🔄 Actualizar paquetes (Chocolatey)"
        Write-Host "  6) ❌ Salir"
        Write-Host ""

        $choice = Read-Host "Ingresa tu opción [1-6]"
        Write-Host ""

        switch ($choice) {
            "1" { Run-All-Setup; break }
            "2" { Run-System-Setup; break }
            "3" { Run-Check-Setup; break }
            "4" { Run-VSCode-Setup; break }
            "5" { Run-Update-Setup; break }
            "6" { Write-Info "Operación cancelada."; exit 0 }
            Default {
                Write-Error-Msg "Opción inválida. Intenta nuevamente."
                Start-Sleep -Seconds 1
            }
        }
    }
}

if ($Help) {
    Show-Help-Menu
    exit 0
} elseif ($All) {
    Run-All-Setup
} elseif ($System) {
    Run-System-Setup
} elseif ($Check) {
    Run-Check-Setup
} elseif ($VSCode) {
    Run-VSCode-Setup
} elseif ($Update) {
    Run-Update-Setup
} else {
    Show-Interactive-Menu
}
