return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup {
        pickers = {
          find_files = {
            follow = true,
          },
        },
        defaults = {
          file_ignore_patterns = { 'node_modules', '.git' },
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
            '-L',
          },
          find_command = { 'rg', '--files', '--hidden', '-L' },
        },
      }
    end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    config = function()
      require('telescope').load_extension 'fzy_native'
      require("telescope").load_extension 'noice'
    end
  },
  { 'nvim-telescope/telescope-fzy-native.nvim' },
}
