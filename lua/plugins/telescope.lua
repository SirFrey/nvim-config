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
          file_ignore_patterns = { '.git' },
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
  }
}
