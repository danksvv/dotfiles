-- This file contains the configuration for disabling specific Neovim plugins.

return {
  {
    -- Plugin: bufferline.nvim
    -- URL: https://github.com/akinsho/bufferline.nvim
    -- Description: A snazzy buffer line (with tabpage integration) for Neovim.
    "akinsho/bufferline.nvim",
    enabled = false, -- Disable this plugin
  },
  -- Deshabilita el motor de Copilot
  { "zbirenbaum/copilot.lua", enabled = false },

  -- Deshabilita la integración con el autocompletado (cmp)
  { "zbirenbaum/copilot-cmp", enabled = false },
}
