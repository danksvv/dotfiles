-- ================================================================= --
--                             CONFIGURACIÓN WEZTERM.LUA
-- ================================================================= --

-- Importa la API de Wezterm
local wezterm = require("wezterm")

-- Inicializa la tabla de configuración principal
local config = {}

-- ================================================================= --
-- 1. LÓGICA CONDICIONAL Y BACKGROUND
-- ================================================================= --

-- Obtener el módulo del sistema operativo
local os_name = wezterm.target_triple
local background_path = ""

-- Lógica condicional para asignar la ruta
if os_name:find("darwin") then -- Mac OS
	background_path = "/Users/danksvv/Pictures/Wallpapers/gimp-images/ying-yang001-gp.png"
elseif os_name:find("linux") then -- Linux (Ubuntu)
	background_path = "/home/danks/Pictures/Wallpapers/samurai002-gp.png"
end

-- Asigna la configuración de fondo si se encontró una ruta
if background_path ~= "" then
	config.background = {
		{
			source = {
				File = background_path,
			},
			width = "100%",
			height = "100%",
			opacity = 3.0, -- No afecta la opacidad del fondo, solo el color HSB
			hsb = {
				brightness = 0.01,
				saturation = 0.2,
			},
		},
	}
end

-- ================================================================= --
-- 2. AJUSTES VISUALES: COLORES (OldWorld Theme y Tab Bar)
-- ================================================================= --

config.colors = {
	-- --- Base colors ---
	foreground = "#C9C7CD", -- na: main text (light gray)
	background = "#000000", -- bl: dark background (almost black)

	-- --- Cursor colors ---
	cursor_bg = "#92A2D5", -- ca: blue lavender (cursor background)
	cursor_fg = "#C9C7CD", -- na: main text (cursor foreground)
	cursor_border = "#92A2D5", -- ca: blue lavender (cursor border)
	--
	-- --- Selection colors ---
	selection_fg = "#C9C7CD", -- na: main text (selection foreground)
	selection_bg = "#3B4252", -- gr: dark gray (selection background)

	-- --- UI colors ---
	scrollbar_thumb = "#4C566A", -- nb: medium gray (scrollbar thumb)
	split = "#4C566A", -- nb: medium gray (split line)

	-- --- ANSI colors ---
	ansi = {
		"#000000", -- Black: bl: dark background (almost black)
		"#EA83A5", -- Red: ia: intense pink (errors)
		"#90B99F", -- Green: va: soft green (success)
		"#E6B99D", -- Yellow: ca: beige (warnings)
		"#85B5BA", -- Blue: va: light blue-green (information)
		"#92A2D5", -- Magenta: ca: blue lavender (highlight)
		"#85B5BA", -- Cyan: va: light blue-green (links)
		"#C9C7CD", -- White: na: main text (light gray)
	},

	-- --- Bright ANSI colors ---
	brights = {
		"#4C566A", -- Bright Black: nb: medium gray (bright black)
		"#EA83A5", -- Bright Red: ia: intense pink (bright red)
		"#90B99F", -- Bright Green: va: soft green (bright green)
		"#E6B99D", -- Bright Yellow: ca: beige (bright yellow)
		"#85B5BA", -- Bright Blue: va: light blue-green (bright blue)
		"#92A2D5", -- Bright Magenta: ca: blue lavender (bright magenta)
		"#85B5BA", -- Bright Cyan: va: light blue-green (bright cyan)
		"#C9C7CD", -- Bright White: na: main text (bright white)
	},

	-- --- Indexed colors ---
	indexed = {
		[16] = "#F5A191", -- ca: light peach (orange)
		[17] = "#E29ECA", -- ia: soft pink (pink)
	},

	-- --- TAB BAR Colors ---
	tab_bar = {
		background = "#1e1e2e", -- Fondo general de la barra

		-- Pestaña ACTIVA
		active_tab = {
			bg_color = "#cba6f7",
			fg_color = "#11111b",
		},

		-- Pestaña INACTIVA
		inactive_tab = {
			bg_color = "#313244",
			fg_color = "#a6adc8",
		},

		-- Pestaña NUEVA
		new_tab = {
			bg_color = "#313244",
			fg_color = "#cba6f7",
		},
	},
}

-- ================================================================= --
-- 3. AJUSTES DE FUENTE
-- ================================================================= --

-- Fuente principal
-- config.font = wezterm.font("FiraCode Nerd Font Mono", { weight = "Regular" })
config.font = wezterm.font("Lilex Nerd Font Mono", { weight = "Medium", style = "Italic", stretch = "SemiExpanded" })
-- config.font = wezterm.font("BlexMono Nerd Font Mono", { weight = "Medium" })
config.font_size = 15.5
config.line_height = 1.1

