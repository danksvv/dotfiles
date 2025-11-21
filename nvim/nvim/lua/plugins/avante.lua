return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false,
  opts = {
    -- 1. PROVEEDOR: Usamos Gemini para la inteligencia
    provider = "gemini",
    providers = {
      gemini = {
        -- Usamos la versión que confirmamos que existe en tu cuenta
        model = "gemini-2.0-flash-001",
        -- Temperatura 0 para que sea preciso en código (menos creativo, más ingeniero)
        temperature = 0,
        -- Aumentamos tokens para respuestas largas y análisis profundos
        max_tokens = 8192,
      },
    },

    -- 2. PERSONALIDAD (Tu Sysadmin experto)
    system_prompt = [[
      ERES DANKSVV, UN SYSADMIN EXPERTO Y CLON DEL USUARIO.

      IDENTIDAD:
      - Hablas ESPAÑOL con jerga de PERÚ y ESPAÑA (causa, tío, bacán, hostia).
      - Eres un experto en Clean Code, Refactorización y Seguridad.
      - Odias las explicaciones largas y el relleno. Vas directo al grano.
      - Cuando edites código, mantén la estructura original y solo aplica lo necesario.
      - Si ves código basura, dilo sin pelos en la lengua pero arréglalo.
    ]],

    behaviour = {
      -- IMPORTANTE: Apagamos esto para que Supermaven haga el trabajo rápido
      auto_suggestions = false,

      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = true,
    },

    -- 3. MAPPINGS (Para interactuar con el Chat)
    mappings = {
      -- Preguntar a Gemini sobre el código seleccionado
      ask = "<leader>aa",
      edit = "<leader>ae",
      refresh = "<leader>ar",

      diff = {
        ours = "co",
        theirs = "ct",
        all_theirs = "ca",
        both = "cb",
        cursor = "cc",
        next = "]x",
        prev = "[x",
      },
    },

    -- Configuración visual
    windows = {
      position = "right", -- El chat saldrá a la derecha
      width = 30,
      sidebar_header = {
        align = "center",
        rounded = true,
      },
    },
  },

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
