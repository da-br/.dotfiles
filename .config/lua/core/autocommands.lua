-- Define an autocommand group for the yank highlight
local yank_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

-- Add the autocommand to the group
vim.api.nvim_create_autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})
