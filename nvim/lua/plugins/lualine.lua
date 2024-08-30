return {
  "nvim-lualine/lualine.nvim",
  opts = {
    sections = {
      lualine_c = {}, -- removing file path, in favour of incline.nvim
      lualine_z = {}, -- removing clock
    },
  },
}
