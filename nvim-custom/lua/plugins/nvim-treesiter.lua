return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require("nvim-treesitter.configs").setup({
			highlight = {
				enable = true,
				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			},
			ensure_installed = {
				"bash",
				"c",
				"css",
				"diff",
				"dockerfile",
				"dot",
				"git_config",
				"gitignore",
				"go",
				"gomod",
				"gosum",
				"gowork",
				"graphql",
				"hcl",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"json5",
				"jsonc",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"ninja",
				"printf",
				"python",
				"query",
				"query",
				"regex",
				"rst",
				"rust",
				"sql",
				"terraform",
				"toml",
				"tsx",
				"typescript",
				"xml",
				"yaml",
			},
		})
	end,
}
