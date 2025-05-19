local opt = vim.opt
local g = vim.g
local o = vim.o
local diag = vim.diagnostic

opt.number = true
opt.relativenumber = true

-- File and buffer settings
opt.termguicolors = true
opt.fileencoding = "utf-8" -- File Encoding
opt.autochdir = false
opt.hidden = true
opt.whichwrap = "b,s,<,>,[,],h,l"
opt.iskeyword:append("-,_")
opt.virtualedit = "block"
opt.clipboard = "unnamedplus"

-- Indentation settings
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.smartindent = true
opt.autoindent = true
opt.expandtab = true

-- Display settings
opt.fillchars = { eob = " " }
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.spell = false
opt.spelllang = { "en_us" }
opt.backspace = "indent,eol,start"
opt.guicursor = "i:block"
opt.wrap = false
opt.linebreak = true
opt.breakindent = true
opt.showbreak = "↪ "
opt.inccommand = "nosplit" -- preview incremental substitute
opt.jumpoptions = "view"
opt.laststatus = 3 -- global statusline
opt.linebreak = true -- Wrap lines at convenient points
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.ruler = false -- Disable the default ruler
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current

-- Leader key setting
g.mapleader = " "
g.maplocalleader = " "
g.root_spec = { "cwd" }
g.snacks_animate = false

o.swapfile = false
o.cmdheight = 0
o.updatetime = 300

-- normal JSON
opt.conceallevel = 0

diag.config({
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		source = "if_many",
		border = "rounded",
		focusable = true,
		header = false,
	},
})
