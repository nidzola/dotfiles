return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    default_format_opts = {
      lsp_fallback = true,
      timeout_ms = 3000,
    },
    formatters = {
      sqlfluff = {
        command = "sqlfluff",
        require_cwd = false,
      },
    },
    formatters_by_ft = {
      go = { "goimports", "gofmt" },
      sql = { "sqlfluff" },
    },
  },
}
