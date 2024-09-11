return {
  "rcarriga/nvim-notify",
  opts = {
    stages = "static",
    -- stylua: ignore
    max_height = function() return math.floor(vim.o.lines * 0.75) end,
    -- stylua: ignore
    max_width = function() return math.floor(vim.o.columns * 0.75) end,
  },
}
