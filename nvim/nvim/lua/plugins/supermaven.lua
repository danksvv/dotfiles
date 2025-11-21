return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<Tab>", -- Esto hará que TAB acepte la sugerencia
        clear_suggestion = "<C-]>",
        accept_word = "<C-j>",
      },
      -- El color de la sugerencia (gris clarito, tipo Copilot)
      color = {
        suggestion_color = "#888888",
        cterm = 244,
      },
      -- Ignorar buffers gigantes para no bloquear
      ignore_filetypes = { "big_file_type" },
    })
  end,
}
