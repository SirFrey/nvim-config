return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local configs = require 'nvim-treesitter.configs'
      configs.setup {
        autotag = {
          enable = true,
        },
        ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'elixir', 'heex', 'javascript', 'html' },
        sync_install = false,
        highlight = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        }, indent = { enable = true },
      }
    end,
  },
  {
    'windwp/nvim-ts-autotag',
  }
}
