return {
  "ibhagwan/fzf-lua",
  opts = function(_, opts)
    return vim.tbl_deep_extend("force", opts, {
      winopts = {
        preview = {
          vertical = "down:65%",
          layout = "vertical",
        },
        backdrop = 100,
      },
      files = {
        cwd_header = true,
        git_icons = false,
        file_icons = true,
      },
      lsp = {
        code_actions = {
          -- was to slow, so disabled
          previewer = false,
        },
      },
    })
  end,
}
