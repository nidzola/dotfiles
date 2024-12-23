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
