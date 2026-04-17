-- /nvim/lua/config/keymaps.lua

-- Mapea 'jj' para salir del modo inserción
vim.keymap.set("i", "jj", [[<C-\><C-n>]], { desc = "Exit Insert Mode" })

-- Activar/Desactivar Wrap con <Leader>w (Barra Espaciadora + w)
vim.keymap.set("n", "<leader>w", function()
  vim.o.wrap = not vim.o.wrap
end, { desc = "Toggle Line Wrap" })

-- Aquí puedes añadir otros mapeos que ya tuvieras, como tu <C-b>
vim.keymap.set("i", "<C-b>", "<C-o>de")

----- OIL -----
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Delete all buffers but the current one
vim.keymap.set(
  "n",
  "<leader>bq",
  '<Esc>:%bdelete|edit #|normal`"<Return>',
  { desc = "Delete other buffers but the current one" }
)

-- Disable key mappings in insert mode
vim.api.nvim_set_keymap("i", "<A-j>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-k>", "<Nop>", { noremap = true, silent = true })

-- Disable key mappings in normal mode
vim.api.nvim_set_keymap("n", "<A-j>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-k>", "<Nop>", { noremap = true, silent = true })

-- Disable key mappings in visual block mode
vim.api.nvim_set_keymap("x", "<A-j>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<A-k>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "J", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "K", "<Nop>", { noremap = true, silent = true })

-- ==========================================================
-- ## Guardar con Ctrl+s (TU FUNCIÓN MEJORADA)
-- ==========================================================

-- 1. Definimos tu nueva función de guardado
-- (La hacemos 'local' para que no sea global)
local function SaveFile()
  -- Check if a buffer with a file is open
  if vim.fn.empty(vim.fn.expand("%:t")) == 1 then
    vim.notify("No file to save", vim.log.levels.WARN)
    return
  end

  local filename = vim.fn.expand("%:t") -- Get only the filename
  local success, err = pcall(function()
    vim.cmd("silent! write") -- Try to save the file without showing the default message
  end)

  if success then
    vim.notify(filename .. " Saved!") -- Show only the custom message if successful
  else
    vim.notify("Error: " .. err, vim.log.levels.ERROR) -- Show the error message if it fails
  end
end

-- 2. Asignamos Ctrl+s en Modo Normal a esa función
-- (Asegúrate de que no haya ningún otro mapeo de <C-s> en modo "n")
vim.keymap.set("n", "<C-s>", SaveFile, { desc = "Save File (custom)" })

-- 3. Mantenemos los mapeos de guardado para los otros modos
vim.keymap.set("i", "<C-s>", "<C-o>:w<CR>", { desc = "Save File" })
vim.keymap.set("v", "<C-s>", "<Esc>:w<CR>", { desc = "Save File" })

-- ==========================================================
-- ## Alternancia de Temas de Lualine
-- ==========================================================

vim.keymap.set(
  "n",
  "<leader>lt", -- Tecla elegida: <leader>l t (Lualine Theme)
  function()
    -- Llama a la función next_theme() en el módulo que creamos
    require("config.lualine-switcher").next_theme()
  end,
  { desc = "Alternar Tema de Lualine" }
)

-- ==========================================================
-- ## Alternancia de Temas de Color Principal
-- ==========================================================

-- Keymap para alternar el tema de Color Principal
vim.keymap.set(
  "n",
  "<leader>ct", -- Ejemplo: <leader>c t (Colorscheme Toggle)
  function()
    require("config.colorscheme-switcher").next_theme()
  end,
  { desc = "Alternar Tema de Color" }
)

-- ==========================================================
-- ## Herramientas de Shell (Disk Usage - dug/dus)
-- ==========================================================

-- Función para ejecutar dust (el alias 'dus')
local function RunDust()
  -- Abre un split horizontal y ejecuta el comando 'dust'
  -- Usamos 'vsplit' (split vertical) si quieres que la terminal esté al lado.
  vim.cmd("split | terminal dust")

  -- Nota: 'dust' debe estar disponible en tu PATH.
end

-- Función para ejecutar ncdu (el alias 'dug')
local function RunNcdu()
  -- Abre un split horizontal y ejecuta el comando 'ncdu'
  vim.cmd("split | terminal ncdu")

  -- Nota: 'ncdu' debe estar disponible en tu PATH.
end

-- 3. Mapeos de acceso rápido
vim.keymap.set(
  "n",
  "<leader>ds", -- <leader>d s (Disk Dust/Status)
  RunDust,
  { desc = "Shell: Ejecutar Dust (dus)" }
)

vim.keymap.set(
  "n",
  "<leader>dg", -- <leader>d g (Disk Ncdu/Graph)
  RunNcdu,
  { desc = "Shell: Ejecutar Ncdu (dug)" }
)
-- ==========================================================
-- ## Ayuda Rápida de Comandos (SOLUCIÓN FINAL: Split & Render)
-- ==========================================================

-- 1. Define la ruta de tu archivo de ayuda
local help_file = vim.fn.stdpath("config") .. "/user/help_commands.md"

-- 2. Función para abrir el archivo en un split vertical con renderizado
local function ShowHelp()
  -- Verifica si el archivo existe
  if vim.fn.filereadable(help_file) ~= 1 then
    vim.notify("Archivo de ayuda no encontrado en: " .. help_file, vim.log.levels.WARN)
    return
  end

  -- Abrir el archivo en un buffer temporal y en un nuevo split vertical
  vim.cmd.vsplit(help_file)

  -- Mover el cursor a la nueva ventana (derecha)
  vim.cmd("wincmd l")

  -- Configurar opciones del buffer para solo lectura y renderizado
  vim.bo.buflisted = false -- No mostrar en la lista de buffers
  vim.bo.swapfile = false -- No crear archivo de swap
  vim.bo.modifiable = false -- No se puede modificar
  vim.bo.readonly = true -- Solo lectura
  vim.bo.filetype = "markdown" -- Asegura que el tipo de archivo sea markdown

  -- Activar el renderizado de Markdown (Si el plugin existe)
  -- Esto garantiza que el markdown se vea bien formateado
  local markdown_render_ok, rm = pcall(require, "render-markdown")
  if markdown_render_ok and rm.render_buffer then
    rm.render_buffer(vim.api.nvim_get_current_buf())
  end

  -- Volver al modo normal y mover el foco a la ventana anterior (izquierda)
  -- Esto permite que el usuario pueda empezar a trabajar inmediatamente.
  vim.cmd("wincmd h")
end
-- ================================================
-- -- ## Mapeo para abrir Markdown
-- ================================================
-- Uso <leader>mp (Markdown Preview)
vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreview<cr>", { desc = "Markdown Preview" })
-- Opcional: Para cerrarlo
vim.keymap.set("n", "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", { desc = "Stop Markdown Preview" })

-- 3. Asigna el atajo en modo normal
vim.keymap.set("n", "<leader>h", ShowHelp, { desc = "Mostrar Guía de Comandos (Help/Render)" })
--
-- ==========================================================
-- ## Inteligencia Artificial: Gemini (CodeCompanion)
-- ==========================================================

-- Prefijo <leader>g para no entrar en conflicto con Help (<leader>h)
-- ni con temas de color (<leader>c)

-- 1. Abrir/Cerrar el Chat de Gemini
vim.keymap.set({ "n", "v" }, "<leader>ga", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Gemini: Alternar Chat" })

-- 2. Acciones rápidas de código (Explicar, Refactorizar, Corregir)
-- En modo visual, actúa sobre la selección (útil para Java/Python)
vim.keymap.set({ "n", "v" }, "<leader>ge", "<cmd>CodeCompanion<cr>", { desc = "Gemini: Ejecutar Acción Inline" })

-- 3. Añadir el buffer o selección actual al contexto del chat
vim.keymap.set("v", "<leader>gc", "<cmd>CodeCompanionChat Add<cr>", { desc = "Gemini: Añadir al Contexto" })

-- 4. Abrir panel de comandos de CodeCompanion
vim.keymap.set("n", "<leader>gp", "<cmd>CodeCompanionActions<cr>", { desc = "Gemini: Panel de Comandos" })
