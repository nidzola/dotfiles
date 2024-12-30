return {
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("everforest").setup({
        background = "hard",
        float_style = "dim",
        on_highlights = function(highlight_groups, palette)
          highlight_groups.NormalFloat = { bg = palette.bg0 }
          highlight_groups.DapUIVariable = { fg = "#7fbbb3", bg = "#1b2b34", bold = true }
          highlight_groups.DapUIValue = { fg = "#d699b6", bg = "#1b2b34" }
          highlight_groups.DapUIScope = { fg = "#7fbbb3", bg = "#1b2b34", bold = true }
          highlight_groups.DapUIType = { fg = "#a3be8c", bg = "#1b2b34", italic = true }
        end,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
  -- disabling other default lazyvim themes
  {
    "catppuccin/nvim",
    enabled = false,
  },
  {
    "folke/tokyonight.nvim",
    enabled = false,
  },
}
