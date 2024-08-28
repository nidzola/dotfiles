-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Options based on filetypes
-- markdown
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt.wrap = true
    vim.opt.linebreak = true
  end,
})

-- disable commenting next line
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "r", "o" })
  end,
})

-- -- generate go workspaces only when a go file is opened - once
-- _G.go_workspaces_generated = false
-- function generate_go_workspaces()
--   if not _G.go_workspaces_generated and string.match(vim.fn.expand("%:t"), ".go$") then
--     vim.fn.system("sh ~/projects/bin/gowgen")
--     vim.notify("Go workspaces generated!", vim.log.levels.INFO)
--     _G.go_workspaces_generated = true
--   end
-- end
-- vim.cmd([[
--   augroup GoProject
--     autocmd!
--     autocmd BufNewFile,BufRead * silent! lua generate_go_workspaces()
--   augroup END
-- ]])
-- function go_filetype_keymaps()
--   vim.api.nvim_set_keymap(
--     "n",
--     "<leader>gm",
--     "<Cmd>!go generate %<CR>",
--     { noremap = true, silent = true, desc = "Go generate" }
--   )
--
--   vim.api.nvim_set_keymap(
--     "v",
--     "<leader>cg",
--     "<Cmd>'<,'>!node ~/.config/nvim/utils/json-to-go.js<CR>",
--     { noremap = true, silent = true, desc = "Convert JSON to Go struct" }
--   )
-- end
-- vim.cmd([[
--   augroup go_filetype
--     autocmd!
--     autocmd FileType go lua go_filetype_keymaps()
--   augroup END
-- ]])
