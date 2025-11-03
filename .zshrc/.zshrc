# -------------------------------------------------------------------
#  Cargador de Zsh específico del SO
# -------------------------------------------------------------------
# Este archivo es gestionado por 'stow'.
# Detecta el SO y carga el archivo de configuración correspondiente.
# -------------------------------------------------------------------

# 1. Detectar el Sistema Operativo
if [[ "$OSTYPE" == "darwin"* ]]; then
    # Es macOS
    # echo "Detectado macOS. Cargando .zshrc-macos"
    source "${ZDOTDIR:-$HOME}/.zshrc-macos"

elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Es Linux (Ubuntu/WSL)
    # echo "Detectado Linux. Cargando .zshrc-linux"
    source "${ZDOTDIR:-$HOME}/.zshrc-linux"

else
    echo "SO no reconocido: $OSTYPE. No se cargó ninguna config de zsh."
fi
