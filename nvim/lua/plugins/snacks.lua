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
      gitbrowse = {
        enabled = true,
        open = function(url)
          if vim.env.SSH_CONNECTION or vim.env.SSH_CLIENT or vim.env.SSH_TTY then
            local updated_url = url:gsub("^(https://github%.com)-transcarent", "%1")
            os.execute('ssh -t nikola@macbook "open \\"' .. updated_url .. '\\""')
            return
          end
          vim.ui.open(url)
        end,
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
        enabled = true,
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
    {
      "<leader>sf",
      function()
        local Snacks = require("snacks")
        Snacks.picker({
          enabled = true,
          finder = "proc",
          cmd = "fd",
          args = { "--type", "d", "--exclude", ".git" },
          title = "Select search directory",
          layout = {
            preset = "select",
          },
          actions = {
            confirm = function(picker, item)
              picker:close()
              vim.schedule(function()
                Snacks.picker.grep({
                  cwd = item.file,
                })
              end)
            end,
          },
          transform = function(item)
            item.file = item.text
            item.dir = true
          end,
        })
      end,
      desc = "Search in dir",
    },
  },
}
