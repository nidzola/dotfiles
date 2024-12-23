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
        border = "thicc", -- this is a preset, try it :)
        style = "minimal",
        winblend = 0,
      },
      presets = {
        {
          filetypes = { "dapui_.*", "dap-repl" },
          winopts = {
            offset = { top = 0.02, left = 0.26, width = 0.74, height = 0.25 },
          },
        },
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
