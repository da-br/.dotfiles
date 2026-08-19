return {
    'nvim-flutter/flutter-tools.nvim',
    lazy = true,
    ft = "dart",
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
        'mfussenegger/nvim-dap', -- optional for debugger support
    },
    config = function()
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require("flutter-tools").setup({
            debugger = {
                enabled = true,
                run_via_dap = true,
            },
            widget_guides = {
                enabled = true,
            },
            closing_tags = {
                enabled = true,
                highlight = "Comment",
                prefix = "// ",
            },
            lsp = {
                capabilities = capabilities,
                settings = {
                    showTodos = true,
                    completeFunctionCalls = true,
                    renameFilesWithClasses = "prompt",
                    enableSnippets = true,
                },
            },
        })

        vim.keymap.set("n", "<leader>Fr", "<cmd>FlutterRun<cr>", { desc = "Flutter run" })
        vim.keymap.set("n", "<leader>FR", "<cmd>FlutterRestart<cr>", { desc = "Flutter restart" })
        vim.keymap.set("n", "<leader>Fh", "<cmd>FlutterReload<cr>", { desc = "Flutter hot reload" })
        vim.keymap.set("n", "<leader>Fq", "<cmd>FlutterQuit<cr>", { desc = "Flutter quit" })
        vim.keymap.set("n", "<leader>Fd", "<cmd>FlutterDevices<cr>", { desc = "Flutter devices" })
        vim.keymap.set("n", "<leader>Fe", "<cmd>FlutterEmulators<cr>", { desc = "Flutter emulators" })
        vim.keymap.set("n", "<leader>Fo", "<cmd>FlutterOutlineToggle<cr>", { desc = "Flutter outline toggle" })
        vim.keymap.set("n", "<leader>Fs", "<cmd>FlutterDevTools<cr>", { desc = "Flutter dev tools" })
        vim.keymap.set("n", "<leader>Fl", "<cmd>FlutterLogClear<cr>", { desc = "Flutter clear log" })
    end,
}
