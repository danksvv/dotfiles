-- Módulo de Control de Temas Dinámicos de Lualine (config/lualine-switcher.lua)
local LualineSwitcher = {}

-- 1. Lista de temas disponibles (Se mantiene igual)
LualineSwitcher.themes = {
  "cosmicink",
  "bubbles",
  "evil_lualine",
  "slanted-gaps",
}

-- 2. Variables de estado y Almacenamiento
local theme_index = 1
local storage_key = "lualine_current_theme" -- Clave que usaremos en vim.g

-- Función para cargar el tema guardado
local function get_stored_theme()
  -- 🟢 CORRECCIÓN: Usamos vim.g[key] para acceder a variables globales de Vimscript
  local stored_name = vim.g[storage_key]

  if stored_name and type(stored_name) == "string" then
    -- Busca el índice del tema almacenado
    for i, name in ipairs(LualineSwitcher.themes) do
      if name == stored_name then
        theme_index = i
        return name
      end
    end
  end
  return LualineSwitcher.themes[1] -- Devuelve el primer tema si no hay almacenamiento
end

-- Función para aplicar un tema específico (Función clave de alternancia)
function LualineSwitcher.apply_theme(theme_name)
  local theme_path = "plugins.lualine.themes." .. theme_name

  local ok, theme_config = pcall(require, theme_path)
  if not ok then
    vim.notify("Error: No se pudo cargar el tema de Lualine '" .. theme_name .. "'.", vim.log.levels.ERROR)
    return
  end

  require("lualine").setup(theme_config)

  -- 🟢 CORRECCIÓN: Usamos vim.g[key] para guardar el tema actual
  vim.g[storage_key] = theme_name
  vim.notify("Tema de Lualine cambiado a: " .. theme_name, vim.log.levels.INFO)
end

-- 3. Función pública para alternar al siguiente tema (Se mantiene igual)
function LualineSwitcher.next_theme()
  theme_index = theme_index % #LualineSwitcher.themes + 1
  local next_theme_name = LualineSwitcher.themes[theme_index]
  LualineSwitcher.apply_theme(next_theme_name)
end

-- 4. Inicialización: Cargar el tema almacenado al inicio
LualineSwitcher.current_theme = get_stored_theme()

return LualineSwitcher
