# 🚀 Dev Setup

> **Herramienta de aprovisionamiento y automatización de entornos de desarrollo multiplataforma (Linux & Windows).**  
> Diseñada para preparar de forma rápida, consistente y reproducible un entorno moderno optimizado para **PHP, Laravel, Node.js, Composer y Visual Studio Code**.

---

## 📋 ¿Qué hace este proyecto?

**Dev Setup** automatiza todas las tareas repetitivas de configuración en equipos nuevos o formateados:

- 📦 **Instalación de dependencias base del sistema** (`git`, `curl`, `wget`, certificados, etc.).
- 🐘 **Aprovisionamiento completo de PHP (8.3)** y todas sus extensiones necesarias para Laravel (`mbstring`, `mysql`, `xml`, `curl`, `zip`, `intl`, `sqlite3`, etc.).
- 📦 **Instalación y configuración de Composer (2.7)**.
- 🟢 **Instalación de Node.js (20 LTS) y npm (10)**.
- 🎨 **Instalación y configuración automática de 13 extensiones recomendadas para VS Code**.
- ⚙️ **Configuración predeterminada de VS Code** (`settings.json`) con formateo automático al guardar y soporte para Blade.
- 🔍 **Validación semántica de versiones instaladas**.
- 📝 **Registro centralizado de logs** en la carpeta `logs/`.

---

## 💻 Requisitos Previos

- **Linux**: Distribuciones basadas en Debian/Ubuntu (Ubuntu 20.04+, Linux Mint 21+, Debian 11+) con soporte para `apt`.
- **Windows**: Windows 10 / Windows 11 (PowerShell 5.1 o PowerShell 7).
- Conexión a Internet activa.

---

## 🛠️ Herramientas y Versiones Estandarizadas

El proyecto utiliza una configuración centralizada en [`config/versiones.conf`](config/versiones.conf):

| Herramienta | Versión Requerida | Gestor en Linux | Gestor en Windows |
| :--- | :--- | :--- | :--- |
| **PHP** | `8.3.x` | PPA `ondrej/php` | Chocolatey |
| **Composer** | `2.7.x` | Instalador oficial | Chocolatey |
| **Node.js** | `20.x (LTS)` | NodeSource Repository | Chocolatey |
| **npm** | `10.x` | NodeSource / npm | Chocolatey |
| **Git** | `≥ 2.40` | `apt-get` | Chocolatey |

---

## 🧩 Extensiones de VS Code Incluidas

El instalador configura automáticamente las extensiones del espacio de trabajo:

### 🐘 Desarrollo PHP & Laravel
- **`bmewburn.vscode-intelephense-client`**: Autocompletado inteligente, tipado estático y análisis de código PHP.
- **`onecentlin.laravel-blade`**: Resaltado de sintaxis y formateo para plantillas Blade (`.blade.php`).
- **`onecentlin.laravel5-snippets`**: Atajos y fragmentos rápidos para rutas, controladores, modelos y vistas.
- **`amiralizadeh9480.laravel-extra-intellisense`**: Autocompletado contextual de rutas, configs, vistas y traducciones.

### ⚡ Productividad y Utilidades
- **`esbenp.prettier-vscode`**: Formateador consistente de código.
- **`eamodio.gitlens`**: Visualización avanzada de Git, autoría de líneas (*git blame*) e historial.
- **`formulahendry.code-runner`**: Ejecución rápida de fragmentos y scripts desde el editor.
- **`christian-kohler.path-intellisense`**: Autocompletado inteligente de rutas de archivos en `require`/`import`.
- **`cweijan.vscode-office`**: Visualizador integrado para archivos Office (`.xlsx`, `.docx`), Markdown y PDF.

### 🎨 Apariencia y Legibilidad
- **`webdevnerdstuff.neon-bunny`**: Tema visual personalizado Neon Bunny.
- **`oderwat.indent-rainbow`**: Coloreo de niveles de indentación para estructurar bloques de código.
- **`johnpapa.vscode-peacock`**: Cambio de color del marco de VS Code para diferenciar proyectos.
- **`emmanuelbeziat.vscode-great-icons`**: Pack moderno de iconos para archivos y carpetas.

---

## ⚡ Instalación Rápida

### 1. Clonar el repositorio

```bash
git clone https://github.com/xX0Zero0Xx/Dev-Setup.git
cd Dev-Setup
```

### 2. Ejecutar mediante el Asistente Interactivo (Recomendado)

#### 🐧 En Linux
```bash
chmod +x setup.sh
./setup.sh
```
> O ejecuta todo el flujo directamente sin confirmaciones:
> ```bash
> ./setup.sh --all
> ```

#### 🪟 En Windows (PowerShell como Administrador)
```powershell
.\setup.ps1
```
> O ejecuta todo el flujo directamente:
> ```powershell
> .\setup.ps1 -All
> ```

---

### 3. O ejecutar scripts paso a paso

#### 🐧 Linux:
```bash
sudo ./linux/01-sistema.sh   # 1. Instala paquetes base, repositorios, PHP, Node y Composer
./linux/02-verificar.sh      # 2. Verifica el estado y versiones de las herramientas
sudo ./linux/03-actualizar.sh # 3. Actualiza paquetes del sistema (Opcional)
./linux/04-vscode.sh         # 4. Instala extensiones y settings de VS Code (Sin sudo)
```

