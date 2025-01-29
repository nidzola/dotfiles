return {
  "nyngwang/NeoZoom.lua",
  config = function()
    require("neo-zoom").setup({
      popup = {
        enabled = true,
        exclude_filetypes = {},
        exclude_buftypes = {},
      },
      exclude_buftypes = { "terminal" },
      winopts = {
        offset = {
          width = 0.9,
          height = 0.9,
        },
        border = "thicc",
        style = "minimal",
        winblend = 0,
      },
      presets = {
        {
          filetypes = { "markdown" },
          callbacks = {
            function()
              vim.wo.wrap = true
            end,
          },
        },
      },
    })
  end,
  keys = {
    {
      "<leader><CR>",
      function()
        vim.cmd("NeoZoomToggle")
      end,
      { nowait = true, silent = true },
      desc = "Focus window",
    },
  },
}
