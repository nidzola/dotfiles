vim.api.nvim_set_keymap("n", "<leader>gm", "<Cmd>!mockery<CR>", { noremap = true, silent = true, desc = "Go generate" })

vim.api.nvim_set_keymap(
  "n",
  "<leader>gi",
  "<Cmd>!goimports -local $(go list -m) -w %<CR>",
  { noremap = true, silent = true, desc = "goimports buffer" }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>cv",
  ":!go generate %<CR>:lcd %:p:h<CR>:!go run github.com/jmattheis/goverter/cmd/goverter@v1.5.1 gen ./<CR>",
  { noremap = true, silent = true, desc = "Goverter" }
)
