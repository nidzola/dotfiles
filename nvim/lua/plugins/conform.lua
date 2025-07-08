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
      -- eslint = {
      --   command = "npx",
      --   args = { "eslint", "--fix", "--stdin", "--stdin-filename", "$FILENAME" },
      --   stdin = true,
      -- },
    },
    formatters_by_ft = {
      go = { "goimports", "gofmt" },
      sql = { "sqlfluff" },
      lua = { "stylua" },
      graphql = { "eslint_d" },
      -- javascript = { "prettier" },
      -- typescript = { "prettier" },
      -- typescriptreact = { "prettier" },
      -- javascriptreact = { "prettier" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      javascriptreact = { "eslint_d" },
    },
  },
}
