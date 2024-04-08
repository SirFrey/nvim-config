return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },

  -- Autocompletion
  {
    'L3MON4D3/LuaSnip',
    lazy = false
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
      -- This is where all the LSP shenanigans will live
      local lsp_zero = require 'lsp-zero'
      lsp_zero.extend_lspconfig()
      --- if you want to know more about lsp-zero and mason.nvim
      --- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps { buffer = bufnr }
      end)
      require('mason-lspconfig').setup {
        ensure_installed = { 'vimls', 'astro', 'clangd', 'lua_ls', 'tailwindcss', 'cssls', 'emmet_language_server', 'cssmodules_ls', 'html', 'tsserver' },
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            -- (Optional) Configure lua language server for neovim
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
          end,
        },
      }
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function()
      -- Here is where you configure the autocompletion settings.
      local lsp_zero = require 'lsp-zero'
      lsp_zero.extend_cmp()

      -- And you can configure cmp even more, if you want to.
      local tailwindcss_colors = require 'tailwindcss-colorizer-cmp'

      local cmp_formatter = function(entry, vim_item)
        -- vim_item as processed by tailwindcss-colorizer-cmp
        vim_item = tailwindcss_colors.formatter(entry, vim_item)

        -- change menu (name of source)
        vim_item.menu = ({
          nvim_lsp = '[LSP]',
          buffer = '[Buffer]',
          path = '[Path]',
          emoji = '[Emoji]',
          luasnip = '[LuaSnip]',
          vsnip = '[VSCode Snippet]',
          calc = '[Calc]',
          spell = '[Spell]',
        })[entry.source.name]
        return vim_item
      end
      local cmp = require 'cmp'
      local cmp_action = lsp_zero.cmp_action()
      require('luasnip.loaders.from_vscode').lazy_load()
      cmp.setup {
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        },
        window = {
          completion = {
            border = 'rounded',
          },
        },
        formatting = {
          fields = { 'abbr', 'kind', 'menu' },
          format = cmp_formatter,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),
          ['<CR>'] = cmp.mapping.confirm { select = true },
        },
      }
    end,
  },
}
