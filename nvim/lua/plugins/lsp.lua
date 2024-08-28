return {
  "neovim/nvim-lspconfig",
  opts = {
    setup = {
      tsserver = function(_, opts)
        opts.init_options = {
          preferences = {
            importModuleSpecifierPreference = "non-relative",
          },
        }
      end,
      gopls = function(_, opts)
        opts.settings = {
          gopls = {
            hints = opts.settings.gopls.hints,
            analyses = {
              unusedparams = true,
            },
          },
          completion = {
            insertPlaceholders = false,
          },
        }
        -- FIXME: workaround for https://github.com/neovim/neovim/issues/28058
        for _, v in pairs(opts) do
          if type(v) == "table" and v.workspace then
            v.workspace.didChangeWatchedFiles = {
              dynamicRegistration = false,
              relativePatternSupport = false,
            }
          end
        end
      end,
    },
  },
}
