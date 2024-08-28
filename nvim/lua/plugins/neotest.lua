local golangConfig = {
  go_test_args = {
    "-v",
    "-race",
    "-count=1",
    "-tags=test",
  },
}

return {
  { "nvim-neotest/neotest-plenary" },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "fredrikaverpil/neotest-golang",
      "nvim-neotest/neotest-plenary",
    },
    opts = {
      adapters = {
        "neotest-plenary",
        require("neotest-golang")(golangConfig),
      },
    },
  },
}
