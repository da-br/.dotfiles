return {
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				columns = { "icon" },
				use_default_keymaps = true,
				keymaps = {
					["<C-h>"] = false,
					["<M-h>"] = "actions.select_split",
					["g?"] = { "actions.show_help", mode = "n" },
					["<CR>"] = "actions.select",
					["<C-t>"] = { "actions.select", opts = { tab = true } },
					["<C-p>"] = "actions.preview",
					["<C-c>"] = { "actions.close", mode = "n" },
					["-"] = { "actions.parent", mode = "n" },
					["_"] = { "actions.open_cwd", mode = "n" },
					["`"] = { "actions.cd", mode = "n" },
					["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
				},
				view_options = {
					show_hidden = true,
				},

				buf_options = {
					buflisted = false,
					bufhidden = "hide",
				},
			})
			vim.keymap.set("n", "<leader>fe", "<CMD>Oil<CR>", { desc = "Open file explorer" })
		end,
	},
}
