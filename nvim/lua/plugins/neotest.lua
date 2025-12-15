return {
  "nvim-neotest/neotest",
  dependencies = {
    { "fredrikaverpil/neotest-golang" },
    "nvim-neotest/neotest-plenary",
    "nvim-neotest/neotest-jest",
    "antoinemadec/FixCursorHold.nvim",
  },
  ---@diagnostic disable: missing-fields
  config = function()
    require("neotest").setup({
      quickfix = {
        enabled = true,
        open = false,
      },
      discovery = {
        -- Drastically improve performance in ginormous projects by
        -- only AST-parsing the currently opened buffer.
        enabled = true,
      },
      adapters = {
        require("neotest-plenary"),
        require("neotest-golang")({
          -- go install gotest.tools/gotestsum@latest
          warn_test_name_dupes = false,
          runner = "go",
          go_test_args = {
            "-v",
            "-count=1",
            "-tags=test",
          },
          gotestsum_args = {
            "--format",
            "standard-verbose",
            "--jsonfile",
            "results.json",
          },
        }),
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        }),
      },
    })
  end,
}
