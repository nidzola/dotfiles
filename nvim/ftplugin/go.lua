vim.api.nvim_set_keymap(
  "n",
  "<leader>gm",
  "<Cmd>!go generate %<CR>",
  { noremap = true, silent = true, desc = "Go generate" }
)

vim.api.nvim_set_keymap(
  "v",
  "<leader>cg",
  "<Cmd>QuickType<CR>",
  { noremap = true, silent = true, desc = "Convert JSON to Go struct" }
)
