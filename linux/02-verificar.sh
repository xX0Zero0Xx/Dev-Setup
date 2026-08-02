#!/usr/bin/env bash

set -e

# importar librerías
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/common.sh"
source "$SCRIPT_DIR/lib/verify.sh"

# cargar configuraciones
load_config

echo "Verificando estado del entorno de desarrollo"

verify_git
echo "---"
verify_php
echo "---"
verify_composer
echo "---"
verify_node

log_info "Verificación finalizada."
