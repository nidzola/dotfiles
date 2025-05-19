return {
	"neovim/nvim-lspconfig",
	opts = {
		diagnostics = {
			underline = true,
			virtual_text = false,
			signs = true,
			update_in_insert = false,
		},
	},
	config = function()
		vim.lsp.config("vtsls", {
			settings = {
				javascript = {
					preferences = {
						importModuleSpecifier = "non-relative",
					},
				},
				typescript = {
					preferences = {
						importModuleSpecifier = "non-relative",
					},
				},
			},
		})
		vim.lsp.config("graphql", {
			settings = {
				root_dir = function(fname)
					return vim.fn.getcwd()
				end,
			},
		})
		vim.lsp.config("gopls", {
			settings = {
				gopls = {
					analyses = {
						unusedparams = true,
						nilness = true,
						shadow = true,
						unusedwrite = true,
					},
					deepCompletion = true,
					staticcheck = true,
					buildFlags = { "-tags=test,wireinject,tools,integration" },
				},
			},
		})
	end,
}
