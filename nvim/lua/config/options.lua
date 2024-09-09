-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt
local g = vim.g
local filetype = vim.filetype
local lsp = vim.lsp

-- File and buffer settings
opt.termguicolors = true
opt.fileencoding = "utf-8" -- File Encoding
opt.autochdir = true
opt.hidden = true
opt.whichwrap = "b,s,<,>,[,],h,l"
opt.iskeyword:append("-,_")
opt.virtualedit = "block"
opt.clipboard = ""

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

-- Filetype settings
filetype.add({
  extension = {
    ["http"] = "http",
  },
})

-- Disables auto-commenting above and below the commented line
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "r", "o" })
  end,
})

-- LSP settings
-- In summary, this code configures Neovim to show diagnostic messages from the language server with underlines and signs, but not inline text or popups, and not while you're typing.
lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
  -- Disable inline diagnostics
  virtual_text = false,
  -- Enable underlining
  underline = true,
  -- Enable signs in the sign column
  signs = true,
  -- Disable popups on hover
  update_in_insert = false,
})
