return {
  {
    'mrcjkb/rustaceanvim',
    version = '^3',
    lazy = false,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("typescript-tools").setup {
        settings = {
          expose_as_code_action = { 'fix_all', 'add_missing_imports', 'organize_imports' },
        }
      }
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim' },
    config = function()
      require('mason').setup({
        ensure_installed = { "lua_ls", "rust_analyzer", "tailwindcss", "tsserver" },
      })
      require('mason-lspconfig').setup_handlers {
        -- Next, you can provide a dedicated handler for specific servers.
        ['tailwindcss'] = function()
          require('lspconfig').tailwindcss.setup {
          }
        end,
        ['jsonls'] = function()
          require('lspconfig').jsonls.setup {
            settings = {
              json = {
                schemas = require('schemastore').json.schemas(),
                validate = { enable = true },
              },
            },
          }
        end,
        ['lua_ls'] = function()
          require('lspconfig').lua_ls.setup {
            settings = {
              Lua = {
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
