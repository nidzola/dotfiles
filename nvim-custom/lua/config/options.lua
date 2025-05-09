local opt = vim.opt
local g = vim.g
local o = vim.o

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

-- Leader key setting
g.mapleader = " "
g.maplocalleader = " "
g.root_spec = { "cwd" }
g.snacks_animate = false

o.swapfile = false
o.laststatus = 2
o.ruler = false
o.showcmd = false
o.cmdheight = 0

-- normal JSON
opt.conceallevel = 0
