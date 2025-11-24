return {
  {
    "neovim/nvim-lspconfig",
    -- Esto asegura que emmet_ls se integre correctamente
    opts = {
      servers = {
        emmet_ls = {
          -- Esto es crucial: le dice a qué tipos de archivo aplicar Emmet
          filetypes = {
            "html",
            "css",
            "vue",
            "jsx",
            "tsx",
            "svelte",
            "javascript",
            "typescript",
          },
          -- Opcional: Desactiva el atajo por defecto para evitar conflictos
          -- init_options = {
          --   triggerCharacters = { " " }, -- Dispara menos a menudo
          -- },
        },
      },
    },
  },
}
