-- Whitespace and indentation guides.
return {
  "lukas-reineke/indent-blankline.nvim",
  -- For setting shiftwidth and tabstop automatically.
  dependencies = "tpope/vim-sleuth",
  event = { "BufReadPost", "BufNewFile" },
}
