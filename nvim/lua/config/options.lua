-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- -- keep cursor unchanged after quiting
local opt = vim.opt

-- Files and Others
opt.termguicolors = true
opt.fileencoding = "utf-8" -- File Encoding
opt.autochdir = true
opt.hidden = true
opt.whichwrap = "b,s,<,>,[,],h,l"
opt.iskeyword:append("-,_")
opt.virtualedit = "block"

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.smartindent = true
opt.autoindent = true
opt.expandtab = true

opt.fillchars = { eob = " " }
opt.clipboard = ""

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

vim.g.maplocalleader = " "

vim.filetype.add({
  extension = {
    ["http"] = "http",
  },
})

-- testing new diagnostic setup
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  -- Disable inline diagnostics
  virtual_text = false,
  -- Enable underlining
  underline = true,
  -- Disable signs in the sign column
  signs = true,
  -- Disable popups on hover
  update_in_insert = false,
})
