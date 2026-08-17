#!/usr/bin/env bash

RECOMMENDED_EXTENSIONS=(
    # Desarrollo PHP & Laravel
    "bmewburn.vscode-intelephense-client"          # Inteligencia de código para PHP
    "onecentlin.laravel-blade"                    # Soporte de sintaxis para plantillas Blade
    "onecentlin.laravel5-snippets"                # Snippets para Laravel
    "amiralizadeh9480.laravel-extra-intellisense" # Autocompletado avanzado para Laravel

    # Productividad & Formato
    "esbenp.prettier-vscode"                       # Formateador de código
    "eamodio.gitlens"                             # Herramientas avanzadas de Git
    "formulahendry.code-runner"                   # Ejecución rápida de fragmentos de código
    "christian-kohler.path-intellisense"          # Autocompletado inteligente de rutas de archivos
    "cweijan.vscode-office"                       # Visor de archivos Office (Excel, Word, etc.)

    # Apariencia & UI
    "webdevnerdstuff.neon-bunny"                  # Tema visual Neon Bunny
    "oderwat.indent-rainbow"                      # Coloreo de niveles de indentación
    "johnpapa.vscode-peacock"                     # Distinción de color por espacio de trabajo
    "emmanuelbeziat.vscode-great-icons"           # Paquete de iconos temáticos
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

configure_vscode_settings() {
    local target_dir="$HOME/.config/Code/User"
    local base_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
    local src_settings="$base_dir/config/vscode-settings.json"

    if [ ! -f "$src_settings" ]; then
        return 0
    fi

    log_info "Verificando configuración de VS Code..."
    mkdir -p "$target_dir"

    if [ ! -f "$target_dir/settings.json" ]; then
        cp "$src_settings" "$target_dir/settings.json"
        log_success "Configuración recomendada aplicada en $target_dir/settings.json"
    else
        log_info "El archivo $target_dir/settings.json ya existe. Las opciones recomendadas están en config/vscode-settings.json"
    fi
}