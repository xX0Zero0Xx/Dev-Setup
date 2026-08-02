# *Dev Setup*

*Herramienta de automatización para preparar un entorno de desarrollo en Linux y Windows, este proyecto está pensado para instalar de forma rápida y consistente las dependencias básicas necesarias para trabajar con tecnologías modernas, especialmente con PHP, Composer, Node.js y VS Code.*


---

## *¿Qué hace este proyecto?*

*Dev Setup automatiza tareas comunes de configuración en un equipo nuevo, entre las que destacan:*

- *Instalación de paquetes base del sistema.*
- *Configuración de herramientas de desarrollo.*
- *Instalación de PHP y extensiones necesarias para proyectos Laravel y PHP en general.*
- *Instalación de Composer, Node.js y npm.*
- *Verificación de versiones requeridas.*
- *Instalación de extensiones recomendadas para VS Code.*


---

## *Requisitos previos*

*Necesitas un equipo con alguno de los siguientes sistemas operativos:*

- *Linux basado en Ubuntu o compatible con `apt`*
- *Windows 10 o superior*

*Además, es recomendable tener acceso a Internet para descargar paquetes y herramientas.*


---

## *Paquetes y herramientas que instala*

### *Paquetes base del sistema*

*En Linux, el proyecto instala paquetes como:*

- *`git`*
- *`curl`*
- *`wget`*
- *`zip`*
- *`unzip`*
- *`ca-certificates`*
- *`gnupg`*
- *`lsb-release`*

*En Windows, se utiliza Chocolatey para instalar herramientas de desarrollo principales, incluyendo:*

- *`git`*
- *`php`*
- *`composer`*
- *`nodejs-lts`*

### *Lenguajes y herramientas principales*

*El proyecto está orientado a ofrecer un entorno compatible con:*

- *PHP `8.3`*
- *Composer `2.7`*
- *Node.js `20`*
- *npm `10`*
- *Git `2.40`*

*Además, instala las extensiones de PHP necesarias para desarrollo con Laravel y VS Code.*


---

## *Extensiones recomendadas de VS Code*

*El proyecto instala automáticamente extensiones para mejorar el flujo de trabajo en PHP y Laravel, entre ellas:*

- *`bmewburn.vscode-intelephense-client`*
- *`onecentlin.laravel-blade`*
- *`onecentlin.laravel5-snippets`*
- *`amiralizadeh9480.laravel-extra-intellisense`*
- *`esbenp.prettier-vscode`*
- *`eamodio.gitlens`*

*Estas extensiones ayudan con:*

- *autocompletado de PHP*
- *soporte para Blade Laravel*
- *snippets útiles para desarrollo rápido*
- *formato de código con Prettier*
- *gestión avanzada de Git con GitLens*


---

## *Instalación rápida*

### *1. Clonar el repositorio*

```bash
git clone https://github.com/xX0Zero0Xx/Dev-Setup.git
cd Dev-Setup
```

### *2. Ejecutar los scripts*

#### *Linux*

```bash
cd linux
sudo ./01-sistema.sh
sudo ./02-verificar.sh
sudo ./03-actualizar.sh # opcional
sudo ./04-VS\ Code.sh
```

#### *Windows (PowerShell como administrador)*

```powershell
cd windows
.\01-sistema.ps1
.\02-verificar.ps1
.\03-actualizar.ps1 # opcional
.\04-VS Code.ps1
```


---

## *Flujo recomendado*

1. *Ejecutar la instalación base*
2. *Verificar que las herramientas quedaron correctamente configuradas*
3. *Instalar extensiones de VS Code*
4. *Si es necesario, ejecutar la actualización opcional*


---

## *Nota*

*Asegúrate de ejecutar los scripts desde la carpeta correcta o proporcionar la ruta completa cuando sea necesario. El objetivo del proyecto es ahorrar tiempo y evitar configuraciones manuales repetitivas al preparar un entorno de desarrollo nuevo*