-- ================================================================= --
-- 4. AJUSTES DE VENTANA Y APARIENCIA
-- ================================================================= --

-- Relleno de la ventana (quitar espacio alrededor del terminal)
config.window_padding = {
	top = 0,
	right = 0,
	left = 0,
	bottom = 0,
}

-- Un valor en milisegundos
config.cursor_blink_rate = 750

-- Esto controla la curva de animación para la entrada (inicio del movimiento).
config.cursor_blink_ease_in = "EaseIn"
-- Esto controla la curva de animación para la salida (fin del movimiento).
config.cursor_blink_ease_out = "EaseOut"
--
-- Esto activará el parpadeo visible y la animación suave
config.default_cursor_style = "BlinkingBlock"

-- Opacidad del fondo de la ventana (para que se vea el fondo de pantalla)
config.window_background_opacity = 0.20

-- Blur del fondo (Solo Mac OS)
config.macos_window_background_blur = 2

-- Estilo de fondo (Solo Windows)
config.win32_system_backdrop = "Acrylic"

-- Cierra la ventana sin pedir confirmación
config.window_close_confirmation = "NeverPrompt"

-- Decoración de la ventana (La opción comentada "NONE" quita los botones y el borde.
-- Al estar comentada, usa el valor por defecto que permite la pantalla completa en macOS)
-- config.window_decorations = "NONE"
config.window_decorations = "RESIZE"

-- ================================================================= --
-- 5. RENDIMIENTO Y GRÁFICOS
-- ================================================================= --

-- Límite de FPS para mayor fluidez (Smooth hack)
config.max_fps = 240

-- Habilitar el protocolo de gráficos Kitty
config.enable_kitty_graphics = true

-- (Opcional) Configuración específica para WebGPU/OpenGL
-- config.front_end = "OpenGL"
-- local gpus = wezterm.gui.enumerate_gpus()
-- if #gpus > 0 then
--   config.webgpu_preferred_adapter = gpus[1] -- solo si hay al menos una GPU
-- else
--   wezterm.log_info("No GPUs found, using default settings")
-- end

-- ================================================================= --
-- 6. AJUSTES DE BARRA DE PESTAÑAS
-- ================================================================= --

-- Coloca la barra de pestañas en la parte inferior
config.tab_bar_at_bottom = true

-- Oculta la barra de pestañas si solo hay una abierta
config.hide_tab_bar_if_only_one_tab = true

-- Formato personalizado del título de la pestaña
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = tab.title or ""
	local formatted_title = string.format(" %d: %s", tab.tab_index + 1, title)
	return {
		{ Text = formatted_title },
	}
end)

-- ================================================================= --
-- 7. ATAJOS DE TECLADO (Keybindings)
-- ================================================================= --

-- Mapea el atajo de macOS "Ctrl + Cmd + F" al comando de pantalla completa de WezTerm
-- Esto asegura que funcione incluso si la decoración de la ventana está oculta.
config.keys = {
	{ key = "f", mods = "CMD|CTRL", action = wezterm.action.ToggleFullScreen },

	-- Nuevo: Atajo estándar de macOS para abrir la configuración (Cmd + ,)
	{
		key = ",",
		mods = "CMD",
		action = wezterm.action.SpawnCommandInNewWindow({
			-- Ejecuta nvim con la ruta absoluta del archivo de configuración.
			args = { "nvim", wezterm.home_dir .. "/.config/wezterm/wezterm.lua" },
		}),
	},
	-- Dividir el panel activo en VERTICAL (arriba/abajo)
	{ key = "D", mods = "CMD", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

	-- Dividir el panel activo en HORIZONTAL (izquierda/derecha)
	{ key = "\\", mods = "CMD", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

	-- Cerrar el panel activo
	{ key = "W", mods = "CMD", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
	-- Mover el foco al panel de la IZQUIERDA
	{ key = "LeftArrow", mods = "CMD|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },

	-- Mover el foco al panel de la DERECHA
	{ key = "RightArrow", mods = "CMD|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },

	-- Mover el foco al panel de ARRIBA
	{ key = "UpArrow", mods = "CMD|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },

	-- Mover el foco al panel de ABAJO
	{ key = "DownArrow", mods = "CMD|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },
	-- Zoom/Maximiza el panel activo
	{ key = "Z", mods = "CMD", action = wezterm.action.TogglePaneZoomState },
}
return config
