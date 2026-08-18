#!/bin/bash

# Detener el script si ocurre algún error no controlado
set -e

# Visuales (Colores)
VERDE='\033[0;32m'
ROJO='\033[0;31m'
AMARILLO='\033[1;33m'
RESET='\033[0m'

# 1. Comprobar dependencias previas
for cmd in composer php; do
    if ! command -v $cmd &> /dev/null; then
        echo -e "${ROJO}Error: $cmd no está instalado o no se encuentra en el PATH.${RESET}"
        exit 1
    fi
done

# 2. Solicitar el nombre del proyecto
read -p "Ingresa el nombre del proyecto Laravel: " NOMBRE_PROYECTO

# Validar que no esté vacío
if [ -z "$NOMBRE_PROYECTO" ]; then
    echo -e "${ROJO}Error: El nombre del proyecto no puede estar vacío.${RESET}"
    exit 1
fi

# Validar que el directorio no exista previamente
if [ -d "$NOMBRE_PROYECTO" ]; then
    echo -e "${ROJO}Error: El directorio '$NOMBRE_PROYECTO' ya existe.${RESET}"
    exit 1
fi

# 3. Crear el proyecto Laravel
echo -e "\n${AMARILLO}1/4. Creando proyecto Laravel...${RESET}"
composer create-project laravel/laravel "$NOMBRE_PROYECTO"

cd "$NOMBRE_PROYECTO" || exit

# 4. Instalar Laravel Breeze
echo -e "\n${AMARILLO}2/4. Instalando paquete Laravel Breeze...${RESET}"
composer require laravel/breeze --dev

# Seleccionar la pila para Breeze de forma interactiva
echo -e "\n${AMARILLO}Selecciona el stack para Breeze:${RESET}"
echo "1) blade (Default)"
echo "2) react"
echo "3) vue"
echo "4) api"
read -p "Opción [1-4]: " STACK_OPCION

case $STACK_OPCION in
    2) STACK="react" ;;
    3) STACK="vue" ;;
    4) STACK="api" ;;
    *) STACK="blade" ;;
esac

echo -e "\n${AMARILLO}3/4. Configurando Breeze ($STACK)...${RESET}"
php artisan breeze:install $STACK --no-interaction

# 5. Publicar archivos de configuración de Sanctum
echo -e "\n${AMARILLO}4/4. Publicando proveedores de Sanctum...${RESET}"
php artisan vendor:publish --provider="Laravel\Sanctum\SanctumServiceProvider" --no-interaction

echo -e "\n${VERDE}¡Proyecto '$NOMBRE_PROYECTO' inicializado y listo para trabajar!${RESET}"
