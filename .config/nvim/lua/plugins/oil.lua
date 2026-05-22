function _G.get_oil_winbar()
    local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
    local dir = require("oil").get_current_dir(bufnr)
    if dir then
        return vim.fn.fnamemodify(dir, ":~")
    else
        -- If there is no current directory (e.g. over ssh), just show the buffer name
        return vim.api.nvim_buf_get_name(0)
    end
end

return {
    {
        "stevearc/oil.nvim",
        dependencies = { 
            { "nvim-tree/nvim-web-devicons" },
            { "echasnovski/mini.icons", opts = {} },
            {
              "malewicz1337/oil-git.nvim",
              dependencies = { "stevearc/oil.nvim" },
              opts = {
                show_file_highlights = true,
                show_directory_highlights = false,
                show_ignored_files = true,
              },
            }
        },
        config = function()
            require("oil").setup({
                columns = { "icon" },
                use_default_keymaps = true,
                keymaps = {
                    ["<C-h>"] = false,
                    ["<M-h>"] = "actions.select_split",
                    ["g?"] = { "actions.show_help", mode = "n" },
                    ["<CR>"] = "actions.select",
                    ["<C-t>"] = { "actions.select", opts = { tab = true } },
                    ["<C-p>"] = "actions.preview",
                    ["<C-c>"] = { "actions.close", mode = "n" },
                    ["-"] = { "actions.parent", mode = "n" },
                    ["_"] = { "actions.open_cwd", mode = "n" },
                    ["`"] = { "actions.cd", mode = "n" },
                    ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
                },
                view_options = {
                    show_hidden = true,
                },
                win_options = {
                    winbar = "%!v:lua.get_oil_winbar()",
                },
                buf_options = {
                    buflisted = false,
                    bufhidden = "hide",
                },
            })
            vim.keymap.set("n", "<leader>fe", "<CMD>Oil<CR>", { desc = "Open file explorer" })
        end,
    },
}
