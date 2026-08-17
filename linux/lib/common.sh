#!/usr/bin/env bash

# colores para la terminal
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# configuración de logs
SCRIPT_LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_PROJECT_DIR="$(cd "$SCRIPT_LIB_DIR/../.." && pwd)"
LOG_DIR="$BASE_PROJECT_DIR/logs"
mkdir -p "$LOG_DIR" 2>/dev/null || true
LOG_FILE="$LOG_DIR/setup_$(date +'%Y-%m-%d').log"

# funciones de formateo y logging
log_to_file() {
    local level="$1"
    local msg="$2"
    if [ -d "$LOG_DIR" ]; then
        echo "[$(date +'%Y-%m-%d %H:%M:%S')] [$level] $msg" >> "$LOG_FILE" 2>/dev/null || true
    fi
}

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
    log_to_file "INFO" "$1"
}

log_success() {
    echo -e "${GREEN}[OK]${NC} $1"
    log_to_file "OK" "$1"
}

log_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
    log_to_file "WARN" "$1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
    log_to_file "ERROR" "$1"
}

# ejecutar comandos registrando salida detallada en el archivo de log
run_logged() {
    local cmd_desc="$1"
    shift
    log_to_file "CMD_START" "$cmd_desc -> $*"
    if "$@" >> "$LOG_FILE" 2>&1; then
        log_to_file "CMD_SUCCESS" "$cmd_desc"
        return 0
    else
        local exit_code=$?
        log_to_file "CMD_FAILED" "$cmd_desc (Exit Code: $exit_code)"
        log_error "Error al ejecutar: $cmd_desc (ver detalles en: $LOG_FILE)"
        return $exit_code
    fi
}

# comparación semántica de versiones (retorna 0 si $1 >= $2)
version_ge() {
    local v1="$1"
    local v2="$2"
    [ "$v1" = "$v2" ] && return 0
    local lowest
    lowest=$(printf '%s\n%s' "$v1" "$v2" | sort -V | head -n 1)
    [ "$lowest" = "$v2" ]
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