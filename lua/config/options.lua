vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.autoformat = false

vim.opt.laststatus = 3

-- [[ Setting options ]]
-- See `:help vim.o`
vim.o.hlsearch = false

vim.opt.swapfile = false
vim.opt.backup = false

-- Set the undo directory in a cross-platform way
-- Get the user's home directory in a cross-platform way
local home = vim.fn.has("win32") == 1 and os.getenv("USERPROFILE") or os.getenv("HOME")

-- Check if the home directory was found
if not home then
  print("Error: Could not determine home directory.")
  return
end

-- Define the undo directory path using a cross-platform path joiner
local undodir = vim.fs.joinpath(home, ".vim", "undodir")

-- Set the undodir option
vim.opt.undodir = undodir

vim.opt.undofile = true

vim.opt.scrolloff = 8
vim.opt.isfname:append '@-@'

vim.opt.updatetime = 50
-- Make line numbers default
vim.wo.number = true

-- Relative numbers
vim.wo.relativenumber = true
-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.signcolumn = 'yes'

vim.cmd 'autocmd BufRead,BufNewFile *.mdx set filetype=mdx'
-- colors for floating windows
--
-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.diagnostic.config { virtual_text = true }
