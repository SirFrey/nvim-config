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
      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = { "lua_ls", "rust_analyzer", "tailwindcss", "tsserver", "cssls", "astro", "jsonls", "oxlint" },
      })
      require("neodev").setup({}) -- Lua development
      local util = require("lspconfig.util")
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
                format = { enable = true },
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
        ['mdx_analyzer'] = function()
          local function get_typescript_server_path(root_dir)
            local project_root = util.find_node_modules_ancestor(root_dir)
            return project_root and (util.path.join(project_root, "node_modules", "typescript", "lib")) or ""
          end
          require 'lspconfig'.mdx_analyzer.setup {
            capabilities = capabilities,
            filetypes = { "mdx", "markdown.mdx" },
            init_options = {
              typescript = {},
            },
            on_new_config = function(new_config, new_root_dir)
              if vim.tbl_get(new_config.init_options, "typescript") and not new_config.init_options.typescript.tsdk then
                -- LATER: Support custom typescript lib
                --
                -- local tsdk = require("util.typescript").get_tsdk_from_config() or get_typescript_server_path(new_root_dir)
                new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
              end
            end,
          }
        end,
      }
      --
    end,
  },
}

-- ...
