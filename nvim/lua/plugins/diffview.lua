return {
  "sindrets/diffview.nvim",
  opts = {
    enhanced_diff_hl = true,
    view = {
      diff_view = {
        layout = "diff2_horizontal",
      },
      file_history_view = {
        layout = "diff2_horizontal",
      },
      merge_tool = {
        layout = "diff3_mixed",
      },
    },
  },
  keys = {
    { "<Leader>gd", "<CMD>DiffviewOpen<CR>", desc = "Diff worktree" },
    { "<Leader>gf", "<CMD>DiffviewFileHistory<CR>", desc = "Diffview file history" },
    {
      "<Leader>gD",
      function()
        local target = vim.fn.input("Target branch name: ")
        local status = vim.system({ "git", "merge-base", "HEAD", target }, { text = true }):wait()

        if status.code ~= 0 then
          error(string.format("Error code %d while running git merge-base. STDERR: %s", status.code, status.stderr))
        end

        vim.cmd.DiffviewOpen(status.stdout)
      end,
      desc = "Diff from common ancestor of target branch and current branch",
    },
  },
}
