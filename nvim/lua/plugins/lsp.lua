return {
  "neovim/nvim-lspconfig",
  opts = {
    -- kill inlay hints
    inlay_hints = { enabled = false },
    setup = {
      vtsls = function(_, opts)
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
          },
        }
      end,
    },
  },
}
