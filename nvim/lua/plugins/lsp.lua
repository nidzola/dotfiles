return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      underline = true,
      virtual_text = false,
      signs = true,
      update_in_insert = false,
    },
    -- kill inlay hints
    inlay_hints = { enabled = false },
    servers = {
      vtsls = {},
      graphql = {},
      gopls = {},
      postgres_lsp = {}, -- <== Add this line
    },
    setup = {
      vtsls = function(_, opts)
        -- opts.cmd = { "ssh", "nidzola@100.103.29.125", "node_modules/.bin/vtsls", "--stdio" }
        opts.settings = {
          javascript = {
            preferences = {
              importModuleSpecifier = "non-relative",
            },
          },
          typescript = {
            preferences = {
              importModuleSpecifier = "non-relative",
            },
          },
        }
      end,
      graphql = function(_, opts)
        -- opts.cmd = { "ssh", "nidzola@100.103.29.125", "node_modules/.bin/graphql-lsp", "server", "--method=stream" }
        opts.root_dir = function(fname)
          return vim.fn.getcwd() -- or any other logic to determine the root directory
        end
      end,
      gopls = function(_, opts)
        opts.settings = {
          gopls = {
            hints = opts.settings.gopls.hints,
            analyses = {
              unusedparams = true,
              fieldalignment = true,
              nilness = true,
              shadow = true,
              unusedwrite = true,
            },
            deepCompletion = true,
            staticcheck = true,
            buildFlags = { "-tags=test,wireinject,tools,integration" },
          },
        }
      end,
      postgres_lsp = function(_, opts)
        opts.filetypes = { "sql" }
        opts.root_dir = require("lspconfig.util").root_pattern("postgrestools.jsonc", ".git")
      end,
    },
  },
}
