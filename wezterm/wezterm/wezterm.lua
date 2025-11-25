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
	background_path = "/Users/danksvv/Pictures/Wallpapers/gimp-images/samurai003-gp.png"
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
			opacity = 3.3, -- No afecta la opacidad del fondo, solo el color HSB
			hsb = {
				brightness = 0.01,
				saturation = 0.1,
			},
		},
	}
end

-- ================================================================= --
-- 2. AJUSTES VISUALES: COLORES (MATCHING LS_COLORS NEON)
-- ================================================================= --

config.colors = {
	-- --- Base colors ---
	foreground = "#ffffff", -- Blanco puro para máximo contraste neón
	background = "#000000", -- Negro puro (Tu fondo actual)

	-- --- Cursor colors ---
	cursor_bg = "#00afff", -- Azul eléctrico (Index 39)
	cursor_fg = "#000000",
	cursor_border = "#00afff",

	-- --- Selection colors ---
	selection_fg = "#000000",
	selection_bg = "#afff00", -- Verde lima (Index 154) para resaltar selección

	-- --- UI colors ---
	scrollbar_thumb = "#333333",
	split = "#333333",

	-- --- ANSI colors (Base) ---
	ansi = {
		"#000000", -- Black
		"#ff0000", -- Red: (Index 196) Rojo puro neón
		"#afff00", -- Green: (Index 154) Tu color de ejecutables/scripts
		"#ffaf00", -- Yellow: (Index 214) Tu color de .zip/.tar (Naranja)
		"#00afff", -- Blue: (Index 39) Tu color de DIRECTORIOS
		"#ff00ff", -- Magenta: (Index 201) Tu color de imágenes/media
		"#00ffff", -- Cyan: (Index 51) Tu color de enlaces
		"#e4e4e4", -- White: Un blanco grisáceo suave
	},

	-- --- Bright ANSI colors (Bold) ---
	brights = {
		"#555555", -- Bright Black
		"#ff5f5f", -- Bright Red: (Index 203) Un rojo un poco más suave
		"#d7ff00", -- Bright Green: (Index 190) Aún más lima
		"#ffff00", -- Bright Yellow: Amarillo puro (Index 11)
		"#5fafff", -- Bright Blue: (Index 75) Un azul cielo un poco más suave
		"#ff5fff", -- Bright Magenta: (Index 207) Rosa pastel neón
		"#87ffff", -- Bright Cyan: (Index 123) Cian muy claro
		"#ffffff", -- Bright White: Blanco puro
	},

	-- --- Indexed colors (Neon Extension) ---
	indexed = {
		-- Index 16: Generalmente usado como Naranja.
		-- Lo igualamos a tu color 214 (archivos .zip/.tar)
		[16] = "#ffaf00",

		-- Index 17: Generalmente usado como un Rojo oscuro o Rosa secundario.
		-- Lo igualamos a tu color 201 (archivos .jpg/.png) para mantener el neón.
		[17] = "#ff00ff",
	},
	--
	-- Ajustes de pestañas para que no estorben visualmente
	tab_bar = {
		background = "rgba(0, 0, 0, 0.0)",
		active_tab = {
			bg_color = "rgba(0, 175, 255, 0.4)", -- Azul (Index 39) translúcido
			fg_color = "#ffffff",
		},
		inactive_tab = {
			bg_color = "rgba(50, 50, 50, 0.4)",
			fg_color = "#aaaaaa",
		},
		new_tab = {
			bg_color = "rgba(50, 50, 50, 0.4)",
			fg_color = "#afff00", -- Verde (Index 154)
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
-- 6. AJUSTES DE BARRA DE PESTAÑAS (Estilo Kitty Bubble)
-- ================================================================= --

-- 1. Desactivar estilo por defecto y asegurar fondo transparente
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true -- O false, según prefieras
config.tab_max_width = 32
config.hide_tab_bar_if_only_one_tab = true -- Cambiar a true si prefieres

-- Asegurar que el fondo de la barra sea transparente
config.colors.tab_bar = {
	background = "rgba(0,0,0,0)",
}

-- 2. Definir los caracteres redondeados (Requiere Nerd Fonts)
local left_sep = wezterm.nerdfonts.ple_left_half_circle_thick -- 
local right_sep = wezterm.nerdfonts.ple_right_half_circle_thick -- 

-- 3. Función de formateo avanzado
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	-- Identificar si la pestaña está activa
	local is_active = tab.is_active

	-- Colores basados en tu captura (Lavender vs Dark Gray)
	-- Puedes cambiar estos hex por tus colores Neon si prefieres
	local active_bg = "#cba6f7" -- Lavanda (Pestaña activa)
	local active_fg = "#11111b" -- Texto oscuro (casi negro)

	local inactive_bg = "#313244" -- Gris oscuro (Pestaña inactiva)
	local inactive_fg = "#cdd6f4" -- Texto claro

	-- Seleccionar colores según estado
	local bg_color = is_active and active_bg or inactive_bg
	local fg_color = is_active and active_fg or inactive_fg

	-- Obtener título limpio (lógica que ya tenías)
	local title = " " .. (tab.active_pane.title or "Terminal") .. " "

	-- Definimos los componentes por separado
	local icon_term = ""
	local icon_user = "󰁕"
	local index_num = string.format("%d ", tab.tab_index + 1)

	-- Retornar la estructura visual (PIEZA POR PIEZA)
	return {
		-- 1. Borde Izquierdo (Semicírculo)
		{ Background = { Color = "rgba(0,0,0,0)" } },
		{ Foreground = { Color = bg_color } },
		{ Text = left_sep },

		-- 2. ICONO 1: Terminal (Con NEGRITA para que se vea más lleno)
		{ Background = { Color = bg_color } },
		{ Foreground = { Color = fg_color } },
		{ Attribute = { Intensity = "Bold" } }, -- <--- TRUCO DE TAMAÑO
		{ Text = icon_term .. " " }, -- Agregamos un espacio extra
		{ Attribute = { Intensity = "Normal" } }, -- Reseteamos a normal

		-- 3. Número del índice (Texto normal)
		{ Text = index_num },

		-- 4. ICONO 2: Usuario (Con NEGRITA)
		{ Attribute = { Intensity = "Bold" } }, -- <--- TRUCO DE TAMAÑO
		{ Text = icon_user },
		{ Attribute = { Intensity = "Normal" } },

		-- 5. Título del directorio
		{ Text = title },

		-- 6. Borde Derecho (Semicírculo)
		{ Background = { Color = "rgba(0,0,0,0)" } },
		{ Foreground = { Color = bg_color } },
		{ Text = right_sep },

		-- Espacio transparente final
		{ Text = " " },
	}
end)
--
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
