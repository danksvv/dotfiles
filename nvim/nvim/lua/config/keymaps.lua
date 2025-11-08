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
