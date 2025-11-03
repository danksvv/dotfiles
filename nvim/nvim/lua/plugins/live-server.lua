return {
  "barrett-ruth/live-server.nvim",
  build = "npm install -g live-server",
  cmd = { "LiveServerStart", "LiveServerStop" },

  -- 1. CONFIGURACIÓN DEL PLUGIN (AHORA MULTI-SO)
  config = function()
    -- -------------------------------------------------------------------
    -- INICIO DE LA LÓGICA MULTI-SO
    -- -------------------------------------------------------------------

    -- 1. Detectamos el sistema operativo
    local os_name = vim.loop.os_uname().sysname
    local browser_command = {} -- Por defecto, usa el browser del sistema

    -- 2. Asignamos el comando de browser correcto
    if os_name == "Darwin" then
      -- macOS: Sigue usando tu configuración original
      browser_command = { "--browser=Google Chrome" }
    elseif os_name == "Linux" then
      -- Ubuntu: Usa el comando de terminal 'google-chrome'
      browser_command = { "--browser=google-chrome" }
    end
    -- NOTA: Windows (si lo añades) se llama "Windows_NT"

    -- -------------------------------------------------------------------
    -- FIN DE LA LÓGICA MULTI-SO
    -- -------------------------------------------------------------------

    -- 3. Cargamos el setup con el comando de browser correcto
    require("live-server").setup({
      port = 5500,
      open = true, -- Le dice a live-server que se abra
      file = "index.html",

      -- ESTA ES LA LÍNEA MODIFICADA:
      -- Ahora usa la variable que definimos arriba
      args = browser_command,
    })
  end,

  -- 2. KEYMAPS (ESTO NO SE TOCA, ES CORRECTO)
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
