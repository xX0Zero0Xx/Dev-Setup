# 🐧 Guía de Instalación para Linux (Ubuntu / Linux Mint / Debian)

Esta guía detalla el proceso de aprovisionamiento automatizado del entorno de desarrollo en sistemas basados en Debian/Ubuntu.

---

## ⚡ 1. Método Rápido (Recomendado)

Desde la raíz del proyecto, puedes utilizar el asistente interactivo o ejecutar todo el flujo en un solo comando:

```bash
chmod +x setup.sh linux/*.sh linux/lib/*.sh
./setup.sh
```

> **Ejecución desatendida completa:**
> ```bash
> ./setup.sh --all
> ```

---

## 📋 2. Ejecución Paso a Paso (Scripts Individuales)

Si prefieres ejecutar cada fase de manera manual, asegúrate de otorgar permisos de ejecución y correr los scripts en el siguiente orden:

```bash
# 1. Otorgar permisos de ejecución
chmod -R +x linux/

# 2. Instalar paquetes base, PPA de PHP 8.3, Node.js 20 y Composer
sudo ./linux/01-sistema.sh

# 3. Verificar estado y versiones de las herramientas (Sin sudo)
./linux/02-verificar.sh

# 4. Actualizar paquetes del sistema (Opcional)
sudo ./linux/03-actualizar.sh

# 5. Instalar extensiones y configuración de VS Code (Sin sudo)
./linux/04-vscode.sh
```

---

## 📦 Detalle de los Scripts en `linux/`

* [**`01-sistema.sh`**](01-sistema.sh) *(Requiere `sudo`)*:
  * Actualiza los repositorios de `apt`.
  * Instala utilidades base (`git`, `curl`, `wget`, `zip`, `unzip`, `ca-certificates`, `gnupg`, `lsb-release`).
  * Añade el repositorio PPA `ppa:ondrej/php` e instala PHP 8.3 con sus módulos clave.
  * Añade el repositorio oficial de **NodeSource** e instala Node.js 20 y npm 10.
  * Descarga, verifica con SHA-384 e instala Composer en `/usr/local/bin/composer`.

* [**`02-verificar.sh`**](02-verificar.sh) *(Usuario normal)*:
  * Valida que cada comando esté disponible en el `PATH`.
  * Comprueba semánticamente que las versiones cumplan los mínimos requeridos en [`config/versiones.conf`](../config/versiones.conf).

* [**`03-actualizar.sh`**](03-actualizar.sh) *(Requiere `sudo`)*:
  * Ejecuta `apt-get update && apt-get upgrade`.
  * Actualiza Composer con `composer self-update`.

* [**`04-vscode.sh`**](04-vscode.sh) *(Usuario normal)*:
  * Instala las 13 extensiones recomendadas para PHP/Laravel, productividad y estética.
  * Aplica la plantilla recomendada en `~/.config/Code/User/settings.json`.

---

## ⚠️ Notas Importantes y Buenas Prácticas

1. **Uso de `sudo`**:
   * Solo los scripts `01-sistema.sh` y `03-actualizar.sh` requieren privilegios de superusuario.
   * **No ejecutes `04-vscode.sh` con `sudo`**, ya que las extensiones deben registrarse en el perfil del usuario actual (`~/.vscode/extensions`) y no en la cuenta de `root`.
2. **Registro de Logs**:
   * Todos los comandos ejecutados registran sus trazas y posibles errores en `../logs/setup_YYYY-MM-DD.log`.
3. **Comando `code`**:
   * Si `04-vscode.sh` indica que `code` no está disponible, asegúrate de tener Visual Studio Code instalado y agregarlo al PATH abriendo VS Code y ejecutando desde `Ctrl+Shift+P`: `Shell Command: Install 'code' command in PATH`.
