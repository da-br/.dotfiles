return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("telescope").setup({

				defaults = {
					mappings = {
						i = {
							["<esc><esc>"] = require("telescope.actions").close,
						},
						n = {
							["<esc><esc>"] = require("telescope.actions").close,
						},
					},
				},
			})

			require("telescope").load_extension("ui-select")

			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find file" })
			vim.keymap.set("n", "<leader>ft", builtin.git_files, { desc = "Find in git files" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find in help" })
			vim.keymap.set("n", "<leader><leader>", builtin.live_grep, { desc = "Grep through" })
			vim.keymap.set({ "n", "v" }, "<leader>fw", builtin.grep_string, { desc = "Grep under curser" })
			vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Find in current file" })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
}
