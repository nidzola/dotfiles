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
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = bufnr })

	for _, client in ipairs(clients) do
		if client.name == "copilot" then
			return "   "
		end
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

M.get_statusline = function()
	local parts = {
		"%{v:lua.status.current_mode()}",
		"%#StatuslineGit#%{v:lua.status.git_status()}",
		"%=", -- right align
		"%#StatusLineInfo#%{v:lua.status.dap_status()}",
		"%#StatusLineInfo#%{v:lua.status.macro_recording()}",
		"%#StatusLineInfo#%{v:lua.status.selected_char_count()}",
		"%#StatusLineInfo#%{v:lua.status.copilot()}",
		"%#StatuslineNormal#%l/%L:%c", -- line number, total lines, column number
	}
	return table.concat(parts)
end

_G.status = M
vim.o.statusline = "%{%v:lua.status.get_statusline()%}"
