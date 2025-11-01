-- Este archivo contiene la configuración para varios plugins relacionados con la UI en Neovim.

-- Función para generar un número hexadecimal aleatorio (¡Activada!)
local function random_hex(length)
  local hex_chars = "0123456789ABCDEF"
  local result = ""

  for _ = 1, length do
    local random_index = math.random(1, #hex_chars)
    result = result .. string.sub(hex_chars, random_index, random_index)
  end

  return result
end

-- Asigna un color hexadecimal aleatorio a la cabecera del Dashboard.
local hexadecimal = "#" .. random_hex(6)
vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = hexadecimal, bold = true }) -- Color dinámico

return {
  -- Plugin: noice.nvim
  -- URL: https://github.com/folke/noice.nvim
  -- Descripción: Un plugin de Neovim para mejorar la UI de la línea de comandos.
  {
    "folke/noice.nvim",
    config = function()
      require("noice").setup({
        cmdline = {
          view = "cmdline", -- Usa la vista cmdline para la línea de comandos
        },
        presets = {
          bottom_search = true, -- Habilita la vista de búsqueda inferior
          command_palette = true, -- Habilita la vista de paleta de comandos
          lsp_doc_border = true, -- Habilita el borde de documentación de LSP
        },
      })
    end,
  },

  -- Plugin: nvim-docs-view
  -- URL: https://github.com/amrbashir/nvim-docs-view
  -- Descripción: Un plugin de Neovim para ver documentación.
  {
    "amrbashir/nvim-docs-view",
    lazy = true, -- Carga perezosa
    cmd = "DocsViewToggle", -- Comando para alternar la vista de documentación
    opts = {
      position = "right", -- Posiciona la vista de documentación a la derecha
      width = 60, -- Establece el ancho de la vista de documentación
    },
  },

  -- Plugin: lualine.nvim (¡ACTUALIZADO!)
  -- URL: https://github.com/nvim-lualine/lualine.nvim
  -- Descripción: Una barra de estado ultrarrápida y fácil de configurar.
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy", -- Carga perezosa
    requires = { "nvim-tree/nvim-web-devicons", opt = true }, -- Dependencia opcional para íconos
    opts = {
      options = {
        theme = "auto", -- Tema automático
        icons_enabled = true, -- Habilita íconos
        component_separators = { left = "", right = "" }, -- Separadores modernos (líneas rectas)
        section_separators = { left = "", right = "" }, -- Separadores de sección (curvas)
      },
      sections = {
        lualine_a = {
          {
            "mode", -- Muestra el modo actual
            icon = "", -- Ícono para el modo
          },
        },
        lualine_c = {
          {
            "filename", -- Muestra el nombre del archivo
            path = 1, -- Ruta relativa
          },
        },
        lualine_x = {
          "filetype", -- Tipo de archivo
          -- ¡CLAVE! Muestra diagnósticos de LSP (errores, advertencias)
          { "diagnostics", sources = { "nvim_lsp" }, symbols = { error = " ", warn = " ", info = " " } },
        },
        lualine_y = {
          -- Muestra el estado de Git (añadido, modificado, borrado)
          { "diff", symbols = { added = " ", modified = " ", removed = " " } },
          "encoding",
        },
        lualine_z = {
          "location", -- Posición del cursor (línea:columna)
        },
      },
    },
  },
  -- Plugin: incline.nvim (Bloque FINAL y ESTABLE)
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    priority = 1200,

    config = function()
      -- Lógica de exclusión de FileType
      local excluded_filetypes = {
        "NvimTree",
        "lazy",
        "mason",
        "oil",
        "TelescopePrompt",
        "terminal",
      }

      require("incline").setup({
        window = { margin = { vertical = 0, horizontal = 1 } },

        hide = {
          cursorline = true,
        },

        -- Renderizado Simplificado: Solo Muestra el Nombre del Archivo y Modificado
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local components = {}

          if vim.bo[props.buf].modified then
            -- Solo el indicador de modificado
            table.insert(components, { "[+] ", guifg = "#FFD700" })
          end

          table.insert(components, { filename })

          -- NOTA: Se ha eliminado toda la lógica de 'devicons' para evitar el error de renderizado.

          return components
        end,
      })

      -- HOOK DE POST-CONFIGURACIÓN (Lógica de ocultación que ya funcionó)
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
          local ft = vim.bo.filetype
          if vim.tbl_contains(excluded_filetypes, ft) then
            vim.cmd("setlocal winbar= ")
          else
            vim.cmd("setlocal winbar=")
          end
        end,
        group = vim.api.nvim_create_augroup("InclineFTExclude", { clear = true }),
        pattern = "*",
      })
    end,
  },

  -- Plugin: mini.nvim (Mini.animate)
  -- URL: https://github.com/echasnovski/mini.nvim
  -- Descripción: Colección de plugins Lua modulares y rápidos.
  {
    "nvim-mini/mini.nvim", -- <-- ¡Nombre actualizado!
    version = false, -- Usa la última versión
    config = function()
      require("mini.animate").setup({
        resize = { enable = false }, -- Deshabilita animaciones de redimensionamiento
        open = { enable = false }, -- Deshabilita animaciones de apertura
        close = { enable = false }, -- Deshabilita animaciones de cierre
        scroll = { enable = false }, -- Deshabilita animaciones de desplazamiento
      })
    end,
  },

  -- Plugin: zen-mode.nvim
  -- URL: https://github.com/folke/zen-mode.nvim
  -- Descripción: Plugin para codificación libre de distracciones.
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode", -- Comando para alternar Zen Mode
    opts = {
      plugins = {
        gitsigns = true, -- Habilita integración con gitsigns
        tmux = true, -- Habilita integración con tmux
        kitty = { enabled = false, font = "+2" }, -- Deshabilita (o cambia a 'true' para probarlo)
        twilight = { enabled = true }, -- Habilita integración con twilight
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } }, -- Keybinding
  },

  -- Plugin: snacks.nvim (Dashboard)
  -- URL: https://github.com/folke/snacks.nvim/tree/main
  -- Descripción: Plugin para crear un dashboard personalizable.
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        sections = {
          { section = "header" },
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { section = "startup" },
        },
        preset = {
          -- Tu arte ASCII (sin cambios)
          header = [[
                                                                                     
                                --                 :-.                               
                         :+*%#.         -              -##=-                         
                     -*#%@@%           *-   :+           .%@%#+:                     
                  -#%%%@@#-            %%%#*++             #@@@%=-.                  
                :#%%%@@%#+.            %@@%#*-             =@@@@@*-:.                
              :#%%%@%%##**-            @@@@%*-             =@@@@@@%---               
             =%@@%%%%#**+=-  .        +@@%##+:: .         :#%%%@@@@#-::.             
            *%@@@%%#*+==--::....-#--=%%@@*=--+##=-..   ..*#####%%@@@+::..            
           +%@@@@#**+===-::....-#%%@%%@@%=-::.@%@#%%%%+++++****##%@@#:...            
          +##%%%%*-+%@@@@@#:..      :+#*----==:#*-:---===+#@@@@@@@#*=. ....          
         =##*@@@@@@@@%%##%@@%:.      :%@..:+##:    ...:-#@%#++#@@@@@@@@@+...         
        -#%@@%%%%%@@%*++*%::@@#:...-#%%@@@@@#=..*#. .+**:    #%@@@%####%@@%          
       .%@:        +@#*     %%@-=*###-*@@@*=-:..%@@@@#.        %@%+        *+        
       *.           .#-    . .@@@@%*++#@@@@#-..-%*:%#=*        =*            :       
                      :   .    %%@@@@@%-=+#%*.+%@@@@@-.        -                     
                              -%@+-:-*@@%++#####=-=+#@=                              
                              =        -@%*##*--  .    :                             
                                         #%+-                                        
                                         .@-                                         
                                          @ :                                        
                                          .                                          
]],
          -- stylua: ignore
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
  },
}
