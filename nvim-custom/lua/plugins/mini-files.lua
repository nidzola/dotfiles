return {
	"echasnovski/mini.files",
	dependencies = {
		{
			"echasnovski/mini.icons",
			config = function()
				require("mini.icons").setup()
			end,
		},
	},
	opts = {
		windows = {
			use_icons = true,
			preview = true,
			width_focus = 60,
			width_preview = 100,
		},
		options = {
			use_as_default_explorer = true,
		},
	},
	keys = {
		{
			"<leader>fm",
			function()
				require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
			end,
			desc = "Open mini.files (Directory of Current File)",
		},
		{
			"<leader>fM",
			function()
				require("mini.files").open(vim.uv.cwd(), true)
			end,
			desc = "Open mini.files (cwd)",
		},
	},
}