#### 🪟 Windows (PowerShell como Administrador):
```powershell
.\windows\01-sistema.ps1     # 1. Instala Chocolatey, herramientas y habilita extensiones PHP
.\windows\02-verificar.ps1   # 2. Verifica herramientas y versiones instaladas
.\windows\03-actualizar.ps1  # 3. Actualiza paquetes de Chocolatey (Opcional)
.\windows\04-vscode.ps1      # 4. Instala extensiones y settings de VS Code
```

---

## ❓ Preguntas Frecuentes y Solución de Errores Comunes

### 1. 🪟 Windows: `'php'`, `'composer'` o `'node'` no se reconocen como un comando ejecutable
* **Causa**: La terminal de PowerShell o CMD actual se abrió antes de la instalación y no ha recargado la variable de entorno `PATH`.
* **Solución**:
  1. **Reiniciar la terminal**: Cierra PowerShell o VS Code y vuelve a abrirlo.
  2. **Refrescar variables en la sesión actual**: Ejecuta en PowerShell:
     ```powershell
     $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
     ```
  3. **Verificación manual del PATH**: Si persiste, asegúrate de que `C:\tools\php83` y `C:\ProgramData\ComposerSetup\bin` estén en las Variables de Entorno del Sistema:
     - Presiona `Win + R` ➔ escribe `sysdm.cpl` ➔ pestaña *Opciones avanzadas* ➔ *Variables de entorno*.
     - En *Variables del sistema*, edita la variable `Path` y añade la ruta de PHP (ej. `C:\tools\php83`).

---

### 2. 🪟 Windows: Error de extensiones de PHP faltantes (`curl`, `mbstring`, `pdo_mysql`, `openssl`)
* **Causa**: En Windows, PHP instala las extensiones pero vienen comentadas por defecto en `php.ini`.
* **Solución**:
  - El script `setup.ps1` las habilita automáticamente.
  - Para hacerlo de forma manual, abre `C:\tools\php83\php.ini` (o tu ruta de instalación de PHP) con un editor de texto y asegúrate de que las siguientes líneas **no** tengan un punto y coma (`;`) al inicio:
    ```ini
    extension_dir = "ext"
    extension=curl
    extension=fileinfo
    extension=gd
    extension=intl
    extension=mbstring
    extension=openssl
    extension=pdo_mysql
    extension=pdo_sqlite
    extension=sqlite3
    ```

---

### 3. 🪟 Windows: La ejecución de scripts está deshabilitada (`ExecutionPolicy`)
* **Error**: `setup.ps1 no se puede cargar porque la ejecución de scripts está deshabilitada en este sistema`.
* **Solución**: Abre PowerShell como Administrador y habilita la ejecución de scripts locales con:
  ```powershell
  Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
  ```

---

### 4. 🐧 Linux: Error al instalar extensiones de VS Code con `sudo`
* **Error**: `Cannot be run as root` o las extensiones se instalan en `/root/.vscode/extensions` y no aparecen en tu usuario.
* **Solución**: No ejecutes `./linux/04-vscode.sh` ni la parte de VS Code con `sudo`. Las extensiones del editor pertenecen al perfil del usuario actual.

---

### 5. 💻 El comando `code` no se reconoce en la terminal
* **Causa**: Visual Studio Code no está en la variable `PATH` de tu sistema.
* **Solución**:
  - Abre VS Code.
  - Presiona `Ctrl + Shift + P` (o `Cmd + Shift + P` en macOS).
  - Escribe `Shell Command: Install 'code' command in PATH` y presiona Enter.
  - Reinicia la terminal.

---

### 6. 📝 ¿Dónde se guardan los registros de instalación?
Todos los pasos de instalación y actualización registran su salida detallada en archivos fechados dentro del directorio `logs/`:
```bash
logs/setup_YYYY-MM-DD.log
```
Si algún comando de `apt` o `choco` falla, puedes consultar dicho archivo para ver la traza de error completa.

---

## 📂 Estructura del Proyecto

```
Dev-Setup/
├── .github/workflows/ci.yml # Integración continua (GitHub Actions)
├── config/
│   ├── paquetes.conf        # Listas de paquetes del sistema y PHP
│   ├── versiones.conf       # Versiones requeridas estandarizadas
│   └── vscode-settings.json # Plantilla de configuración para VS Code
├── linux/
│   ├── 01-sistema.sh        # Aprovisionamiento del sistema (Linux)
│   ├── 02-verificar.sh      # Verificación del entorno
│   ├── 03-actualizar.sh     # Actualización de paquetes
│   ├── 04-vscode.sh         # Instalación de extensiones de VS Code
│   └── lib/                 # Librerías auxiliares (common, install, verify, vscode)
├── windows/
│   ├── 01-sistema.ps1       # Aprovisionamiento del sistema (Windows)
│   ├── 02-verificar.ps1     # Verificación del entorno
│   ├── 03-actualizar.ps1    # Actualización de paquetes
│   ├── 04-vscode.ps1        # Instalación de extensiones de VS Code
│   └── lib/                 # Librerías auxiliares PowerShell
├── logs/                    # Directorio de logs de ejecución
├── setup.sh                 # Asistente CLI interactivo para Linux
├── setup.ps1                # Asistente CLI interactivo para Windows
└── README.md                # Documentación principal
```

---

## 📄 Licencia

Este proyecto está bajo la licencia MIT. Puedes usarlo, modificarlo y adaptarlo a las necesidades de tu equipo de desarrollo.
