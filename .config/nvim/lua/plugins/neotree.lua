return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
        { "<leader>fe", "<cmd>Neotree toggle<cr>", desc = "Open file explorer" },
    },
    opts = {
        close_if_last_window = true,
        window = {
            width = 32,
            mappings = {
                ["<space>"] = "none",
            },
        },
        filesystem = {
            hijack_netrw_behavior = "open_current",
            follow_current_file = { enabled = true },
            use_libuv_file_watcher = true,
            filtered_items = {
                visible = true,
                hide_dotfiles = false,
                hide_gitignored = false,
            },
        },
        default_component_configs = {
            git_status = {
                symbols = {
                    added = "✚",
                    modified = "",
                    deleted = "✖",
                    renamed = "󰁕",
                    untracked = "",
                    ignored = "",
                    unstaged = "󰄱",
                    staged = "",
                    conflict = "",
                },
            },
        },
    },
}
