#!/usr/bin/env bash

# colores para la terminal
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# funciones de formateo
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# verificar permisos root/sudo
check_sudo() {
    if [ "$EUID" -ne 0 ]; then
        log_error "Este script requiere permisos de superusuario (sudo)"
        exit 1
    fi
}

# cargar archivos de configuración
load_config() {
    local base_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
    
    if [ -f "$base_dir/config/versiones.conf" ]; then
        source "$base_dir/config/versiones.conf"
    else
        log_error "No se encontró el archivo config/versiones.conf"
        exit 1
    fi

    if [ -f "$base_dir/config/paquetes.conf" ]; then
        source "$base_dir/config/paquetes.conf"
    else
        log_error "No se encontró el archivo config/paquetes.conf"
        exit 1
    fi
}