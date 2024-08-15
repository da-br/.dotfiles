local function get_arguments()
	return coroutine.create(function(dap_run_co)
		local args = {}
		vim.ui.input({ prompt = "Args: " }, function(input)
			args = vim.split(input or "", " ")
			coroutine.resume(dap_run_co, args)
		end)
	end)
end

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			{ "williamboman/mason.nvim", opts = { ensure_installed = { "delve" } } },
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			local dap = require("dap")
			local ui = require("dapui")

			require("dapui").setup()
			require("dap-go").setup({
				dap_configurations = {
					{
						type = "go",
						request = "launch",
						name = "main.go",
						program = "${workspaceFolder}/main.go",
						args = get_arguments,
					},
				},
			})

			require("nvim-dap-virtual-text").setup()

			-- Eval var under cursor
			vim.keymap.set("n", "<space>=", function()
				require("dapui").eval(nil, { enter = true })
			end, { desc = "eval (Debug)" })

			-- vim.keymap.set("n", "<leader>td", function()
			-- 	require("neotest").run.run({ strategy = "dap" })
			-- end, { desc = "Debug Nearest" })

			vim.keymap.set("n", "<leader>ds", ui.toggle, { desc = "Debug show ui toggle" })
			vim.keymap.set("n", "<F4>", dap.step_back)
			vim.keymap.set("n", "<F5>", dap.continue)
			vim.keymap.set("n", "<F17>", dap.terminate, { desc = "<S-F5> Stop Debug" })
			vim.keymap.set("n", "<F9>", dap.toggle_breakpoint)
			vim.keymap.set("n", "<F21>", function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "<S-F9> Stop Debug" })
			vim.keymap.set("n", "<F70>", dap.run_to_cursor) -- <C-F10>
			vim.keymap.set("n", "<leader>dc", dap.run_to_cursor) -- <C-F10>
			vim.keymap.set("n", "<F82>", dap.goto_) -- <C-S-F10>
			vim.keymap.set("n", "<leader>ds", dap.goto_) -- <C-S-F10>
			vim.keymap.set("n", "<F10>", dap.step_over)
			vim.keymap.set("n", "<F11>", dap.step_into)
			vim.keymap.set("n", "<F23>", dap.step_out)
			vim.keymap.set("n", "<F12>", dap.repl.toggle)

			dap.listeners.before.attach.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				ui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				ui.close()
			end
		end,
	},
}
