-- File: avante-flash-only.lua (Basado en el archivo de tu amigo)

-- Nota: Tu system_prompt completo (architect_prompt) se definiría fuera de esta función,
-- o se pegaría aquí en lugar de la variable de tu amigo.

return {
  "yetone/avante.nvim",

  -- 1. Lógica de Build se mantiene (para estabilidad)
  build = function()
    if vim.fn.has("win32") == 1 then
      return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    else
      return "make"
    end
  end,
  event = "VeryLazy",
  version = false,

  -- Dependencias de estabilidad de tu amigo se mantienen
  dependencies = {
    "MunifTanjim/nui.nvim",
    -- ... (Otras dependencias como img-clip.nvim se mantienen) ...
  },

  opts = function(_, opts)
    -- ********** Lógica de Estabilidad de Ventanas (AvanteResizeFix) **********
    -- Mantenemos toda la lógica de funciones y autocmds de tu amigo aquí para estabilidad

    local in_resize = false
    local original_cursor_win = nil
    local avante_filetypes = { "Avante", "AvanteInput", "AvanteAsk", "AvanteSelectedFiles" }

    -- [Funciones is_in_avante_window, temporarily_leave_avante, restore_cursor_to_avante, cleanup_duplicate_avante_windows se mantienen]
    -- [vim.api.nvim_create_augroup y todos los autocmds de AvanteResizeFix se mantienen]

    -- Nota: Por brevedad, el código extenso de las funciones y autocmds se omite aquí,
    -- pero se mantiene EN EL ARCHIVO.

    return {
      -- 2. CONFIGURACIÓN DE GEMINI CLI (FLASH)
      -- Establecemos el proveedor por defecto a nuestro agente ACP
      provider = "gemini-cli-flash",

      -- Inyectamos el prompt de sistema. Usamos la versión de tu amigo como ejemplo
      -- pero tu versión de architect_prompt se pegaría aquí.
      system_prompt = "Tu prompt de Architect AI...",

      -- 3. Definimos los proveedores ACP
      acp_providers = {
        ["gemini-cli-flash"] = {
          command = "gemini",
          args = {
            "--experimental-acp",
            "--model",
            "gemini-2.5-flash", -- ⚡ SOLO MODELO FLASH
          },
          env = {
            NODE_NO_WARNINGS = "1",
            GEMINI_API_KEY = os.getenv("GEMINI_API_KEY"),
          },
        },
      },

      -- 4. Eliminación de adaptadores de Copilot/Claude y otras configuraciones específicas
      -- Ya no son necesarios: providers = { copilot = { ... } }, cursor_applying_provider, auto_suggestions_provider

      -- Configuraciones de UI y File Selector se mantienen de tu amigo
      file_selector = {
        provider = "snacks",
        provider_opts = {},
      },
      windows = {
        position = "right", -- Lo ajustamos a tu preferencia (era 'left' en el original de tu amigo)
        wrap = true,
        width = 30,
        sidebar_header = {
          enabled = true,
          align = "center",
          rounded = false,
        },
        input = {
          prefix = "> ",
          height = 8,
        },
        edit = {
          start_insert = true,
        },
        ask = {
          floating = false,
          start_insert = true,
          focus_on_apply = "ours",
        },
      },

      -- Comportamiento: Añadimos la aprobación de herramientas para nuestro agente ACP
      behaviour = {
        enable_cursor_planning_mode = true,
        auto_approve_tool_permissions = { "bash", "editor", "files", "cmd_runner" },
      },

      -- ELIMINAMOS el system_prompt extenso de tu amigo para evitar duplicación
      -- (la definición de 'system_prompt' ya está arriba)
    }
  end,
  dependencies = {
    -- Las dependencias de tu amigo se mantienen
  },
}
