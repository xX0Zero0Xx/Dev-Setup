#!/usr/bin/env bash

check_command() {
    local cmd="$1"
    local name="$2"

    if command -v "$cmd" > /dev/null 2>&1; then
        log_success "$name está instalado"
        return 0
    else
        log_error "$name NO está instalado"
        return 1
    fi
}

verify_php() {
    if check_command "php" "PHP"; then
        local current_version=$(php -v | head -n 1 | awk '{print $2}')
        log_info "Versión de PHP instalada: $current_version (Requerida: $PHP_REQUIRED_VERSION.x)"
    fi
}

verify_composer() {
    if check_command "composer" "Composer"; then
        local current_version=$(composer --version | awk '{print $3}')
        log_info "Versión de Composer instalada: $current_version"
    else
        log_warning " Composer no está instalado. Puedes instalarlo con los siguientes comandos:"
        echo "   curl -sS https://getcomposer.org/installer | php"
        echo "   sudo mv composer.phar /usr/local/bin/composer"
    fi
}

verify_git() {
    if check_command "git" "Git"; then
        local current_version=$(git --version | awk '{print $3}')
        log_info "Versión de Git instalada: $current_version"
    fi
}

verify_node() {
    if check_command "node" "Node.js"; then
        local current_version=$(node -v)
        log_info "Versión de Node.js instalada: $current_version"
    else
        log_warning " Node.js no está instalado"
    fi

    if check_command "npm" "NPM"; then
        local current_version=$(npm -v)
        log_info "Versión de NPM instalada: $current_version"
    else
        log_warning " NPM no está instalado"
    fi
}