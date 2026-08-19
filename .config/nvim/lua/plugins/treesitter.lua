return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.install").compilers = { "clang", "gcc" }
        require("nvim-treesitter.install").prefer_git = true

        -- nvim-treesitter main branch uses a new API without configs.setup()
        vim.treesitter.language.register("markdown", "markdown")

        require("nvim-treesitter").setup({
            -- A list of parser names, or "all"
            ensure_installed = {
                "vimdoc",
                "c",
                "cpp",
                "lua",
                "python",
                "go",
                "gomod",
                "gowork",
                "gosum",
                "bash",
                "html",
                "css",
                "scss",
                "json",
                "xml",
                "markdown",
                "javascript",
                "typescript",
                "tsx",
                "svelte",
                "yaml",
                "toml",
                "dart",
            },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            auto_install = true,
        })

        -- Highlighting and indent are enabled by default on main branch via vim.treesitter
        -- Additional regex highlighting for markdown
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "markdown",
            callback = function()
                vim.bo.syntax = "on"
            end,
        })
    end,
}
