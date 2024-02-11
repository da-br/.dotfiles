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

-- delete to null regester
map({ "n", "v" }, "<leader>D", '"_D', { remap = false })
map({ "n", "v" }, "<leader>d", '"_d', { remap = false })

-- nice replace keybind
map("v", "r", '"_dP', { remap = false })

-- vmap r "_dP
-- nnoremap <leader>d "_d
-- vnoremap <leader>d "_d

-- dap
map("n", "<F4>", function()
  require("dapui").toggle()
end, { remap = false })

map("n", "<F5>", function()
  require("dap").continue()
end)

map("n", "<F10>", function()
  require("dap").step_over()
end, { remap = false })
map("n", "<F11>", function()
  require("dap").step_into()
end, { remap = false })
map("n", "<C-F11>", function()
  require("dap").step_out()
end, { remap = false })

map("n", "<F9>", function()
  require("dap").toggle_breakpoint()
end)

map("n", "<C-F9>", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)

map("n", "<Leader>dro", function()
  require("dap").repl.open()
end)
map("n", "<Leader>drl", function()
  require("dap").repl.run_last()
end)
