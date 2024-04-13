return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = true,
  opts = {
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { '' },
      lualine_c = { 'filename' },
      lualine_x = { 'fileformat', '' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' }
    },
    inactive_sections = {
      lualine_a = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {}
    },
  }
}
