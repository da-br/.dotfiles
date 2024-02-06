return {
  {
    "ellisonleao/gruvbox.nvim",
    enabled = false,
  },

  {
    "folke/tokyonight.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    opts = { style = "night" },
  },

  {
    { "rose-pine/neovim", name = "rose-pine" },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}
