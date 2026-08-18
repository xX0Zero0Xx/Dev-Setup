# Detener el script si ocurre un error
$ErrorActionPreference = "Stop"

# 1. Comprobar dependencias previas
foreach ($cmd in @("composer", "php")) {
    if (-not (Get-Command $cmd -ErrorAction SilentlyContinue)) {
        Write-Host "Error: $cmd no está instalado o no se encuentra en el PATH." -ForegroundColor Red
        exit 1
    }
}

# 2. Solicitar el nombre del proyecto
$NOMBRE_PROYECTO = Read-Host "Ingresa el nombre del proyecto Laravel"

# Validar que no esté vacío
if ([string]::IsNullOrWhiteSpace($NOMBRE_PROYECTO)) {
    Write-Host "Error: El nombre del proyecto no puede estar vacío." -ForegroundColor Red
    exit 1
}

# Validar que el directorio no exista previamente
if (Test-Path $NOMBRE_PROYECTO) {
    Write-Host "Error: El directorio '$NOMBRE_PROYECTO' ya existe." -ForegroundColor Red
    exit 1
}

# 3. Crear el proyecto Laravel
Write-Host "`n1/4. Creando proyecto Laravel..." -ForegroundColor Yellow
composer create-project laravel/laravel $NOMBRE_PROYECTO

Set-Location $NOMBRE_PROYECTO

# 4. Instalar Laravel Breeze
Write-Host "`n2/4. Instalando paquete Laravel Breeze..." -ForegroundColor Yellow
composer require laravel/breeze --dev

# Seleccionar la pila para Breeze
Write-Host "`nSelecciona el stack para Breeze:" -ForegroundColor Yellow
Write-Host "1) blade (Default)"
Write-Host "2) react"
Write-Host "3) vue"
Write-Host "4) api"
$STACK_OPCION = Read-Host "Opción [1-4]"

switch ($STACK_OPCION) {
    "2" { $STACK = "react" }
    "3" { $STACK = "vue" }
    "4" { $STACK = "api" }
    Default { $STACK = "blade" }
}

Write-Host "`n3/4. Configurando Breeze ($STACK)..." -ForegroundColor Yellow
php artisan breeze:install $STACK --no-interaction

# 5. Publicar archivos de configuración de Sanctum
Write-Host "`n4/4. Publicando proveedores de Sanctum..." -ForegroundColor Yellow
php artisan vendor:publish --provider="Laravel\Sanctum\SanctumServiceProvider" --no-interaction

Write-Host "`n¡Proyecto '$NOMBRE_PROYECTO' inicializado y listo para trabajar!" -ForegroundColor Green