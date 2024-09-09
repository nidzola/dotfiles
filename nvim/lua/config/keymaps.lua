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

-- copy to system clipboard
map("v", "<leader>y", '"+y', { noremap = true })
map("v", "<leader>Y", '"+y$', { noremap = true })

-- centered search moving
map("n", "n", "nzzzv", { desc = "Next result" })
map("n", "N", "Nzzzv", { desc = "Previous result" })

-- diagnostic remap
map("n", "ge", function()
  vim.diagnostic.goto_next()
end, { desc = "Next Diagnostic" })

-- Show dependency versions
map(
  "n",
  "<leader>ps",
  require("package-info").show,
  { silent = true, noremap = true, desc = "Show dependency versions" }
)
-- Hide dependency versions:
map(
  "n",
  "<leader>ph",
  require("package-info").hide,
  { silent = true, noremap = true, desc = "Hide dependency versions" }
)
