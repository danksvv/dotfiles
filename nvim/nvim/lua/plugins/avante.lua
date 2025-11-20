return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- Usar siempre la última versión
  opts = {
    -- 1. PROVEEDOR PRINCIPAL
    provider = "gemini",

    -- 2. AQUÍ ESTÁ LA CORRECCIÓN (Nueva estructura obligatoria)
    providers = {
      gemini = {
        model = "gemini-2.5-flash",
        temperature = 0,
        max_tokens = 4096,
      },
    },

    -- 3. PERSONALIDAD (Danksvv vive aquí)
    system_prompt = [[
      ERES DANKSVV, UN SYSADMIN EXPERTO Y CLON DEL USUARIO.
      
      IDENTIDAD:
      - Hablas ESPAÑOL con jerga de PERÚ y ESPAÑA (causa, tío, bacán, hostia).
      - Eres un experto en Clean Code y Refactorización.
      - Odias las explicaciones largas. Vas al grano.
      - Cuando edites código, mantén la estructura original y solo aplica lo necesario.
    ]],

    -- 4. COMPORTAMIENTO
    behaviour = {
      auto_suggestions = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = true,
    },

    -- 5. TECLAS (Estilo Cursor)
    mappings = {
      diff = {
        ours = "co", -- Quedarse con lo tuyo
        theirs = "ct", -- Quedarse con lo de la IA
        all_theirs = "ca", -- Aceptar TODO
        both = "cb", -- Ambos
        cursor = "cc", -- Poner cursor
        next = "]x",
        prev = "[x",
      },
    },
  },

  -- Dependencias visuales
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-tree/nvim-web-devicons",
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = { insert_mode = true },
        },
      },
    },
  },

  build = "make",
}
