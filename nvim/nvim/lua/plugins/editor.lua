return {
  -- 1. oil.nvim: Explorador de Archivos
  {
    "stevearc/oil.nvim",
    lazy = true,
    cmd = "Oil",
    keys = {
      { "-", "<CMD>Oil<CR>", desc = "Open parent directory with Oil" },
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    config = function() -- INICIO config function (Oil)
      local oil_actions = require("oil.actions")

      require("oil").setup({
        use_default_keymaps = false,
        win_options = { wrap = false, list = false, relativenumber = false },

        -- Keymaps (funciones anidadas están bien)
        keymaps = {
          ["g?"] = oil_actions.show_help,
          ["<CR>"] = oil_actions.select,
          ["<C-s>"] = function()
            oil_actions.select({ vertical = true })
          end,
          ["<C-d>"] = function()
            oil_actions.select({ horizontal = true })
          end,
          ["<C-t>"] = function()
            oil_actions.select({ tab = true })
          end,

          ["-"] = oil_actions.parent,
          ["_"] = oil_actions.open_cwd,
          ["`"] = oil_actions.cd,
          ["~"] = function()
            oil_actions.cd({ scope = "tab" })
          end,

          ["gf"] = oil_actions.new_file,
          ["gd"] = oil_actions.new_dir,
          ["gr"] = oil_actions.rename,
          ["gx"] = oil_actions.delete,
          ["gm"] = oil_actions.move,
          ["gy"] = oil_actions.copy,

          ["g."] = oil_actions.toggle_hidden,
          ["gs"] = oil_actions.change_sort,

          ["<C-c>"] = oil_actions.close,
          ["<C-l>"] = oil_actions.refresh,
          ["<C-p>"] = oil_actions.preview,
        },
      })
    end, -- FIN config function (Oil)
  }, -- FIN de la tabla de plugin (Oil)

  -- 2. nvim-mini/mini.nvim: Módulos Esenciales de Edición
  {
    "nvim-mini/mini.nvim",
    config = function() -- INICIO config function (Mini)
      -- Mini.pairs
      require("mini.pairs").setup({})

      -- Mini.comment
      require("mini.comment").setup({
        options = {
          custom_commentstring = function() -- INICIO función anidada
            return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
          end, -- FIN función anidada
        },
      })

      -- Mini.surround
      require("mini.surround").setup({})

      -- Mini.indentscope
      require("mini.indentscope").setup({
        symbol = "│",
        draw = {
          delay = 0,
          priority = 5,
        },
      })
    end, -- FIN config function (Mini)
  }, -- FIN de la tabla de plugin (Mini)

  -- 3. Productividad y Formato: Tabular (Alineación)
  {
    "godlygeek/tabular",
    lazy = true,
    cmd = "Tabularize",
  }, -- FIN de la tabla de plugin (Tabular)
} -- FIN de la tabla principal 'return'
