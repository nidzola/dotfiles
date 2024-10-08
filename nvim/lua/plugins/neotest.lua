return {
  { "nvim-neotest/neotest-plenary" },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "fredrikaverpil/neotest-golang",
      "nvim-neotest/neotest-plenary",
    },
    opts = {
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
        "neotest-plenary",
        require("neotest-golang")({
          -- go install gotest.tools/gotestsum@latest
          runner = "gotestsum",
          go_test_args = {
            "-v",
            "-race",
            "-count=1",
            "-tags=test",
          },
        }),
      },
    },
  },
}
