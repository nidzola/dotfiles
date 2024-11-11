return {
  "neovim/nvim-lspconfig",
  opts = {
    -- disable LSP word highlight under the cursor
    document_highlight = false,
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
            codelenses = {
              gc_details = true,
              regenerate_cgo = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            deepCompletion = true,
            staticcheck = true,
          },
        }
        -- -- FIXME: workaround for https://github.com/neovim/neovim/issues/28058
        -- for _, v in pairs(opts) do
        --   if type(v) == "table" and v.workspace then
        --     v.workspace.didChangeWatchedFiles = {
        --       dynamicRegistration = false,
        --       relativePatternSupport = false,
        --     }
        --   end
        -- end
      end,
    },
  },
}
