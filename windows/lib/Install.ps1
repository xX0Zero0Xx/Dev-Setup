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
    Write-Info "Instalando herramientas de desarrollo (Git, PHP, Composer, Node)"
    choco install git php composer nodejs-lts -y --no-progress
    Write-Success "Herramientas de desarrollo instaladas"
}