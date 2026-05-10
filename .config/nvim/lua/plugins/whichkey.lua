return {
	"folke/which-key.nvim",
	enabled = true,
	event = "VeryLazy",
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
	opts = {
		triggers = { { "<leader>", mode = { "n" } } },
	},
	config = function()
		local wk = require("which-key")
		wk.add({
			{ "<leader>f", group = "find" }, -- group
			{ "<leader>h", group = "harpoon" }, -- group
			{ "<leader>c", group = "actions" }, -- group
			{ "<leader>t", group = "tests" }, -- group
			{ "<leader>x", group = "diagnostics" }, -- group
			{
				mode = { "n", "v", "i", "x" },
				{ "<ESC>", hidden = true },
			}, -- hide this keymap
		})
	end,
}
