return {
  "NickvanDyke/opencode.nvim",
  event = "VeryLazy",
  dependencies = {
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  keys = {
    {
      "<leader>aa",
      function()
        require("opencode").toggle()
      end,
      mode = { "n" },
      desc = "OpenCode: Toggle",
    },
    {
      "<leader>as",
      function()
        require("opencode").select({ submit = true })
      end,
      mode = { "n", "x" },
      desc = "OpenCode: Select & Submit",
    },
    {
      "<leader>ai",
      function()
        require("opencode").ask("", { submit = true })
      end,
      mode = { "n", "x" },
      desc = "OpenCode: Ask",
    },
    {
      "<leader>ab",
      function()
        require("opencode").ask("@file ", { submit = true })
      end,
      mode = { "n", "x" },
      desc = "OpenCode: Ask Buffer",
    },
    -- Refactoring Prompts
    {
      "<leader>ape",
      function()
        require("opencode").prompt("explain", { submit = true })
      end,
      mode = { "n", "x" },
      desc = "OpenCode: Explain",
    },
    {
      "<leader>apf",
      function()
        require("opencode").prompt("fix", { submit = true })
      end,
      mode = { "n", "x" },
      desc = "OpenCode: Fix",
    },
    {
      "<leader>apo",
      function()
        require("opencode").prompt("optimize", { submit = true })
      end,
      mode = { "n", "x" },
      desc = "OpenCode: Optimize",
    },
  },
  config = function()
    -- Configuración específica para usar Gemini
    vim.g.opencode_opts = {
      active_llm = "google", -- Cambiamos el motor a Google
      llm = {
        google = {
          model = "gemini-2.0-flash-001", -- El modelo de alta velocidad y precisión
        },
      },
      -- provider = {
      --   snacks = {
      --     win = {
      --       position = "right", -- Mantenemos consistencia con tu layout anterior
      --       width = 0.3,
      --     },
      --   },
      -- },
      server = "snacks",
    }
    -- Obligatorio para detectar cambios de la IA en los ficheros
    vim.o.autoread = true
  end,
}
