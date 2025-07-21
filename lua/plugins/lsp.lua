return {
  -- Lua dev helpers
  { 'folke/neodev.nvim', opts = {} },

  -- LSP + Mason integration
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      -- Mason installer
      { 'mason-org/mason.nvim', opts = {} },
      'neovim/nvim-lspconfig',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      -- Mason <> lspconfig bridge
    },
    config = function()
      require('mason-lspconfig').setup {
        -- ensure these servers are installed
        ensure_installed = { 'pylsp', 'pyright', 'lua_ls', 'rust_analyzer', 'tailwindcss', 'ts_ls', 'vtsls' },
        automatic_enable = {
          exclude = {
            -- handled these by lspconfig below
            'jsonls',
            'ts_ls',
            'tailwindcss',
            'lua_ls',
          },
        },
      }
      local mason_tool_installer = require 'mason-tool-installer'

      mason_tool_installer.setup {
        ensure_installed = {
          'prettierd', -- prettier formatter
          'stylua', -- lua formatter
          'isort', -- python formatter
          'black', -- python formatter
          'pylint', -- python linter
          'eslint_d', -- js linter
        },
      }
      -- base client capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- setup Lua dev
      require('neodev').setup()

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
      --  lspconfig.ts_ls.setup {
      --    capabilities = capabilities,
      --    root_dir = function(...)
      --      return require('lspconfig.util').root_pattern '.git'(...)
      --    end,
      --  }
      -- Tailwind CSS
      lspconfig.tailwindcss.setup {
        capabilities = capabilities,
        root_dir = function(...)
          return require('lspconfig.util').root_pattern '.git'(...)
        end,
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
