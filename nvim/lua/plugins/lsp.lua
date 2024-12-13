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
