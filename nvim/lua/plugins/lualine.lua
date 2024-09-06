return {
  "nvim-lualine/lualine.nvim",
  opts = {
    theme = "everforest",
    sections = {
      lualine_c = {}, -- removing file path, in favour of incline.nvim
      lualine_z = {}, -- removing clock
    },
  },
}
