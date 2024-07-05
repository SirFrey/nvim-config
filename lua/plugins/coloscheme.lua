return {
  {
    'catppuccin/nvim',
    lazy = true,
    name = 'catppuccin',
    opts = {
      transparent_background = true,
      integations = {
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        telescope = false,
        treesitter = true,
        treesitter_context = true,
      },
    },
  },
}
