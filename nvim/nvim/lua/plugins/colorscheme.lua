return {
  -- 1. Plugin de Transparencia
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    cmd = { "TransparentEnable", "TransparentDisable" },
    opts = {
      enable = false,
      extra_groups = {
        "Normal",
        "NormalNC",
        "Comment",
        "Constant",
        "Special",
        "Identifier",
        "Statement",
        "PreProc",
        "Type",
        "Underlined",
        "Todo",
        "String",
        "Function",
        "Conditional",
        "Repeat",
        "Operator",
        "Structure",
        "LineNr",
        "NonText",
        "SignColumn",
        "CursorLineNr",
        "EndOfBuffer",
        "TelescopeNormal",
      },
      exclude = {},
    },
  },

  -- 2. Temas de Alto Contraste (Tu selección actual)

  -- Tema 2.1: oldworld.nvim (Tu tema principal actual)
  {
    "dgox16/oldworld.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      variant = "oled",
    },
  },

  -- Tema 2.2: sakura.nvim
  { "anAcc22/sakura.nvim" },

  -- ==========================================================
  -- ##          TEMAS POPULARES ADICIONALES (Añadidos)
  -- ==========================================================

  -- ✨ NUEVO: Kanagawa (Estilo japonés, tonos azul-púrpura)
  -- Tiene 3 variantes: 'wave' (default), 'dragon', 'storm'
  { "rebelot/kanagawa.nvim", name = "kanagawa" },

  -- Catppuccin (Muy popular, con 4 variantes)
  { "catppuccin/nvim", name = "catppuccin" },

  -- Rosé Pine (Elegante y suave)
  { "rose-pine/neovim", name = "rose-pine" },

  -- Tokyonight (El tema por defecto de LazyVim, muy completo)
  { "folke/tokyonight.nvim" },

  -- Gruvbox (Un clásico moderno)
  { "ellisonleao/gruvbox.nvim", name = "gruvbox" },

  -- Nightfox (Varias variantes oscuras de alta calidad)
  { "EdenEast/nightfox.nvim" },

  -- Everforest (Tonos verdes y naturales)
  { "neanias/everforest-nvim" },

  -- ==========================================================

  -- 3. Configuración del Núcleo de LazyVim
  {
    "LazyVim/LazyVim",
    opts = {
      -- Usamos una función que se ejecuta después de la carga del tema
      colorscheme = function()
        -- 1. Cargar el tema que quieres usar
        vim.cmd("colorscheme kanagawa") -- <--- ¡Activando Kanagawa (por defecto, la variante 'wave')!

        -- 2. Aplicar las anulaciones de transparencia

        -- Fondo principal de la ventana (Normal) y ventanas inactivas (NormalNC)
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })

        -- Grupos del Explorador de Archivos (Mini.files, NvimTree, NeoTree)
        vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" })
        vim.api.nvim_set_hl(0, "MiniFilesNormal", { bg = "none" })

        -- Otros elementos auxiliares (LSP, línea de números, etc.)
        vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
        vim.api.nvim_set_hl(0, "FoldColumn", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      end,
    },
  },
}
