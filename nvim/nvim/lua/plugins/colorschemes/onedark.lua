-- Configuración para ful1e5/onedark.nvim
return {
  style = "darker", -- Variante: 'dark', 'darker', 'cool', 'deep', 'warm', 'light'.
  transparent = true, -- Opción nativa del plugin para transparencia.

  -- Para forzar la transparencia en pop-ups específicos (aunque tu Autocmd ya lo hace)
  lualine = { transparent = true },
}
