return {
  "nvim-lualine/lualine.nvim",
  enabled = false,
  opts = {
    theme = "everforest",
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = {},
      lualine_x = {},
      lualine_y = { "location" },
      lualine_z = {},
    },
  },
}
