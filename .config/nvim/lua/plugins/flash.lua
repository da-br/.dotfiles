return {
	"folke/flash.nvim",
	event = "VeryLazy",
	config = function()
		local flash = require("flash")

		vim.keymap.set({ "n", "x", "o" }, "s", function()
			flash.jump()
		end, { desc = "Flash jump" })

		vim.keymap.set({ "n", "x", "o" }, "S", function()
			flash.treesitter()
		end, { desc = "Flash jump treesitter" })

		vim.keymap.set({ "o" }, "r", function()
			flash.remote()
		end, { desc = "Flash Remote" })

		vim.keymap.set({ "o" }, "R", function()
			flash.treesitter_search()
		end, { desc = "Flash Treesitter Search" })

		vim.keymap.set({ "c" }, "<C-S>", function()
			flash.toggle()
		end, { desc = "Flash Toggle Search" })
	end,
}
