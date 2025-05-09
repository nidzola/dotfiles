return {
	"jay-babu/mason-nvim-dap.nvim",
	config = function()
		require("mason-nvim-dap").setup({
			ensure_installed = { "go-debug-adapter", "delve" },
		})
	end,
}
