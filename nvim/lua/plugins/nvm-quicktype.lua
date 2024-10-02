-- deps: npm install -g quicktype
return {
  "midoBB/nvim-quicktype",
  cmd = "QuickType",
  ft = { "typescript", "python", "java", "go", "rust", "cs", "swift", "elixir", "kotlin", "typescriptreact" },
  config = function()
    require("nvim-quicktype").setup({
      global = {
        debug_dir = "/Users/nikola/debug",
      },
    })
  end,
  keys = {
    {
      "<leader>cg",
      "<Cmd>QuickType<CR>",
      desc = "Convert JSON to Go struct",
    },
  },
}
