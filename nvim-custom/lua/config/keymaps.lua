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

map("n", "ca", function()
	vim.lsp.buf.code_action()
end, { desc = "Code action" })

map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
-- hlsearch
map("n", "<Esc>", function()
	if vim.v.hlsearch == 1 then
		vim.cmd("nohlsearch")
	else
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
	end
end, { noremap = true, silent = true })
