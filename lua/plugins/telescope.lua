return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local telescope = require 'telescope'
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
      telescope.load_extension 'chezmoi'
      vim.keymap.set('n', '<leader>cz', telescope.extensions.chezmoi.find_files, {})

      -- You can also search a specific target directory and override arguments
      -- Here is an example with the default args
      vim.keymap.set('n', '<leader>fc', function()
        telescope.extensions.chezmoi.find_files {
          targets = vim.fn.stdpath 'config',
          -- This overrides the default arguments used with 'chezmoi list'
          args = {
            '--path-style',
            'absolute',
            '--include',
            'files',
            '--exclude',
            'externals',
          },
        }
      end, {})
    end,
  },
}
