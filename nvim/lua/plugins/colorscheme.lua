return {
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      ---@diagnostic disable: missing-fields
      require("everforest").setup({
        background = "hard",
        float_style = "dim",
        on_highlights = function(highlight_groups, palette)
          highlight_groups.NormalFloat = { bg = palette.bg0 }
          highlight_groups.DapUIVariable = { fg = palette.blue, bg = palette.bg0, bold = true }
          highlight_groups.DapUIValue = { fg = palette.purple, bg = palette.bg0 }
          highlight_groups.DapUIScope = { fg = palette.blue, bg = palette.bg0, bold = true }
          highlight_groups.DapUIType = { fg = palette.green, bg = palette.bg0, italic = true }
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
