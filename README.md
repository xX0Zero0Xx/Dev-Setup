# *Dev Setup*

*Herramienta de automatización para preparacion de entorno de desarrollo (Linux / Windows)*

> *Nota : Para evitar errores de capa 8 lea bien la asignación*

---

# *Requisitos previos*

*Contar con equipo con Sistema Operativo **Linux** ( distros basadas en Ubuntu o campatibles con paqueteria **apt** ) o **Window***


---


# *Instalación*

## *1 Instalar git en VS Code (Terminal)*

```bash
# Para sistemas Linux (basados en ubuntu)
sudo apt update
sudo apt upgrade
sudo apt install git

# Para sistemas Windows
winget install --id Git.Git -e --source winget --silent --accept-package-agreements --accept-source-agreements
```

### *2 Clonar el repositorio (Terminal de VS Code)*

```bash
git clone https://github.com/xX0Zero0Xx/Dev-Setup.git
cd Dev-Setup
```

## *3 Ejecucion de Scripts*

```bash
# Linux
cd linux
sudo ./01-system.sh
sudo ./02-verify.sh
sudo ./04-vscode.sh
sudo ./03-update.sh # Opcional

# Windows
cd windows
.\01-system.ps1
.\02-verify.ps1
.\04-vscode.ps1
.\03-update.ps1 # Opcional
```

# *Nota : Asegurece de estar en el directorio correcto o agregar la ruta completa en cada comando O_¬*
