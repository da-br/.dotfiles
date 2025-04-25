vim.g.mapleader = " "

local map = vim.keymap.set

map("n", "<leader>\\", ":so ~/.config/nvim/init.lua<CR>")

map({ "n", "v" }, "<leader>D", '"_D', { remap = false })
map({ "n", "v" }, "<leader>d", '"_d', { remap = false })

-- nice replace keybind
map("v", "r", '"_dP', { remap = false })
map("v", "<C-C>", '"+y')
map("v", "<C-V>", '"+p')

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- move stuff
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
map({ "n" }, "<leader>BD", function()
	local current_buf = vim.api.nvim_get_current_buf() -- Get the current buffer
	local buffers = vim.api.nvim_list_bufs() -- Get a list of all buffers

	for _, buf in ipairs(buffers) do
		if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf) then
			-- Save the buffer if it's modified
			if vim.api.nvim_buf_get_option(buf, "modified") then
				vim.api.nvim_buf_call(buf, function()
					vim.cmd("write")
				end)
			end
			-- Close the buffer
			vim.api.nvim_buf_delete(buf, {})
		end
	end
end, { desc = "Save and Close all other buffers" })

map("n", "<leader>bd", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

map("n", "gp", "<C-o>", { noremap = true, silent = true })
map("n", "gn", "<C-i>", { noremap = true, silent = true })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
-- map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- diagnostic
local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc><esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- remove stupid suspend
map("n", "<C-z>", "<nop>")
map({ "n", "i" }, "<F1>", "<nop>")
