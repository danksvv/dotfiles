return {
  -- 💡 Se ha eliminado el bloque de nvim-mini/mini.animate

  -- (2) Configuración central del suite 'nvim-mini/mini.nvim'
  {
    "nvim-mini/mini.nvim",
    -- CORRECCIÓN: Dependencia para comentar
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },

    event = "BufReadPre",
    config = function()
      -- Mini.pairs
      require("mini.pairs").setup({})

      -- Mini.comment (Este bloque es el que necesita la dependencia)
      require("mini.comment").setup({
        options = {
          custom_commentstring = function()
            return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
          end,
        },
      })

      -- Mini.surround
      require("mini.surround").setup({})

      -- Mini.indentscope (UI)
      require("mini.indentscope").setup({
        symbol = "│",
        draw = {
          delay = 0,
          priority = 5,
        },
      })
    end,
  },
}
