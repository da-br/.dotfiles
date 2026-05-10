return {
	{
		"ok97465/ipybridge.nvim",
		ft = "python",
		config = function()
			local ipybridge = require("ipybridge")
			local function goto_vi_normal_mode()
				ipybridge.goto_vi()
				vim.schedule(function()
					vim.cmd("stopinsert")
				end)
			end

			ipybridge.setup({
				set_default_keymaps = false,
				autoreload = 2,
				python_cmd = vim.fn.expand("~/.dotfiles/.config/nvim/scripts/uv-python"),
				terminal_keymaps = function(set)
					set("<leader>pe", goto_vi_normal_mode, { desc = "IPython back to editor" })
				end,
			})

			vim.keymap.set("n", "<leader>pT", ipybridge.toggle, { desc = "IPython toggle" })
			vim.keymap.set("n", "<leader>pt", ipybridge.goto_ipy, { desc = "IPython go to terminal" })
			vim.keymap.set("n", "<leader>pr", ipybridge.run_cell, { desc = "IPython run cell" })
			vim.keymap.set("n", "<leader>pR", ipybridge.run_file, { desc = "IPython run file" })
			vim.keymap.set("n", "<leader>pd", ipybridge.debug_file, { desc = "IPython debug file" })
			vim.keymap.set("n", "<leader>pe", goto_vi_normal_mode, { desc = "IPython go to editor" })
			vim.keymap.set("n", "<leader>pv", ipybridge.var_explorer_open, { desc = "IPython variables" })
			vim.keymap.set("n", "<leader>pV", ipybridge.var_explorer_refresh, { desc = "IPython refresh variables" })
			vim.keymap.set("n", "<leader>pp", ipybridge.plot_open, { desc = "IPython plots" })
			vim.keymap.set("n", "<leader>pi", ipybridge.interrupt, { desc = "IPython interrupt" })
			vim.keymap.set("n", "<leader>pk", ipybridge.restart, { desc = "IPython restart kernel" })
		end,
	},
}
