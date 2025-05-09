return {
	"stevearc/conform.nvim",
	command = function()
		require("conform").setup({
			format_on_save = {
				lsp_fallback = true,
				timeout_ms = 3000,
			},
		})
	end,
	opts = {
		default_format_opts = {
			lsp_fallback = true,
			timeout_ms = 3000,
		},
		formatters = {
			sqlfluff = {
				command = "sqlfluff",
				require_cwd = false,
			},
		},
		formatters_by_ft = {
			go = { "goimports", "gofmt" },
			sql = { "sqlfluff" },
			lua = { "stylua" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			typescriptreact = { "prettierd", "prettier", stop_after_first = true },
			javascriptreact = { "prettierd", "prettier", stop_after_first = true },
		},
	},
}
