-- Fichero: lua/plugins/oil.lua (Corrección de sintaxis de Select)

return {
  "stevearc/oil.nvim",
  lazy = true,
  cmd = "Oil",
  keys = {
    { "-", "<CMD>Oil<CR>", desc = "Open parent directory with Oil" },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    -- Carga el módulo de acciones de Oil
    local oil_actions = require("oil.actions")

    require("oil").setup({
      use_default_keymaps = false,
      win_options = { wrap = false, list = false, relativenumber = false },

      keymaps = {
        ["g?"] = oil_actions.show_help,
        -- Mapeos esenciales
        ["<CR>"] = oil_actions.select, -- Abrir en buffer actual (simple)

        -- SPLITS (CORREGIDO: Usamos cadenas de acción simples con opciones internas)
        -- Nota: Si la acción es una cadena, el plugin la ejecuta.
        ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open Vertical Split" },
        ["<C-d>"] = { "actions.select", opts = { horizontal = true }, desc = "Open Horizontal Split" },
        ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open in New Tab" },

        -- Navegación
        ["-"] = oil_actions.parent,
        ["_"] = oil_actions.open_cwd,
        ["`"] = oil_actions.cd,
        ["~"] = { oil_actions.cd, opts = { scope = "tab" }, desc = "Change Tab Directory" },

        -- GESTIÓN DE ARCHIVOS
        ["gf"] = oil_actions.new_file,
        ["gd"] = oil_actions.new_dir,
        ["gr"] = oil_actions.rename,
        ["gx"] = oil_actions.delete,
        ["gm"] = oil_actions.move,
        ["gy"] = oil_actions.copy,

        -- Visualización
        ["g."] = oil_actions.toggle_hidden,
        ["gs"] = oil_actions.change_sort,

        -- Utilidades
        ["<C-c>"] = oil_actions.close,
        ["<C-l>"] = oil_actions.refresh,
        ["<C-p>"] = oil_actions.preview,
      },
    })
  end,
}
