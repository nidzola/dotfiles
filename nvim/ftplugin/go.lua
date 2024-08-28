vim.api.nvim_set_keymap(
  "n",
  "<leader>gm",
  "<Cmd>!go generate %<CR>",
  { noremap = true, silent = true, desc = "Go generate" }
)

vim.api.nvim_set_keymap(
  "v",
  "<leader>cg",
  "<Cmd>'<,'>!node ~/.config/nvim/utils/json-to-go.js<CR>",
  { noremap = true, silent = true, desc = "Convert JSON to Go struct" }
)

_G.go_workspaces_generated = false

function generate_go_workspaces()
  if not _G.go_workspaces_generated then
    vim.fn.system("sh ~/projects/bin/gowgen")
    vim.notify("Go workspaces generated!", vim.log.levels.INFO)
    _G.go_workspaces_generated = true
  end
end

generate_go_workspaces()
