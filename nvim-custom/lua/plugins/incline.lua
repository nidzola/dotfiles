-- Incline plugin configuration
return {
	"b0o/incline.nvim",
	dependencies = {
		"echasnovski/mini.icons",
	},
	config = function()
		-- Setup Incline with custom configuration
		require("incline").setup({
			hide = {
				cursorline = true,
			},
			window = {
				padding = 0,
				margin = { horizontal = 0 },
			},
			render = function(props)
				-- Load required modules
				local mini_icons = require("mini.icons")

				-- Get buffer properties
				local buf = props.buf
				local modified = vim.bo[buf].modified

				-- Function to get the filename and its display properties
				local function get_filename()
					local filepath = vim.api.nvim_buf_get_name(buf)
					local relative_filepath = vim.fn.fnamemodify(filepath, ":~:.")
					local filename = vim.fn.fnamemodify(filepath, ":t")
					if filename == "" then
						filename = "[No Name]"
					end
					local ft_icon, ft_color = mini_icons.get("file", filename)
					return {
						" ",
						{
							modified and { relative_filepath .. " *", gui = "bold,italic", guifg = "#D8BA7E" }
								or { relative_filepath, gui = "bold", guifg = "#D8BA7E" },
						},
						" ",
						ft_icon and { ft_icon, " ", guibg = "none", group = ft_color } or "",
					}
				end
				-- Function to get diagnostic labels for the buffer
				local function get_diagnostic_label()
					local diagnostic_icons = { error = "", warn = "", info = "", hint = "" }
					local label = {}

					for severity, icon in pairs(diagnostic_icons) do
						local severity_level = vim.diagnostic.severity[string.upper(severity)]
						local diagnostic_count = #vim.diagnostic.get(buf, { severity = severity_level })
						if diagnostic_count > 0 then
							table.insert(
								label,
								{ icon .. " " .. diagnostic_count .. " ", group = "DiagnosticSign" .. severity }
							)
						end
					end
					if #label > 0 then
						table.insert(label, { "┊" })
					end
					return label
				end

				return {
					{ get_diagnostic_label() },
					{ get_filename() },
					group = props.focused and "ColorColumn" or "SignColumn",
				}
			end,
		})
	end,
	-- Optional: Lazy load Incline
	event = "VeryLazy",
}
