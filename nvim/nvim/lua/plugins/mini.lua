return {
  -- (1) Configuración de mini.animate
  -- (Mantenemos la definición existente y completa de mini.animate)
  {
    "nvim-mini/mini.animate",
    config = function()
      require("mini.animate").setup({
        cursor = { duration = 250, style = "in_out_quad" },
        -- Puedes añadir scroll o win_switch si los necesitas en el futuro
      })
    end,
  },
  -- ... (Bloque de mini.animate)

  -- (2) Configuración central del suite 'nvim-mini/mini.nvim'
  {
    "nvim-mini/mini.nvim",
    -- 💡 CORRECCIÓN: Añadir la dependencia requerida por mini.comment
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },

    event = "BufReadPre",
    config = function()
      -- Mini.pairs
      require("mini.pairs").setup({})

      -- Mini.comment (Este bloque es el que necesita la dependencia)
      require("mini.comment").setup({
        options = {
          custom_commentstring = function()
            -- El error se genera aquí
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
