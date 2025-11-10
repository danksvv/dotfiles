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

#### ⚙️3.a Herramientas Adicionales Recomendadas

Para que esta configuración de Neovim funcione al 100%, es necesario tener instalado lo siguiente en su sistema (Linux/macOS):

| Herramienta      | Propósito                                         | Instalación (Ejemplo en macOS con Homebrew)   |
| :--------------- | :------------------------------------------------ | :-------------------------------------------- |
| **dust** (`dus`) | Análisis de uso de disco moderno (shell utility). | `brew install dust` o `sudo apt install dust` |
| **ncdu** (`dug`) | Análisis de uso de disco interactivo y ncurses.   | `brew install ncdu` o `sudo apt install ncdu` |
| **Neovim**       | Versión 0.9.x o superior.                         | `brew install neovim`                         |

### 4. Enlazar los Dotfiles con Stow

Una vez instaladas las herramientas, sitúate en la carpeta del repositorio.

**_Importante:_** Usamos dos comandos de stow diferentes. Unos paquetes van directos al **HOME (~)** y otros van al directorio **~/.config.** stow no sobrescribirá archivos existentes; te dará un error si no has hecho backup **(ver Notas Post-Instalación)**.

```bash
cd ~/dotfiles

# 1. Enlazar paquetes que van al directorio HOME (~)
# (ej. zsh, scripts)
stow zsh
# opcional - paquetes scripts personales
stow scripts

# 2. Enlazar paquetes que van a ~/.config
# Usamos --target para apuntar a la carpeta .config
stow --target=$HOME/.config nvim kitty zellij wezterm
```

¡Y listo! Al abrir una nueva terminal, Zsh (o tu shell configurada) debería cargar todo el entorno.

---

### 💡 Notas Post-Instalación y Errores Comunes

#### 1. Conflicto de Archivos Existentes

stow no borrará tus archivos locales (ej. ~/.zshrc o ~/.config/nvim). Si ya existen, stow fallará y te avisará de un conflicto.

Solución: Antes de ejecutar stow, renombra tus archivos locales antiguos para hacer un backup:

```bash
mv ~/.zshrc ~/.zshrc.bak
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.config/kitty ~/.config/kitty.bak
# etc.
```

#### 2. Neovim (LazyVim) y Mason

- **Primer Arranque:** La primera vez que abras nvim, LazyVim instalará automáticamente todos los plugins. Dale un minuto.

- **Error "Mason package path not found" (ej. astro-language-server):** Si ves este error al abrir nvim (especialmente en tu home), es normal.
  - **Causa:** El LSP (servidor de lenguaje) de Astro espera encontrar un paquete (@astrojs/ts-plugin) dentro de la carpeta node_modules de un proyecto. Al no estar en un proyecto de Astro, falla.

  - **Solución:**
    1. El error suele desaparecer solo cuando abres nvim dentro de un proyecto de Astro con npm install ejecutado.

    2. Puedes ejecutar :Mason en Neovim y probar a reinstalar (gU) el paquete astro-language-server.

    3. Si no usas Astro, puedes desactivar el LSP por completo en tu configuración de LazyVim para eliminar el error.

#### 3. Estructura Multi-SO de Zsh (macOS y Ubuntu)

Para mantener una configuración limpia y separada para cada sistema operativo, usamos un patrón "cargador" (dispatcher).

- **¿Qué hace `stow .zshrc`?** Enlaza 4 archivos a tu `$HOME`.
- **¿Por qué 4 archivos?**
  - `~/.zshrc`: Es el único archivo que lee Zsh. Es un "cargador" muy pequeño.
  - `~/.zshrc-macos`: Contiene **toda** la configuración de macOS (incluyendo `brewup`).
  - `~/.zshrc-linux`: Contiene **toda** la configuración de Ubuntu (incluyendo `aptup`).
  - `~/.ls_themes.zsh`: Es el script de temas de color, usado por los otros dos archivos.
- **¿Cómo funciona?** Al abrir la terminal, `~/.zshrc` detecta tu SO (macOS o Linux) y **carga solo el archivo correcto** (`.zshrc-macos` o `.zshrc-linux`). Esto mantiene las configuraciones separadas y limpias.

#### 4. Funcionalidades Clave y Keymaps (ncdu, dust, etc.)

Esta configuración de Neovim está optimizada para la productividad, destacando las siguientes características:

| Categoría       | Descripción                                                                                       | Keymap (Modo Normal) |
| :-------------- | :------------------------------------------------------------------------------------------------ | :------------------- |
| **Shell Tools** | **Análisis de Disco (Dust):** Ejecuta `dust` en un _split_ para ver el uso de disco del proyecto. | `Leader + ds`        |
| **Shell Tools** | **Análisis Interactivo (Ncdu):** Ejecuta `ncdu` en un _split_ para navegar por el uso de disco.   | `Leader + dg`        |
| **Temas**       | **Alternar Colores:** Cambia instantáneamente entre tu selección de _colorschemes_.               | `Leader + c t`       |
| **Temas**       | **Alternar Lualine:** Cambia instantáneamente el tema de la barra de estado de Lualine.           | `Leader + l t`       |
