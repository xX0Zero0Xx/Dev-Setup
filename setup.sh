#!/usr/bin/env bash

set -e

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$PROJECT_ROOT/linux/lib/common.sh"

show_banner() {
    echo -e "${BLUE}"
    echo "=================================================="
    echo "       🚀 Dev-Setup - Gestor de Entornos          "
    echo "=================================================="
    echo -e "${NC}"
}

show_help() {
    show_banner
    echo "Uso: ./setup.sh [OPCIÓN]"
    echo ""
    echo "Opciones:"
    echo "  -a, --all        Ejecutar aprovisionamiento completo (Sistema + Verificación + VS Code)"
    echo "  -s, --system     Instalar dependencias del sistema, PHP, Node.js y Composer"
    echo "  -c, --check      Verificar estado y versiones de las herramientas instaladas"
    echo "  -v, --vscode     Instalar extensiones y configuración recomendada de VS Code"
    echo "  -u, --update     Actualizar paquetes del sistema y Composer"
    echo "  -h, --help       Mostrar esta ayuda"
    echo ""
    echo "Si no se pasa ninguna opción, se abrirá el menú interactivo."
}

run_system() {
    log_info "Paso 1: Instalación de herramientas base..."
    sudo bash "$PROJECT_ROOT/linux/01-sistema.sh"
}

run_check() {
    log_info "Paso 2: Verificación del entorno..."
    bash "$PROJECT_ROOT/linux/02-verificar.sh"
}

run_vscode() {
    log_info "Paso 3: Configuración de VS Code..."
    bash "$PROJECT_ROOT/linux/04-vscode.sh"
}

run_update() {
    log_info "Actualizando paquetes..."
    sudo bash "$PROJECT_ROOT/linux/03-actualizar.sh"
}

run_all() {
    show_banner
    log_info "Iniciando aprovisionamiento completo del entorno de desarrollo..."
    echo ""
    run_system
    echo ""
    run_check
    echo ""
    run_vscode
    echo ""
    log_success "🎉 ¡Entorno de desarrollo completamente configurado y listo para programar!"
}

interactive_menu() {
    while true; do
        show_banner
        echo "Selecciona una opción:"
        echo "  1) 🌟 Instalación completa (Sistema + Verificación + VS Code)"
        echo "  2) 📦 Instalar dependencias del sistema, PHP, Node y Composer"
        echo "  3) 🔍 Verificar estado de herramientas y versiones"
        echo "  4) 🎨 Configurar VS Code (Extensiones y Settings)"
        echo "  5) 🔄 Actualizar paquetes del sistema"
        echo "  6) ❌ Salir"
        echo ""
        read -rp "Ingresa tu opción [1-6]: " opt
        echo ""

        case "$opt" in
            1)
                run_all
                break
                ;;
            2)
                run_system
                break
                ;;
            3)
                run_check
                break
                ;;
            4)
                run_vscode
                break
                ;;
            5)
                run_update
                break
                ;;
            6)
                log_info "Operación cancelada."
                exit 0
                ;;
            *)
                log_error "Opción no válida. Intenta nuevamente."
                sleep 1
                ;;
        esac
    done
}

# Procesar argumentos de línea de comandos
case "$1" in
    -a|--all)
        run_all
        ;;
    -s|--system)
        run_system
        ;;
    -c|--check)
        run_check
        ;;
    -v|--vscode)
        run_vscode
        ;;
    -u|--update)
        run_update
        ;;
    -h|--help)
        show_help
        ;;
    "")
        interactive_menu
        ;;
    *)
        log_error "Opción desconocida: $1"
        echo ""
        show_help
        exit 1
        ;;
esac
