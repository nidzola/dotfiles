return {
	"mfussenegger/nvim-dap",
	config = function()
		local dap = require("dap")

		vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

		-- for name, sign in pairs(LazyVim.config.icons.dap) do
		-- 	sign = type(sign) == "table" and sign or { sign }
		-- 	vim.fn.sign_define(
		-- 		"Dap" .. name,
		-- 		{ text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
		-- 	)
		-- end

		-- setup dap config by VsCode launch.json file
		local vscode = require("dap.ext.vscode")
		local json = require("plenary.json")
		vscode.json_decode = function(str)
			return vim.json.decode(json.json_strip_comments(str))
		end

		dap.configurations.go = dap.configurations.go or {}
		----------------------------------------------------------------------------
		-- LISTEN FOR 'event_output' AND STRIP/REFORMAT LOG LINES
		----------------------------------------------------------------------------

		-- Function to strip ANSI color codes
		local function strip_ansi_codes(s)
			-- Matches typical "\x1b[...m" sequences
			return s:gsub("\x1b%[%d*;?%d*;?%d*m", "")
		end

		-- Simple reformatter to mimic JetBrains-like logs:
		-- e.g. "2025-03-12 19:18:35 [INFO] rest of the message..."
		local function reformat_log_line(line)
			-- Match the format: "2025-03-13 [7:43PM] INFupdating subsections..."
			local date, time_bracket, level_msg =
				line:match("^%s*(%d%d%d%d%-%d%d%-%d%d)%s+(%[%d+:%d+%u%u%])%s*(%u%u%u.*)")

			if date and time_bracket and level_msg then
				-- Extract the level (first 3 characters) and the message (rest of the string)
				local level = level_msg:sub(1, 3)
				local msg = level_msg:sub(4)

				-- Format with proper spacing
				return string.format("%s %s [%s] %s", date, time_bracket, level, msg)
			end

			-- Fallback for other formats
			local time_12h, level, msg = line:match("^(%d+:%d+%u%u)%s+(%u%u%u)%s+(.*)")
			if time_12h then
				local date_prefix = os.date("%Y-%m-%d") -- e.g., "2025-03-12"
				return string.format("%s %s [%s] %s", date_prefix, time_12h, level, msg)
			end

			-- If we don't match any pattern, just return line as-is
			return line
		end

		-- 4) Register a "before" listener for all output events
		dap.listeners.before.event_output["strip-ansi"] = function(session, body)
			if body and body.output then
				local no_ansi = strip_ansi_codes(body.output)
				body.output = reformat_log_line(no_ansi)
			end
		end
	end,
	keys = {
		{
			"<leader>dB",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "Breakpoint Condition",
		},
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle Breakpoint",
		},
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "Run/Continue",
		},
		{
			"<leader>da",
			function()
				require("dap").continue({ before = get_args })
			end,
			desc = "Run with Args",
		},
		{
			"<leader>dC",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "Run to Cursor",
		},
		{
			"<leader>dg",
			function()
				require("dap").goto_()
			end,
			desc = "Go to Line (No Execute)",
		},
		{
			"<leader>di",
			function()
				require("dap").step_into()
			end,
			desc = "Step Into",
		},
		{
			"<leader>dj",
			function()
				require("dap").down()
			end,
			desc = "Down",
		},
		{
			"<leader>dk",
			function()
				require("dap").up()
			end,
			desc = "Up",
		},
		{
			"<leader>dl",
			function()
				require("dap").run_last()
			end,
			desc = "Run Last",
		},
		{
			"<leader>do",
			function()
				require("dap").step_out()
			end,
			desc = "Step Out",
		},
		{
			"<leader>dO",
			function()
				require("dap").step_over()
			end,
			desc = "Step Over",
		},
		{
			"<leader>dP",
			function()
				require("dap").pause()
			end,
			desc = "Pause",
		},
		{
			"<leader>dr",
			function()
				require("dap").repl.toggle()
			end,
			desc = "Toggle REPL",
		},
		{
			"<leader>ds",
			function()
				require("dap").session()
			end,
			desc = "Session",
		},
		{
			"<leader>dt",
			function()
				require("dap").terminate()
			end,
			desc = "Terminate",
		},
		{
			"<leader>dw",
			function()
				require("dap.ui.widgets").hover()
			end,
			desc = "Widgets",
		},
	},
	-- opts = function(_, opts)
	-- 	local dap = require("dap")
	--
}
