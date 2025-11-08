-- 💡 Define qué tema quieres usar aquí.
-- local current_theme = "evil_lualine"
-- local current_theme = "bubbles"
local current_theme = "cosmicink"
-- local current_theme = "slanted-gaps"

-- Define la ruta donde buscamos las configuraciones de temas.
local theme_path = "plugins.lualine.themes." .. current_theme

-- --- INICIO BLOQUE DE CARGA Y CORRECCIÓN ---
local ok, custom_theme_config_result = pcall(require, theme_path)
local custom_theme_config = ok and custom_theme_config_result or {}
-- --- FIN BLOQUE DE CARGA Y CORRECCIÓN ---

-- Función para combinar tablas (USO DE VERIFICACIÓN ESTRICTA AQUÍ)
local function deep_merge(target, source)
  -- Si 'source' no es una tabla, salimos inmediatamente para prevenir el error 'pairs'.
  if type(source) ~= "table" then
    return target
  end

  for k, v in pairs(source) do
    if type(v) == "table" and type(target[k]) == "table" then
      deep_merge(target[k], v)
    else
      target[k] = v
    end
  end
  return target
end

-- Configuración base de lualine.
local default_config = {
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },
  sections = {},
  inactive_sections = {},
  extensions = {},
}

-- Fusiona la configuración base con las opciones del tema personalizado (priorizando el tema)
-- Aquí es donde ocurría el error si custom_theme_config no era una tabla.
local final_opts = deep_merge(default_config, custom_theme_config)

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = final_opts,
}
