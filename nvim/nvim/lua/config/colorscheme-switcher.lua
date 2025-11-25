-- Módulo de Control de Temas Dinámicos de Color (config/colorscheme-switcher.lua)
local ColorschemeSwitcher = {}

-- 1. Lista de todos los temas (debe coincidir con los archivos .lua en plugins/colorschemes/)
ColorschemeSwitcher.themes = {
  -- ➡️ COLOCA AQUÍ EL TEMA QUE QUIERES COMO DEFECTO ⬅️
  "gruvbox",
  "dracula",
  "kanagawa",
  "everforest",
  "sakura",
  "moonfly",
  "nightfly",
  "melange",
  "github-theme", -- Requiere nombre de variante (ej. github_dark_dimmed)
  "onedark", -- Requiere require('onedark').load()
  "oldworld",
  "catppuccin",
  "rose-pine",
  "tokyonight",
  "nightfox",
  "molokai",
}

-- 2. Variables de estado y Almacenamiento
local theme_index = 1
local storage_key = "colorscheme_current_theme"

-- ===============================================
-- 🟢 FUNCIONES AUXILIARES (DEBEN DEFINIRSE ANTES DE USARSE)
-- ===============================================

-- Función para cargar el archivo de configuración de opciones de un tema (Ej: kanagawa.lua)
local function load_theme_config(name)
  local theme_path = "plugins.colorschemes." .. name
  local ok, config_table = pcall(require, theme_path)
  return ok and config_table or {}
end

-- Función para obtener el tema guardado
local function get_stored_theme()
  local stored_name = vim.g[storage_key]

  if stored_name and type(stored_name) == "string" then
    for i, name in ipairs(ColorschemeSwitcher.themes) do
      if name == stored_name then
        theme_index = i
        return name
      end
    end
  end

  -- Si no hay tema guardado o no está en la lista, devuelve el primero de la lista
  return ColorschemeSwitcher.themes[1]
end

-- ===============================================
-- 🟢 INICIALIZACIÓN (Ahora llama a funciones ya definidas)
-- ===============================================

-- Inicialización: Cargar el tema almacenado al inicio
ColorschemeSwitcher.current_theme = get_stored_theme()

-- ===============================================
-- 🟢 LÓGICA DEL SWITCHER
-- ===============================================

-- Función central para aplicar un tema por su nombre
function ColorschemeSwitcher.apply_theme(theme_name)
  local theme_opts = load_theme_config(theme_name)
  local cmd_name = theme_name

  -- Lógica de Casos Especiales (Se mantiene)
  if theme_name == "onedark" and rawget(_G, "onedark") then
    require("onedark").setup(theme_opts)
    require("onedark").load()
    return -- Salimos porque onedark.load() aplica el tema
  elseif theme_name == "catppuccin" and rawget(_G, "catppuccin") then
    require("catppuccin").setup(theme_opts)
    cmd_name = "catppuccin"
  elseif theme_name == "github-theme" then
    cmd_name = "github_dark_dimmed" -- El nombre de colorscheme final es un sabor
    if rawget(_G, "github_theme") and type(require("github_theme").setup) == "function" then
      require("github_theme").setup(theme_opts)
    end

  -- Caso General (Aplica setup() si existe y corrige el cmd_name para variantes)
  else
    if rawget(_G, theme_name) and type(require(theme_name).setup) == "function" then
      require(theme_name).setup(theme_opts)
    end

    -- 💡 CORRECCIÓN PARA VARIANTES:
    -- Lista de temas que cargan su variante internamente (sin cambiar el nombre del colorscheme).
    -- Incluir 'onedark', 'gruvbox', y 'tokyonight'
    local themes_to_exclude = { "onedark", "gruvbox", "tokyonight" }

    if not vim.tbl_contains(themes_to_exclude, theme_name) then
      if theme_opts.variant and type(theme_opts.variant) == "string" then
        -- Ejemplo: kanagawa-dragon
        cmd_name = theme_name .. "-" .. theme_opts.variant
      elseif theme_opts.style and type(theme_opts.style) == "string" then
        -- Ejemplo: nightfox-day
        cmd_name = theme_name .. "-" .. theme_opts.style
      end
    end
  end

  -- Aplicar el colorscheme con el nombre corregido (¡Ahora con la variante!)
  vim.cmd("colorscheme " .. cmd_name)

  -- Guardar y notificar
  vim.g[storage_key] = theme_name
  -- Notificación mejorada para mostrar qué variante se cargó
  vim.notify("Tema de color cambiado a: " .. theme_name .. " (" .. cmd_name .. ")", vim.log.levels.INFO)
end

-- Función pública para alternar al siguiente tema
function ColorschemeSwitcher.next_theme()
  theme_index = theme_index % #ColorschemeSwitcher.themes + 1
  local next_theme_name = ColorschemeSwitcher.themes[theme_index]
  ColorschemeSwitcher.apply_theme(next_theme_name)
end

return ColorschemeSwitcher
