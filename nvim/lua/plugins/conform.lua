return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    default_format_opts = {
      lsp_fallback = true,
      timeout_ms = 1500, -- 3 second default is too long.
    },
    formatters_by_ft = {
      go = { "goimports", "gofmt" },
    },
  },
}
