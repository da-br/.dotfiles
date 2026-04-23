return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.install").compilers = { "clang", "gcc" }
        require("nvim-treesitter.install").prefer_git = false
        require("nvim-treesitter.configs").setup({
            -- A list of parser names, or "all"
            ensure_installed = {
                "vimdoc",
                "c",
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
            },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
            auto_install = true,

            indent = {
                enable = true,
                disable = { "python" },
            },

            highlight = {
                -- `false` will disable the whole extension
                enable = true,

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = { "markdown" },
            },
        })
    end,
}
