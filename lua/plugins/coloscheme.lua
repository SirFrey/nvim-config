return {
  {
    'catppuccin',
    opts = {
      transparent_background = true,
      --   integations = {
      --     lsp_trouble = true,
      --     mason = true,
      --     markdown = true,
      --     mini = true,
      --     telescope = false,
      --     treesitter = true,
      --     treesitter_context = true,
      --   },
    },
  },
  {
    'LazyVim/LazyVim',
    opts = {
      colorscheme = 'catppuccin-mocha',
    },
  },
}
