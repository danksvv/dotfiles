return {
  "HiPhish/rainbow-delimiters.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- configuración básica
    vim.g.rainbow_delimiters = {
      strategy = {
        [""] = "rainbow-delimiters.strategy.global",
        vim = "rainbow-delimiters.strategy.local",
      },
      query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks",
      },
      highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
      },
    }

    -- si prefieres usar setup:
    require("rainbow-delimiters.setup").setup({
      highlight = vim.g.rainbow_delimiters.highlight,
      query = vim.g.rainbow_delimiters.query,
      strategy = vim.g.rainbow_delimiters.strategy,
    })
  end,
}
