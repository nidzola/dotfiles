vim.api.nvim_set_keymap(
  "n",
  "<leader>gm",
  "<Cmd>!go generate %<CR>",
  { noremap = true, silent = true, desc = "Go generate" }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>gi",
  "<Cmd>!goimports -local $(go list -m) -w %<CR>",
  { noremap = true, silent = true, desc = "goimports buffer" }
)
