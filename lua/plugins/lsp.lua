return {
  -- Lua dev helpers
  { 'folke/neodev.nvim', opts = {} },

  -- LSP + Mason integration
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Mason installer
      { 'mason-org/mason.nvim', opts = {} },
      -- Mason <> lspconfig bridge
      {
        'mason-org/mason-lspconfig.nvim',
        -- ensure these servers are installed via Mason
        opts = {
          ensure_installed = { 'pylsp', 'pyright', 'lua_ls', 'rust_analyzer', 'tailwindcss', 'ts_ls' },
          },
        },
    },
    config = function()
      -- base client capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- setup Lua dev
      require('neodev').setup()

      -- bootstrap Mason and ensure our servers are installed
      require('mason').setup()
      require('mason-lspconfig').setup()

      local lspconfig = require 'lspconfig'

      -- JSON with schemastore
      lspconfig.jsonls.setup {
        capabilities = capabilities,
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      }

      -- TypeScript
      lspconfig.ts_ls.setup {
        capabilities = capabilities,
        root_dir = require('lspconfig.util').root_pattern '.git',
      }

      -- Lua (runtime, diagnostics, workspace)
      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        settings = {
          Lua = {
            completion = { callSnippet = 'Replace' },
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = { library = vim.api.nvim_get_runtime_file('', true) },
          },
        },
      }
    end,
  },

  -- optional bufferline styling
  {
    'akinsho/bufferline.nvim',
    optional = true,
    opts = function(_, opts)
      if (vim.g.colors_name or ''):find 'catppuccin' then
        opts.highlights = require('catppuccin.groups.integrations.bufferline').get()
      end
    end,
  },
}
