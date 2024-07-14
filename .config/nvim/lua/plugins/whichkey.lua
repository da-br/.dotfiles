return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
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
