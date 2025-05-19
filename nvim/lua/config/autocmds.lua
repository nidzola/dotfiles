-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local MiniFiles = require("mini.files")

local map_split = function(buf_id, lhs, direction)
  local rhs = function()
    -- Make new window and set it as target
    local new_target_window
    vim.api.nvim_win_call(MiniFiles.get_explorer_state().target_window, function()
      vim.cmd(direction .. " split")
      new_target_window = vim.api.nvim_get_current_win()
    end)

    MiniFiles.set_target_window(new_target_window)
    MiniFiles.go_in()
  end

  -- Adding `desc` will result into `show_help` entries
  local desc = "Split " .. direction
  vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
end
vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    local buf_id = args.data.buf_id
    map_split(buf_id, "gs", "belowright horizontal")
    map_split(buf_id, "gv", "belowright vertical")
  end,
})

-- Disables auto-commenting above and below the commented line
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "r", "o" })
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end

    -- Disable word highlighting under the cursor
    if client.server_capabilities.documentHighlightProvider then
      client.server_capabilities.documentHighlightProvider = false
    end
    if client.supports_method("textDocument/publishDiagnostics") then
      -- In summary, this code configures Neovim to show diagnostic messages from the language server with underlines and signs, but not inline text or popups, and not while you're typing.
      client.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_lines = false,
        virtual_text = false,
        underline = true,
        signs = true,
        update_in_insert = false,
      })
    end
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesActionRename",
  callback = function(event)
    Snacks.rename.on_rename_file(event.data.from, event.data.to)
  end,
})

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { header = false, focusable = true, source = "if_many", border = "rounded" })
  end,
})
