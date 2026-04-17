return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = false,

  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },

  opts = {
    workspaces = {
      {
        name = "Vault",
        -- Usamos la ruta estándar con la expansión de HOME.
        -- Al coincidir con donde tú abres la terminal, el plugin se conectará solo.
        -- path = vim.fn.expand("~") .. "/Google Drive/My Drive/obsidianVault",
-- Ruta virtual idéntica para todas tus máquinas
      path = vim.fn.expand("~") .. "/obsidian",
      },
    },
    -- Reemplazo de las opciones antiguas y duplicadas:
    frontmatter = {
      disable_frontmatter = true, -- Nueva ubicación para evitar el warning
    },

    legacy_commands = false,

    daily_notes = {
      folder = "dailies",
      date_format = "%Y-%m-%d",
      template = "daily.md",
    },

    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      tags = "",
    },

    -- disable_frontmatter = true,

    -- Usamos Telescope para buscar archivos
    picker = {
      name = "telescope.nvim",
    },

    callbacks = {
      enter_note = function(client, note)
        vim.keymap.set("n", "gf", function()
          return require("obsidian").util.gf_passthrough()
        end, { buffer = true, expr = true, noremap = false })
        vim.keymap.set("n", "<leader>ch", function()
          return require("obsidian").util.toggle_checkbox()
        end, { buffer = true })
        vim.keymap.set("n", "<cr>", function()
          return require("obsidian").util.smart_action()
        end, { buffer = true, expr = true })
        -- 👇👇 NUEVO KEYMAP PARA PLANTILLAS 👇👇
        -- Al pulsar ESPACIO + o + t, se abrirá Telescope con tus plantillas
        vim.keymap.set(
          "n",
          "<leader>ot",
          "<cmd>ObsidianTemplate<CR>",
          { buffer = true, desc = "[O]bsidian [T]emplate" }
        )
      end,
    },

    ui = { enable = true },
  },
}
