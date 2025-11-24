-- ==========================================================
-- 💡 CONTROL DE TEMA PRINCIPAL (Dinámico)
-- ==========================================================

-- 🟢 Cargar el Switcher. Esto inicializa 'current_theme' y las funciones de carga.
local ColorschemeSwitcher = require("config.colorscheme-switcher")

-- ==========================================================
-- 🌌 SOLUCIÓN DE TRANSPARENCIA DEFINITIVA (AUTOCMD)
-- ESTE BLOQUE DEBE ESTAR ANTES DEL 'return {}' PRINCIPAL
-- ==========================================================

-- Función para aplicar las anulaciones de transparencia
local function apply_transparency_hooks()
  -- Fondo principal de la ventana y ventanas inactivas
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })

  -- Explorador de Archivos/Árbol (NeoTree, NvimTree)
  vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "MiniFilesNormal", { bg = "none" })

  -- Otros elementos auxiliares (Popups, línea de números, bordes, etc.)
  vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
  vim.api.nvim_set_hl(0, "FoldColumn", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

  -- Grupos críticos (Soluciona OneDark y la Sidebar)
  vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
  vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none" })
  vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
  vim.api.nvim_set_hl(0, "MsgArea", { bg = "none" })
end

-- Creamos un Autocomando para ejecutar el hook en el momento más seguro (después de cargar CUALQUIER colorscheme).
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("TransparentCustomizer", { clear = true }),
  callback = apply_transparency_hooks,
  pattern = "*",
})

-- Ejecutarlo una vez en la carga inicial
apply_transparency_hooks()

-- ==========================================================
-- 🏆 INICIO DE LA TABLA PRINCIPAL DE PLUGINS (RETURN)
-- ==========================================================
return {
  -- 1. Plugin de Transparencia (Se mantiene igual)
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    cmd = { "TransparentEnable", "TransparentDisable" },
    opts = {
      enable = false,
      extra_groups = {
        "Normal",
        "NormalNC",
        "EndOfBuffer",
        "TelescopeNormal",
      },
      exclude = {},
    },
  },

  -- 2. Declaración de todos los Plugins
  { "dgox16/oldworld.nvim", name = "oldworld" },
  -- { "anAcc22/sakura.nvim", name = "sakura" },
  {
    "anAcc22/sakura.nvim",
    name = "sakura",
    -- 🟢 CORRECCIÓN: Declara la dependencia faltante de 'lush.nvim'
    dependencies = { "rktjmp/lush.nvim" },
  },
  { "rebelot/kanagawa.nvim", name = "kanagawa" },
  { "catppuccin/nvim", name = "catppuccin" },
  { "rose-pine/neovim", name = "rose-pine" },
  { "folke/tokyonight.nvim", name = "tokyonight" },
  { "ellisonleao/gruvbox.nvim", name = "gruvbox" },
  { "Mofiqul/dracula.nvim", name = "dracula" },
  { "ful1e5/onedark.nvim", name = "onedark" },
  { "projekt0n/github-nvim-theme", name = "github-theme" },
  { "EdenEast/nightfox.nvim", name = "nightfox" },
  { "neanias/everforest-nvim", name = "everforest" },
  { "bluz71/vim-moonfly-colors", name = "moonfly" }, -- Variantes de Solarized/Dracula (popular)
  { "bluz71/vim-nightfly-guicolors", name = "nightfly" }, -- Hermano de Moonfly, más contrastado
  { "savq/melange-nvim", name = "melange" }, -- Alternativa elegante a Gruvbox
  { "tomasr/molokai", name = "molokai" }, -- Sin soporte de setup, simple
  -- 3. Configuración del Núcleo de LazyVim
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        -- 1. Aplicar la configuración del tema cargado al inicio
        -- La lógica de carga y los if/else fueron movidos al Switcher
        ColorschemeSwitcher.apply_theme(ColorschemeSwitcher.current_theme)

        -- NOTA: La lógica de transparencia se ejecuta AUTOMÁTICAMENTE por el Autocmd.
      end,
    },
  },
}
