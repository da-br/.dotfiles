return {
	{
		"AckslD/nvim-neoclip.lua",
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },
		},
		config = function()
			require("neoclip").setup()

			vim.keymap.set("n", "<leader>vl", ":Telescope neoclip<cr>", { desc = "List Clipboard" })
		end,
	},
}
