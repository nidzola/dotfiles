return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = function()
    local options = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      indent = {
        enabled = true,
        animate = {
          enabled = false,
        },
      },
      lazygit = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      scratch = {
        enabled = true,
        minimal = true,
      },
      words = { enabled = false },
      zen = { enabled = false },
    }

    -- Toggle the profiler
    Snacks.toggle.profiler():map("<leader>pp")
    -- Toggle the profiler highlights
    Snacks.toggle.profiler_highlights():map("<leader>ph")

    return options
  end,
  keys = {
    {
      "<leader>ps",
      function()
        Snacks.profiler.scratch()
      end,
      desc = "Profiler Scratch Buffer",
    },
  },
}
