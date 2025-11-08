-- Módulo de Control de Temas Dinámicos de Color (config/colorscheme-switcher.lua)
local ColorschemeSwitcher = {}

-- 1. Lista de todos los temas (debe coincidir con los archivos .lua en plugins/colorschemes/)
ColorschemeSwitcher.themes = {
  "kanagawa",
  "catppuccin",
  "rose-pine",
  "tokyonight",
  "gruvbox",
  "dracula",
  "onedark", -- Requiere require('onedark').load()
  "github-theme", -- Requiere nombre de variante (ej. github_dark_dimmed)
  "oldworld",
  "sakura",
  "nightfox",
  "everforest",
}

-- 2. Variables de estado y Almacenamiento
local theme_index = 1
local storage_key = "colorscheme_current_theme"

-- Función para cargar el archivo de configuración de opciones de un tema (Ej: onedark.lua)
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
  return ColorschemeSwitcher.themes[1] -- Primer tema como defecto
end

-- Función central para aplicar un tema por su nombre
function ColorschemeSwitcher.apply_theme(theme_name)
  local theme_opts = load_theme_config(theme_name)
  local cmd_name = theme_name

  -- Lógica de Casos Especiales (Movida desde colorscheme.lua)
  if theme_name == "onedark" and rawget(_G, "onedark") then
    require("onedark").setup(theme_opts)
    require("onedark").load()
  elseif theme_name == "catppuccin" and rawget(_G, "catppuccin") then
    require("catppuccin").setup(theme_opts)
    cmd_name = "catppuccin"
  elseif theme_name == "github-theme" then
    -- Usamos la variante como nombre del colorscheme
    cmd_name = "github_dark_dimmed"
    if rawget(_G, "github_theme") and type(require("github_theme").setup) == "function" then
      require("github_theme").setup(theme_opts)
    end

  -- Caso General (Aplica setup() si existe)
  else
    if rawget(_G, theme_name) and type(require(theme_name).setup) == "function" then
      require(theme_name).setup(theme_opts)
    end
  end

  -- Aplicar el colorscheme con el nombre corregido (si no se aplicó con require().load())
  if theme_name ~= "onedark" then
    vim.cmd("colorscheme " .. cmd_name)
  end

  -- Guardar y notificar
  vim.g[storage_key] = theme_name
  vim.notify("Tema de color cambiado a: " .. theme_name, vim.log.levels.INFO)
end

-- Función pública para alternar al siguiente tema
function ColorschemeSwitcher.next_theme()
  theme_index = theme_index % #ColorschemeSwitcher.themes + 1
  local next_theme_name = ColorschemeSwitcher.themes[theme_index]
  ColorschemeSwitcher.apply_theme(next_theme_name)
end

-- Inicialización: Cargar el tema almacenado al inicio
ColorschemeSwitcher.current_theme = get_stored_theme()

return ColorschemeSwitcher
