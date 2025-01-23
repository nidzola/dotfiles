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
      scratch = {
        enabled = true,
        minimal = true,
      },
      words = { enabled = false },
      zen = { enabled = false },
      ---@class snacks.picker.Config
      picker = {
        sources = {
          files = {
            hidden = true,
          },
        },
        enabled = false,
        layout = {
          layout = {
            backdrop = false,
            width = 0.8,
            min_width = 80,
            height = 0.8,
            min_height = 30,
            box = "vertical",
            border = "rounded",
            title = "{title} {live} {flags}",
            title_pos = "center",
            { win = "input", height = 1, border = "bottom" },
            { win = "list", border = "none" },
            { win = "preview", title = "{preview}", height = 0.65, border = "top" },
          },
        },
      },
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
