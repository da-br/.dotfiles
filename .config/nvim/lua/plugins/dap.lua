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
			"mfussenegger/nvim-dap-python",
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			{ "williamboman/mason.nvim", opts = { ensure_installed = { "delve", "debugpy" } } },
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			local dap = require("dap")
			local ui = require("dapui")

			local function project_python()
				if vim.fn.executable("./.venv/bin/python") == 1 then
					return "./.venv/bin/python"
				end
				return "python3"
			end

			local debugpy_python = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
			if vim.fn.executable(debugpy_python) ~= 1 then
				debugpy_python = project_python()
			end

			require("dapui").setup()
			require("dap-python").setup(debugpy_python)
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

			table.insert(dap.configurations.python, {
				type = "python",
				request = "launch",
				name = "Python: Current file",
				program = "${file}",
				pythonPath = project_python,
				console = "integratedTerminal",
				justMyCode = true,
			})

			table.insert(dap.configurations.python, {
				type = "python",
				request = "launch",
				name = "Python: Module",
				module = function()
					return vim.fn.input("Module name: ")
				end,
				pythonPath = project_python,
				console = "integratedTerminal",
				justMyCode = true,
			})

			dap.adapters.lldb = {
				type = "executable",
				command = "/usr/bin/lldb-dap-18", -- adjust as needed, must be absolute path
				name = "lldb",
			}

		dap.configurations.zig = {
			{
				name = "Launch",
				type = "lldb",
				request = "launch",
				program = "${workspaceFolder}/zig-out/bin/${workspaceFolderBasename}",
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
			},
			-- {
			-- 	name = "Launch",
			-- 	type = "lldb",
			-- 	request = "launch",
			-- 	program = function()
			-- 		return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/zig-out/bin/", "file")
			-- 	end,
			-- 	cwd = "${workspaceFolder}",
			-- 	stopOnEntry = false,
			-- 	args = {},
			--
			-- 	-- 💀
			-- 	-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
			-- 	--
			-- 	--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
			-- 	--
			-- 	-- Otherwise you might get the following error:
			-- 	--
			-- 	--    Error on launch: Failed to attach to the target process
			-- 	--
			-- 	-- But you should be aware of the implications:
			-- 	-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
			-- 	-- runInTerminal = false,
			-- },
		}

		local c_cpp_launch = {
			{
				name = "Launch executable",
				type = "lldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = get_arguments,
			},
			{
				name = "Launch PlatformIO firmware",
				type = "lldb",
				request = "launch",
				program = function()
					-- PlatformIO builds to .pio/build/<env>/firmware.elf
					local pio_elf = vim.fn.glob(vim.fn.getcwd() .. "/.pio/build/*/firmware.elf", false, true)
					if #pio_elf == 1 then
						return pio_elf[1]
					end
					return vim.fn.input("Path to firmware ELF: ", vim.fn.getcwd() .. "/.pio/build/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
			},
		}
		dap.configurations.c = c_cpp_launch
		dap.configurations.cpp = c_cpp_launch

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
