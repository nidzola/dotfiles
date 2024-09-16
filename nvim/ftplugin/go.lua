vim.api.nvim_set_keymap(
  "n",
  "<leader>gm",
  "<Cmd>!go generate %<CR>",
  { noremap = true, silent = true, desc = "Go generate" }
)
