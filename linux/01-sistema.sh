#!/usr/bin/env bash

set -e

# importar librerías
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/common.sh"
source "$SCRIPT_DIR/lib/install.sh"

# validar permisos
check_sudo

# cargar configuraciones de versiones y paquetes
load_config

echo "🚀 Iniciando preparación del entorno (Linux Mint)"

# instalación de paquetes base del sistema
install_apt_packages

# configuración del PPA e instalación de PHP
setup_php_repository
install_php_packages

# configuración del repositorio e instalación de Node.js / npm
setup_nodejs_repository
install_nodejs_packages

# instalación de Composer
install_composer

log_success "¡Instalación base del sistema completada!"