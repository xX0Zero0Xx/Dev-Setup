#!/usr/bin/env bash

set -e

# importar librerías
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/common.sh"
source "$SCRIPT_DIR/lib/vscode.sh"

# validar que no se ejecute como root
if [ "$EUID" -eq 0 ]; then
    log_warning "Este script no debe ejecutarse con sudo/root para que las extensiones se instalen en el perfil de tu usuario."
fi

echo "Configurando extensiones de VS Code"

install_vscode_extensions
configure_vscode_settings

log_success "¡Configuración de VS Code completada con éxito!"