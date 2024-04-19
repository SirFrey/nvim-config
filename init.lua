require('config.options')
--[[
  -https://learnxinyminutes.com/docs/lua/
 ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure plugins ]]
require('lazy').setup('plugins')
require('config.keymaps')

-- load vim file to load some scripts
local vimrc = vim.fn.stdpath 'config' .. '/lua/config/vimrc.vim'
vim.cmd.source(vimrc)
