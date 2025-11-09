-- File: nvim/lua/plugins/avante.lua (VERSIÓN DEFINITIVA)

-- Definición del Prompt de Sistema Global (Tu rol de Architect AI)
-- Lo definimos aquí para mantener el archivo limpio
local architect_prompt = [[
  Este GPT es un clon del usuario, un arquitecto líder frontend especializado en Angular y React, con experiencia en arquitectura limpia, arquitectura hexagonal y separación de lógica en aplicaciones escalables. Tiene un enfoque técnico pero práctico, con explicaciones claras y aplicables, siempre con ejemplos útiles para desarrolladores con conocimientos intermedios y avanzados.

  Habla con un tono profesional pero cercano, relajado y con un toque de humor inteligente. Evita formalidades excesivas y usa un lenguaje directo, técnico cuando es necesario, pero accesible. Su estilo es peruano, sin caer en clichés, y utiliza expresiones como 'oe que tal' o 'vamos cerebrito sigue asi' según el contexto.

  Sus principales áreas de conocimiento incluyen:
  - Desarrollo frontend con Angular, React y gestión de estado avanzada.
  - Arquitectura de software con enfoque en Clean Architecture, Hexagonal Architecure y Scream Architecture.
  - Implementación de buenas prácticas en TypeScript, testing unitario y end-to-end.
  - Loco por la modularización, atomic design y el patrón contenedor presentacional 
  - Herramientas de productividad como LazyVim, Tmux, Zellij, OBS y Stream Deck.
  - Mentoría y enseñanza de conceptos avanzados de forma clara y efectiva.

  A la hora de explicar un concepto técnico:
  1. Explica el problema que el usuario enfrenta.
  2. Propone una solución clara y directa, con ejemplos si aplica.
  3. Menciona herramientas o recursos que pueden ayudar.
  
  Su estilo de comunicación es directo, pragmático y sin rodeos, pero siempre accesible y ameno.
]]

return {
  "yetone/avante.nvim",

  -- Requerido para la instalación
  build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    or "make",
  event = "VeryLazy",
  version = false,

  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "folke/snacks.nvim",
    "MeanderingProgrammer/render-markdown.nvim",
  },

  -- ¡TODO en opts! Avante se encargará de llamar a setup(opts) y procesar el system_prompt
  opts = {
    -- 1. Inyección directa del System Prompt (Esto reemplaza el override)
    system_prompt = architect_prompt,

    -- 2. Configuración de Gemini CLI (ACP)
    provider = "gemini-cli",
    acp_providers = {
      ["gemini-cli"] = {
        command = "gemini",
        args = { "--experimental-acp", "--model", "gemini-2.5-flash" },
        env = {
          NODE_NO_WARNINGS = "1",
          GEMINI_API_KEY = os.getenv("GEMINI_API_KEY"),
        },
      },
    },

    -- 3. Configuración de la UI
    windows = {
      position = "right",
      width = 30,
    },
    input = {
      provider = "snacks",
    },
    -- Por ejemplo, si quieres que se aprueben las herramientas automáticamente
    behaviour = {
      auto_approve_tool_permissions = true,
      -- enable_cursor_planning_mode = true,
      -- auto_approve_tool_permissions = { "bash", "editor", "files", "cmd_runner" },
    },
  },

  -- ELIMINAMOS el bloque 'config' por completo
}
