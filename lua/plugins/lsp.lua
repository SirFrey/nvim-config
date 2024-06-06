return {
  { "folke/neodev.nvim", opts = {} },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim' },
    config = function()
      local cmp_lsp = require('cmp_nvim_lsp')
      local capabilities = vim.tbl_deep_extend('force', {}, vim.lsp.protocol.make_client_capabilities(),
        cmp_lsp.default_capabilities())
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      require('mason').setup({
        ensure_installed = { "lua_ls", "rust_analyzer", "tailwindcss", "tsserver" },
      })
      require("neodev").setup({}) -- Lua development

      require('mason-lspconfig').setup_handlers {
        function(server_name) -- default handler (optional)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
          }
        end,
        ['jsonls'] = function()
          require('lspconfig').jsonls.setup {
            capabilities = capabilities,
            settings = {
              json = {
                schemas = require('schemastore').json.schemas {
                  extra = {
                    {
                      description = 'Shadcn UI components',
                      fileMatch = { 'components.json' },
                      name = 'components.json',
                      url = 'https://ui.shadcn.com/schema.json',
                    },
                  }
                },
                validate = { enable = true },
              }
            }
          }
        end,
        ['tailwindcss'] = function()
          require 'lspconfig'.tailwindcss.setup({
            settings = {
              tailwindCSS = {
                experimental = {
                  classRegex = {
                    { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                    { "cx\\(([^)]*)\\)",  "(?:'|\"|`)([^']*)(?:'|\"|`)" }
                  },
                },
              },
            },
          })
        end,
        ['tsserver'] = function()
          require('lspconfig').tsserver.setup({
            root_dir = require('lspconfig.util').root_pattern('.git')
          })
        end,
        ['lua_ls'] = function()
          require('lspconfig').lua_ls.setup {
            settings = {
              Lua = {
                completion = { callSnippet = "Replace" },
                runtime = {
                  version = 'LuaJIT'
                },
                diagnostics = {
                  globals = { 'vim' },
                },
                workspace = {
                  library = {
                    vim.env.VIMRUNTIME,
                  }
                }
              }
            }
          }
        end,
      }
      --
    end,
  },
}

-- ...
