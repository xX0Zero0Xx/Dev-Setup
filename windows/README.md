# 🪟 Guía de Instalación para Windows (PowerShell)

Esta guía detalla el proceso de aprovisionamiento automatizado del entorno de desarrollo en Windows 10 y Windows 11 utilizando PowerShell y Chocolatey.

---

## ⚡ 1. Método Rápido (Recomendado)

Abre **PowerShell como Administrador** y ejecuta el asistente interactivo desde la raíz del proyecto:

```powershell
.\setup.ps1
```

> **Ejecución desatendida completa:**
> ```powershell
> .\setup.ps1 -All
> ```

---

## 📋 2. Ejecución Paso a Paso (Scripts Individuales)

Si prefieres ejecutar cada fase manualmente en una terminal de PowerShell como Administrador:

```powershell
# 1. Instalar Chocolatey, herramientas y configurar extensiones PHP
.\windows\01-sistema.ps1

# 2. Verificar disponibilidad de comandos y versiones
.\windows\02-verificar.ps1

# 3. Actualizar paquetes de Chocolatey (Opcional)
.\windows\03-actualizar.ps1

# 4. Instalar extensiones y configuración de VS Code
.\windows\04-vscode.ps1
```

---

## 📦 Detalle de los Scripts en `windows/`

* [**`01-sistema.ps1`**](01-sistema.ps1) *(Requiere Administrador)*:
  * Carga las versiones requeridas desde [`config/versiones.conf`](../config/versiones.conf).
  * Instala el gestor de paquetes **Chocolatey** si no está presente.
  * Instala **Git**, **PHP 8.3**, **Composer** y **Node.js 20 LTS**.
  * Configura automáticamente `php.ini` activando `extension_dir = "ext"` y las extensiones clave (`curl`, `mbstring`, `pdo_mysql`, `openssl`, `fileinfo`, `gd`, `intl`, `sqlite3`).

* [**`02-verificar.ps1`**](02-verificar.ps1):
  * Comprueba que `git`, `php`, `composer`, `node` y `npm` respondan en el `PATH` y muestra sus versiones instaladas.

* [**`03-actualizar.ps1`**](03-actualizar.ps1) *(Requiere Administrador)*:
  * Ejecuta `choco upgrade all -y` para mantener todas las herramientas al día.

* [**`04-vscode.ps1`**](04-vscode.ps1):
  * Instala las 13 extensiones recomendadas de VS Code.
  * Configura el archivo `%APPDATA%\Code\User\settings.json` con los ajustes estándar.

---

## ❓ Preguntas Frecuentes y Solución de Errores en Windows

### 1. Error de Política de Ejecución de Scripts (`ExecutionPolicy`)
* **Error**: `setup.ps1 no se puede cargar porque la ejecución de scripts está deshabilitada en este sistema`.
* **Solución**: Abre PowerShell como Administrador y permite la ejecución de scripts firmados o locales con:
  ```powershell
  Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
  ```

---

### 2. `'php'`, `'composer'` o `'node'` no se reconocen tras la instalación
* **Causa**: La sesión actual de PowerShell no ha actualizado la variable de entorno `$env:Path`.
* **Solución**:
  1. Cierra y vuelve a abrir PowerShell o VS Code.
  2. O recarga las variables en caliente en la misma ventana de PowerShell ejecutando:
     ```powershell
     $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
     ```
  3. Si tras reiniciar la terminal persiste, añade la ruta de PHP (`C:\tools\php83`) al `Path` en:
     * `Win + R` ➔ `sysdm.cpl` ➔ pestaña *Opciones avanzadas* ➔ *Variables de entorno* ➔ *Variables del sistema* ➔ editar `Path`.

---

### 3. Habilitación de extensiones en `php.ini`
* **Causa**: Al instalar PHP en Windows, varias extensiones esenciales para Laravel vienen comentadas por defecto.
* **Solución**: El script `01-sistema.ps1` realiza esta configuración automáticamente. Para verificarla o editarla manualmente, abre `C:\tools\php83\php.ini` y asegúrate de que no tengan punto y coma (`;`) al inicio:
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

### 4. ¿Dónde se guardan los logs?
Las operaciones de instalación y verificación se registran en:
```powershell
..\logs\setup_YYYY-MM-DD.log
```
