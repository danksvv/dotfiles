-- ~/.config/nvim/lua/plugins/image-preview.lua
return {
  "3rd/image.nvim",
  opts = {
    backend = "kitty", -- Esto se queda igual

    integrations = {
      telescope = {
        enabled = true,
      },
      markdown = {
        enabled = true,
      },
    },

    -- --- ESTA ES LA PARTE NUEVA ---
    -- Le decimos al backend "kitty" que use "chafa"
    -- en lugar de "magick" (ImageMagick)
    backend_config = {
      kitty = {
        backend = "chafa",
      },
    },
    -- --- FIN DE LA PARTE NUEVA ---
  },
}
