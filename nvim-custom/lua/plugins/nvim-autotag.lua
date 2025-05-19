return {
	"windwp/nvim-ts-autotag",
	lazy = true,
	event = { "InsertEnter" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("nvim-ts-autotag").setup()
	end,
}
