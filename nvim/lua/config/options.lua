-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt
local g = vim.g
local filetype = vim.filetype
local o = vim.o

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
g.maplocalleader = " "
g.root_spec = { "cwd" }
g.snacks_animate = false

o.swapfile = false

-- normal JSON
opt.conceallevel = 0

-- Filetype settings
filetype.add({
  extension = {
    ["http"] = "http",
  },
})

vim.diagnostic.config({
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

vim.ui.open = function(uri)
  if vim.env.SSH_CONNECTION or vim.env.SSH_CLIENT or vim.env.SSH_TTY then
    os.execute('ssh -t nikola@macbook "open \\"' .. uri .. '\\""')
    return
  end
  os.execute(uri)
end
