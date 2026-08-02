#!/usr/bin/env bash

RECOMMENDED_EXTENSIONS=(
    "bmewburn.vscode-intelephense-client"  # Inteligencia de código para PHP
    "onecentlin.laravel-blade"            # Soporte de sintaxis para plantillas Blade
    "onecentlin.laravel5-snippets"        # Snippets para Laravel
    "amiralizadeh9480.laravel-extra-intellisense" # Autocompletado avanzado
    "esbenp.prettier-vscode"               # Formateador de código
    "eamodio.gitlens"                     # Herramientas avanzadas de Git
)

install_vscode_extensions() {
    if command -v code > /dev/null 2>&1; then
        log_info "Instalando extensiones recomendadas de VS Code para Laravel"
        for ext in "${RECOMMENDED_EXTENSIONS[@]}"; do
            log_info "Instalando extensión: $ext..."
            code --install-extension "$ext" --force > /dev/null 2>&1
            log_success "Extensión '$ext' instalada correctamente."
        done
    else
        log_warning "El comando 'code' de VS Code no está disponible en la terminal"
        log_info "Asegúrate de abrir VS Code y agregar 'code' al PATH de tu sistema"
    fi
}