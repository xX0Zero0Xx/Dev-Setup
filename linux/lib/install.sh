#!/usr/bin/env bash

install_apt_packages() {
    log_info "Actualizando índices de paquetes (apt update)..."
    run_logged "Actualización de índices apt" apt-get update -y

    log_info "Instalando paquetes base del sistema..."
    for pkg in "${SYSTEM_PACKAGES[@]}"; do
        if dpkg -l | grep -q "^ii  $pkg "; then
            log_success "El paquete '$pkg' ya está instalado"
        else
            log_info "Instalando $pkg..."
            run_logged "Instalación de paquete $pkg" apt-get install -y "$pkg"
            log_success "Paquete '$pkg' instalado correctamente"
        fi
    done
}

setup_php_repository() {
    log_info "Verificando repositorio PPA Ondřej Surý para PHP..."
    if ! grep -q "^deb.*ondrej/php" /etc/apt/sources.list /etc/apt/sources.list.d/* 2>/dev/null; then
        log_info "Añadiendo repositorio ppa:ondrej/php..."
        run_logged "Añadir repositorio ppa:ondrej/php" add-apt-repository -y ppa:ondrej/php
        run_logged "Actualización tras añadir PPA PHP" apt-get update -y
        log_success "Repositorio de PHP añadido."
    else
        log_success "El repositorio ppa:ondrej/php ya está configurado"
    fi
}

install_php_packages() {
    log_info "Instalando PHP $PHP_REQUIRED_VERSION y sus extensiones..."
    for pkg in "${PHP_PACKAGES[@]}"; do
        if dpkg -l | grep -q "^ii  $pkg "; then
            log_success "El paquete '$pkg' ya está instalado."
        else
            log_info "Instalando $pkg..."
            run_logged "Instalación de paquete PHP $pkg" apt-get install -y "$pkg"
            log_success "Paquete '$pkg' instalado correctamente."
        fi
    done
}

setup_nodejs_repository() {
    local node_major="${NODE_REQUIRED_VERSION:-20}"
    log_info "Verificando repositorio NodeSource para Node.js ${node_major}.x..."
    if ! grep -q "nodesource" /etc/apt/sources.list /etc/apt/sources.list.d/* 2>/dev/null; then
        log_info "Configurando repositorio NodeSource (${node_major}.x)..."
        local setup_script="/tmp/nodesource_setup_${node_major}.sh"
        curl -fsSL "https://deb.nodesource.com/setup_${node_major}.x" -o "$setup_script"
        run_logged "Ejecutar script NodeSource $node_major.x" bash "$setup_script"
        rm -f "$setup_script"
        log_success "Repositorio NodeSource configurado."
    else
        log_success "El repositorio NodeSource ya está configurado"
    fi
}

install_nodejs_packages() {
    if command -v node > /dev/null 2>&1 && command -v npm > /dev/null 2>&1; then
        log_success "Node.js y npm ya están instalados ($(node -v), npm $(npm -v))"
    else
        log_info "Instalando Node.js y npm..."
        run_logged "Instalación de nodejs" apt-get install -y nodejs
        log_success "Node.js y npm instalados correctamente."
    fi
}

install_composer() {
    if command -v composer > /dev/null 2>&1; then
        log_success "Composer ya está instalado ($(composer --version 2>/dev/null | head -n 1 | awk '{print $3}'))"
    else
        log_info "Instalando Composer..."
        local temp_installer="/tmp/composer-setup.php"
        local expected_sig
        expected_sig="$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");' 2>/dev/null || true)"

        php -r "copy('https://getcomposer.org/installer', '$temp_installer');"
        local actual_sig
        actual_sig="$(php -r "echo hash_file('sha384', '$temp_installer');" 2>/dev/null || true)"

        if [ -n "$expected_sig" ] && [ "$expected_sig" != "$actual_sig" ]; then
            log_error "Firma de verificación de Composer inválida."
            rm -f "$temp_installer"
            return 1
        fi

        run_logged "Instalación de Composer binario" php "$temp_installer" --quiet --install-dir=/usr/local/bin --filename=composer
        rm -f "$temp_installer"
        chmod +x /usr/local/bin/composer 2>/dev/null || true
        log_success "Composer instalado correctamente en /usr/local/bin/composer."
    fi
}