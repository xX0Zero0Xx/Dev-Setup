#!/usr/bin/env bash

set -e

# importar librerías
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/common.sh"

# validar permisos
check_sudo

echo "Actualizando el entorno de desarrollo"

log_info "Actualizando repositorios apt..."
run_logged "Actualización de listas apt" apt-get update -y

log_info "Actualizando paquetes del sistema..."
run_logged "Actualización de paquetes del sistema" apt-get upgrade -y
log_success "Paquetes del sistema actualizados."

if command -v composer > /dev/null 2>&1; then
    log_info "Actualizando Composer..."
    run_logged "Actualización de Composer" composer self-update || true
    log_success "Composer actualizado."
fi

log_success "¡Actualización del entorno completada con éxito!"