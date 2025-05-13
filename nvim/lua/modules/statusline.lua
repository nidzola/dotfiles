vim.cmd([[
  highlight StatusLineGit  gui=bold guibg=#374145 guifg=#dbbc7f
  highlight StatusLineInfo          guibg=#374145 guifg=#dbbc7f
]])

local M = {}

M.current_mode = function()
  local modes = {
    n = "  NORMAL ",
    i = "  INSERT ",
    v = "  VISUAL ",
    V = "  V-LINE ",
    ["\22"] = "  V-BLOCK ", -- ^V interpreted as "\22"
    c = "  COMMAND ",
    R = "  REPLACE ",
    t = "  TERMINAL ",
  }
  return modes[vim.api.nvim_get_mode().mode] or "UNKNOWN "
end

M.git_status = function()
  local branch = vim.b.gitsigns_head or ""
  if branch ~= "" then
    return "  " .. branch .. " "
  end
  return ""
end

M.dap_status = function()
  local status = require("dap").status()
  if status ~= "" then
    return "   " .. status .. " | "
  end
  return ""
end

M.selected_char_count = function()
  if vim.fn.mode():find("[Vv]") == nil then
    return ""
  end

  local starts = vim.fn.line("v")
  local ends = vim.fn.line(".")
  local count = starts <= ends and ends - starts + 1 or starts - ends + 1
  local wc = vim.fn.wordcount()
  return count .. ":" .. wc["visual_chars"] .. " | "
end

M.copilot = function()
  local clients = package.loaded["copilot"] and LazyVim.lsp.get_clients({ name = "copilot", bufnr = 0 }) or {}

  if #clients > 0 then
    return "   "
  end
  return ""
end

M.macro_recording = function()
  local recording_register = vim.fn.reg_recording()
  if recording_register ~= "" then
    return "Recording @" .. recording_register .. " | "
  end
  return ""
end

M.is_cherry_pick_week = function()
  local os_date = os.date("*t")
  local today = os.time({ year = os_date.year, month = os_date.month, day = os_date.day })

  -- define the last release branch cut (Friday)
  local last_cut = os.time({ year = 2025, month = 5, day = 9 })

  -- Loop through 2-week intervals from last cut
  while last_cut <= today do
    local cherry_pick_start = last_cut
    local cherry_pick_end = cherry_pick_start + 5 * 24 * 60 * 60 -- Friday to Wednesday (5 days)

    if today >= cherry_pick_start and today <= cherry_pick_end then
      return " Cherry pick week 🍒 "
    end

    -- Move to next 2-week sprint
    last_cut = last_cut + 14 * 24 * 60 * 60
  end

  return ""
end

M.get_statusline = function()
  local parts = {
    "%{v:lua.status.current_mode()}",
    "%#StatuslineGit#%{v:lua.status.git_status()}",
    "%=", -- right align
    "%#StatusLineInfo#%{v:lua.status.dap_status()}",
    "%#StatusLineInfo#%{v:lua.status.macro_recording()}",
    "%#StatusLineInfo#%{v:lua.status.selected_char_count()}",
    "%#StatusLineInfo#%{v:lua.status.is_cherry_pick_week()}",
    "%#StatusLineInfo#%{v:lua.status.copilot()}",
    "%#StatuslineNormal#%4l/%-4L:%-3c", -- line number (min 4 width), total lines (min 4 width), column number (min 3 width)
  }
  return table.concat(parts)
end

_G.status = M
vim.o.statusline = "%{%v:lua.status.get_statusline()%}"
