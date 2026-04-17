# -----------------------------------------------------------------
# Función para seleccionar un tema de LS_COLORS
# -----------------------------------------------------------------

set_ls_theme() {
    # Definimos las variables de temas DENTRO de la función
    # para que sean locales y no "contaminen" el shell.
    local theme_neon
    local theme_nordic
    local theme_gruvbox
    local theme_classic
    local theme_solarized
    local theme_dracula
    local theme_catppuccin
    
    # --- Tus temas originales ---
    theme_neon="di=38;5;39:ln=38;5;51:ex=38;5;154:ow=48;5;196;38;5;231:*.tar=38;5;214:*.zip=38;5;214:*.gz=38;5;214:*.jpg=38;5;201:*.png=38;5;201:*.mkv=38;5;201:*.mp3=38;5;201:*.md=38;5;229:*.txt=38;5;229:*.sh=38;5;154:*.py=38;5;154"
    theme_nordic="di=38;5;67:ln=38;5;144:ex=38;5;132:ow=48;5;60:*.tar=38;5;180:*.zip=38;5;180:*.gz=38;5;180:*.jpg=38;5;175:*.png=38;5;175:*.mkv=38;5;175:*.mp3=38;5;175:*.md=38;5;223:*.txt=38;5;223:*.sh=38;5;132:*.py=38;5;132"
    theme_gruvbox="di=38;5;28:ln=38;5;37:ex=38;5;178:ow=48;5;130;38;5;231:*.tar=38;5;130:*.zip=38;5;130:*.gz=38;5;130:*.jpg=38;5;103:*.png=38;5;103:*.mkv=38;5;103:*.mp3=38;5;103:*.md=38;5;230:*.txt=38;5;230"
    theme_classic="di=01;34:ln=01;36:ex=01;32:ow=41;37:*.tar=01;31:*.zip=01;31:*.gz=01;31:*.jpg=01;35:*.png=01;35:*.mkv=01;35:*.mp3=01;35:*.md=00;37:*.txt=00;37"
    
    # --- 3 Temas nuevos ---
    theme_solarized="di=38;5;33:ln=38;5;61:so=38;5;136:pi=38;5;136:ex=38;5;64:bd=48;5;236;38;5;136:cd=48;5;236;38;5;108:su=48;5;236;38;5;160:sg=48;5;236;38;5;136:tw=48;5;236;38;5;66:ow=48;5;236;38;5;106"
    theme_dracula="di=38;5;141:ln=38;5;141:ex=38;5;80:*.tar=38;5;221:*.zip=38;5;221:*.gz=38;5;221:*.jpg=38;5;139:*.png=38;5;139:*.mkv=38;5;139:*.mp3=38;5;139:*.md=38;5;248:*.txt=38;5;248:*.sh=38;5;80:*.py=38;5;80"
    theme_catppuccin="di=38;5;153:ln=38;5;183:ex=38;5;152:ow=48;5;19;38;5;231:*.tar=38;5;215:*.zip=38;5;215:*.gz=38;5;215:*.jpg=38;5;203:*.png=38;5;203:*.mkv=38;5;203:*.mp3=38;5;203:*.md=38;5;178:*.txt=38;5;178"
    #
# 2. Sanitización de entrada (AQUÍ VA LA LÍNEA)
    local selected_theme="${1:-neon}"
    # El 'case' que aplica el tema
    case "$1" in
        "neon")
            export LS_COLORS="$theme_neon"
            ;;
        "nordic")
            export LS_COLORS="$theme_nordic"
            ;;
        "gruvbox")
            export LS_COLORS="$theme_gruvbox"
            ;;
        "classic")
            export LS_COLORS="$theme_classic"
            ;;
        
        # --- Cases para los nuevos temas ---
        "solarized")
            export LS_COLORS="$theme_solarized"
            ;;
        "dracula")
            export LS_COLORS="$theme_dracula"
            ;;
        "catppuccin")
            export LS_COLORS="$theme_catppuccin"
            ;;

        # Default
        *)
            echo "Tema no encontrado. Usando 'neon' por defecto."
            export LS_COLORS="$theme_neon"
            ;;
    esac
# Mutación in-place del TOML (Sintaxis estricta BSD para macOS)
    sed -i '' -e 's/^palette = .*/palette = "'"$selected_theme"'"/' ~/.config/starship.toml
}

# -----------------------------------------------------------------
# Autocompletado (¡ACTUALIZADO!)
# -----------------------------------------------------------------
# Le enseñamos a 'compctl' los nuevos nombres de los temas
compctl -k "(neon nordic gruvbox classic solarized dracula catppuccin)" set_ls_theme
