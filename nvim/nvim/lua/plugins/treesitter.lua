return {
  -- Modifica el plugin nvim-treesitter de LazyVim
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    -- Asegura que nvim-ts-autotag sea una dependencia
    "windwp/nvim-ts-autotag",
  },
  opts = function(_, opts)
    -- Sobrescribe la tabla opts para incluir autotag en su formato moderno
    opts.autotag = {
      enable = true,
      -- Configuración opcional
      enable_close = true,
      enable_rename = true,
    }
    return opts
  end,
}
