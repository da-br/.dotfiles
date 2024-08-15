return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				diagnostics = "nvim_lsp",
			},
		},
		config = function()
			require("bufferline").setup({
				-- diagnostics = "nvim_lsp",
			})
		end,
	},
}
