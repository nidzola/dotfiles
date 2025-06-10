-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- prevent accidental starting macro recording
map("n", "q", "<nop>", { noremap = true })
map("n", "qq", "q", { noremap = true })

-- remapping gj gk for wrapped line
map("n", "j", "gj", { desc = "Down In Wrap", noremap = true, silent = true })
map("n", "k", "gk", { desc = "Up In Wrap", noremap = true, silent = true })

-- indenting
map("v", "<", "<gv", { desc = "Indent >", noremap = true, silent = false })
map("v", ">", ">gv", { desc = "Indent <", noremap = true, silent = false })

-- navigate between quickfix items
map("n", "<leader>j", "<cmd>cnext<CR>zz", { desc = "QuickFixList Next" })
map("n", "<leader>k", "<cmd>cprev<CR>zz", { desc = "QuickFixList Previous" })

-- prevent losing selection when pasting and deleting
map("x", "p", '"_dP', { noremap = true, silent = true })
map("n", "x", '"_x', { noremap = true, silent = true })
map("n", "X", '"_X', { noremap = true, silent = true })

-- centered search moving
map("n", "n", "nzzzv", { desc = "Next result" })
map("n", "N", "Nzzzv", { desc = "Previous result" })

map("n", "<leader>cp", function()
  vim.api.nvim_call_function("setreg", { "+", vim.fn.fnamemodify(vim.fn.expand("%"), ":.") })
  vim.notify("Copied path to clipboard")
end, { noremap = true, desc = "Copy relative path to clipboard" })

-- diagnostic remap
map("n", "ge", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next Diagnostic" })

map("n", "<C-g>d", function()
  vim.cmd("vsplit")
  vim.lsp.buf.definition()
end, { silent = true, noremap = true, desc = "Open definition in split" })
