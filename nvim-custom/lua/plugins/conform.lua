return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("conform").setup({
			format_on_save = {
				lsp_fallback = true,
				async = false,
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
				graphql = { "prettierd" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
				javascriptreact = { "prettierd" },
			},
		})
	end,
}
