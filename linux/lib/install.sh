#!/usr/bin/env bash

install_apt_packages() {
    log_info "Actualizando índices de paquetes (apt update)"
    apt-get update -y > /dev/null 2>&1

    log_info "Instalando paquetes base del sistema"
    for pkg in "${SYSTEM_PACKAGES[@]}"; do
        if dpkg -l | grep -q "^ii  $pkg "; then
            log_success "El paquete '$pkg' ya está instalado"
        else
            log_info "Instalando $pkg..."
            apt-get install -y "$pkg" > /dev/null 2>&1
            log_success "Paquete '$pkg' instalado correctamente"
        fi
    done
}

setup_php_repository() {
    log_info "Verificando repositorio PPA Ondřej Surý para PHP"
    if ! grep -q "^deb.*ondrej/php" /etc/apt/sources.list /etc/apt/sources.list.d/* 2>/dev/null; then
        log_info "Añadiendo repositorio ppa:ondrej/php..."
        add-apt-repository -y ppa:ondrej/php > /dev/null 2>&1
        apt-get update -y > /dev/null 2>&1
        log_success "Repositorio de PHP añadido."
    else
        log_success "El repositorio ppa:ondrej/php ya está configurado"
    fi
}

install_php_packages() {
    log_info "Instalando PHP $PHP_REQUIRED_VERSION y sus extensiones"
    for pkg in "${PHP_PACKAGES[@]}"; do
        if dpkg -l | grep -q "^ii  $pkg "; then
            log_success "El paquete '$pkg' ya está instalado."
        else
            log_info "Instalando $pkg..."
            apt-get install -y "$pkg" > /dev/null 2>&1
            log_success "Paquete '$pkg' instalado correctamente."
        fi
    done
}