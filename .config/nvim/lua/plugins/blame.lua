return {
    {
        "FabijanZulj/blame.nvim",
        config = function()
            require("blame").setup()
            vim.keymap.set("n", "<leader>gb", "<cmd>BlameToggle window<CR>", { desc = "Blame show ui" })
            vim.keymap.set("n", "<leader>gB", "<cmd>BlameToggle virtual<CR>", { desc = "Blame show inline" })
        end
    }
}
