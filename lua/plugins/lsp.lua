return {
  { 'williamboman/mason.nvim', config = true },
  {
    'williamboman/mason-lspconfig.nvim',
    opts = {
      ensure_installed = { "lua_ls", "rust_analyzer", "tailwindcss", "tsserver" },
    }
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local _border = "single"
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
          border = _border
        }
      )

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
          border = _border
        }
      )

      vim.diagnostic.config {
        float = { border = _border }
      }
      require('mason-lspconfig').setup_handlers {
        function(server_name) -- default handler (optional)
          require('lspconfig')[server_name].setup {}
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        -- ['rust_analyzer'] = function()
        --   require('rust-tools').setup {}
        -- end,
        ['tailwindcss'] = function()
          require('lspconfig').tailwindcss.setup {
          }
        end,
        ['lua_ls'] = function()
          require('lspconfig').lua_ls.setup {
            capabilities = lsp_capabilities,
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
            } }
        end,
      }
      --
    end,
  },
}

-- ...
