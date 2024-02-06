-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
-- Copy to clipboard
map({ "n", "v" }, "<leader>y", "+y", { remap = false })
map("n", "<leader>Y", "+yg_", { remap = false })
map("n", "<leader>yy", "+yy", { remap = false })

-- Paste from clipboard
map({ "n", "v" }, "<leader>p", "+p", { remap = false })
map({ "n", "v" }, "<leader>P", "+P", { remap = false })

-- dap
map("n", "<leader>D", function()
  require("dap").step_over()
end, { remap = false })
