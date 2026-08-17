#!/usr/bin/env bash

set -e

# importar librerías
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/common.sh"
source "$SCRIPT_DIR/lib/vscode.sh"

# validar permisos
check_sudo

echo "Configurando extensiones de VS Code"

install_vscode_extensions

log_success "¡Configuración de VS Code completada con éxito!"