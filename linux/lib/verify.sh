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
        local raw_ver
        raw_ver=$(php -v 2>/dev/null | head -n 1 | awk '{print $2}')
        local clean_ver
        clean_ver=$(echo "$raw_ver" | grep -oE '[0-9]+(\.[0-9]+)*' | head -n 1)

        if [ -n "$PHP_REQUIRED_VERSION" ] && version_ge "$clean_ver" "$PHP_REQUIRED_VERSION"; then
            log_info "PHP $clean_ver (Cumple requisito >= $PHP_REQUIRED_VERSION)"
        else
            log_warning "PHP $clean_ver es inferior a la versión requerida ($PHP_REQUIRED_VERSION)"
        fi
    fi
}

verify_composer() {
    if check_command "composer" "Composer"; then
        local raw_ver
        raw_ver=$(composer --version 2>/dev/null | awk '{print $3}' | head -n 1)
        local clean_ver
        clean_ver=$(echo "$raw_ver" | grep -oE '[0-9]+(\.[0-9]+)*' | head -n 1)

        if [ -n "$COMPOSER_REQUIRED_VERSION" ] && version_ge "$clean_ver" "$COMPOSER_REQUIRED_VERSION"; then
            log_info "Composer $clean_ver (Cumple requisito >= $COMPOSER_REQUIRED_VERSION)"
        else
            log_info "Composer $clean_ver instalado"
        fi
    else
        log_error "Composer no está instalado. Ejecuta ./linux/01-sistema.sh para instalarlo."
    fi
}

verify_git() {
    if check_command "git" "Git"; then
        local raw_ver
        raw_ver=$(git --version 2>/dev/null | awk '{print $3}')
        local clean_ver
        clean_ver=$(echo "$raw_ver" | grep -oE '[0-9]+(\.[0-9]+)*' | head -n 1)

        if [ -n "$GIT_REQUIRED_VERSION" ] && version_ge "$clean_ver" "$GIT_REQUIRED_VERSION"; then
            log_info "Git $clean_ver (Cumple requisito >= $GIT_REQUIRED_VERSION)"
        else
            log_warning "Git $clean_ver es inferior a la versión requerida ($GIT_REQUIRED_VERSION)"
        fi
    fi
}

verify_node() {
    if check_command "node" "Node.js"; then
        local raw_ver
        raw_ver=$(node -v 2>/dev/null)
        local clean_ver
        clean_ver=$(echo "$raw_ver" | grep -oE '[0-9]+(\.[0-9]+)*' | head -n 1)

        if [ -n "$NODE_REQUIRED_VERSION" ] && version_ge "$clean_ver" "$NODE_REQUIRED_VERSION"; then
            log_info "Node.js $raw_ver (Cumple requisito >= v$NODE_REQUIRED_VERSION)"
        else
            log_warning "Node.js $raw_ver es inferior a la versión requerida (v$NODE_REQUIRED_VERSION)"
        fi
    else
        log_error "Node.js no está instalado. Ejecuta ./linux/01-sistema.sh para instalarlo."
    fi

    if check_command "npm" "NPM"; then
        local raw_ver
        raw_ver=$(npm -v 2>/dev/null)
        local clean_ver
        clean_ver=$(echo "$raw_ver" | grep -oE '[0-9]+(\.[0-9]+)*' | head -n 1)

        if [ -n "$NPM_REQUIRED_VERSION" ] && version_ge "$clean_ver" "$NPM_REQUIRED_VERSION"; then
            log_info "NPM $clean_ver (Cumple requisito >= $NPM_REQUIRED_VERSION)"
        else
            log_warning "NPM $clean_ver es inferior a la versión requerida ($NPM_REQUIRED_VERSION)"
        fi
    else
        log_error "NPM no está instalado. Ejecuta ./linux/01-sistema.sh para instalarlo."
    fi
}