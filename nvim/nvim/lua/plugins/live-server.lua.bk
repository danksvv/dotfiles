return {
  "barrett-ruth/live-server.nvim",
  build = "npm install -g live-server",
  cmd = { "LiveServerStart", "LiveServerStop" },

  -- 1. CONFIGURACIÓN DEL PLUGIN (LA FORMA CORRECTA)
  config = function()
    require("live-server").setup({
      port = 5500,
      open = true, -- Le dice a live-server que se abra
      file = "index.html",

      -- ESTA ES LA LÍNEA CORRECTA:
      -- Pasamos los argumentos directamente al comando de npm
      args = { "--browser=Google Chrome" },
    })
  end,

  -- 2. KEYMAPS (ESTO ESTÁ BIEN)
  keys = {
    {
      "<leader>ls",
      "<cmd>LiveServerStart<CR>",
      desc = "Iniciar Live Server",
    },
    {
      "<leader>lx",
      "<cmd>LiveServerStop<CR>",
      desc = "Detener Live Server",
    },
  },
}
