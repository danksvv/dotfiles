![Mi Entorno de Desarrollo](./.assets/danksvv-small.png)

# 🚀 Mi Entorno de Desarrollo (Dotfiles)

Este repositorio contiene mi configuración personal ("dotfiles"). El objetivo es un entorno de desarrollo **limpio, eficiente y 100% reproducible** en cualquier máquina.

Todo está gestionado con [GNU Stow](https://www.gnu.org/software/stow/), que me permite mantener los archivos organizados aquí y enlazarlos simbólicamente a sus ubicaciones correctas en el sistema.

---

## 🛠️ Herramientas Incluidas

Este repositorio configura las siguientes herramientas, donde cada carpeta es un "paquete" de `stow`.

| Herramienta              | Propósito               | Configuración Clave                                                                                                                                                                |
| :----------------------- | :---------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Zsh**                  | Shell principal         | Basado en **Oh My Zsh**. Carga segura de secretos (`.zshrc_private`), gestión de temas `LS_COLORS`, e inicialización de `starship`, `zoxide`, `atuin`, `fnm`, `sdkman` y `direnv`. |
| **Neovim (`nvim`)**      | Editor de código (IDE)  | Basado en **LazyVim**. Incluye LSP, integración con Git (Gitsigns), buscador (Telescope) y soporte para depuración (DAP).                                                          |
| **Kitty / WezTerm**      | Emuladores de Terminal  | Alternativas modernas y rápidas (aceleradas por GPU). WezTerm usa Lua para su configuración, igual que Neovim.                                                                     |
| **Zellij**               | Multiplexor de Terminal | Alternativa moderna a `tmux` para gestionar múltiples paneles y pestañas (ej. Nvim, servidor web, comandos git) dentro de una sola terminal.                                       |
| **Scripts (`scripts/`)** | Utilidades              | Colección de scripts personales (ej. `renombrar_por_fecha.sh`) que se añaden automáticamente al `$PATH`.                                                                           |

---

## 🚀 Guía de Instalación (Multiplataforma)

Pasos para configurar un nuevo entorno desde cero, adaptados a diferentes sistemas operativos.

### 1. Clonar el Repositorio

Primero, clona este repositorio en tu directorio `home`.

```bash
git clone [https://github.com/tu-usuario/dotfiles.git](https://github.com/tu-usuario/dotfiles.git) ~/dotfiles
```

### 2. Instalar el Gestor de Paquetes

Necesitarás un gestor de paquetes para instalar las herramientas.

- **macOS (Intel & Apple Silicon M1/M2/Mx):** Instala Homebrew.

```bash
/bin/bash -c "$(curl -fsSL [https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh](https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh))"
```

- **Ubuntu / Windows (WSL):** apt ya viene instalado. Asegúrate de que esté actualizado.

```bash
sudo apt update && sudo apt upgrade
```

### 3. Instalar Herramientas Base

Instala GNU Stow (el gestor de enlaces) y las demás herramientas.

- **macOS (Intel & Apple Silicon):**

```bash
# El gestor de enlaces
brew install stow

# Herramientas principales
brew install neovim kitty wezterm zellij

# Dependencias de scripts (para renombrar_por_fecha.sh)
brew install exiftool
```

- **Ubuntu / Windows (WSL):**

```bash
# El gestor de enlaces
sudo apt install stow

# Herramientas principales (Neovim puede requerir un PPA para la última versión)
sudo apt install neovim zellij

# Dependencias de scripts
sudo apt install libimage-exiftool-perl

# Nota: Kitty y WezTerm suelen requerir pasos de instalación manual
# Revisa sus sitios web oficiales para la instalación en Ubuntu.
```

### 4. Enlazar los Dotfiles con Stow

Una vez instaladas las herramientas, sitúate en la carpeta del repositorio y usa stow para crear los enlaces simbólicos.

```bash
cd ~/dotfiles

# Enlaza la configuración de zsh
stow zsh

# Enlaza la configuración de Neovim
stow nvim

# Enlaza las demás (ej. kitty, zellij, etc.)
stow kitty
stow wezterm
stow zellij
stow scripts
```

¡Y listo! Al abrir una nueva terminal, Zsh (o tu shell configurada) debería cargar todo el entorno.
