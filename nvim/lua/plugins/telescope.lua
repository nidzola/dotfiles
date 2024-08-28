return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    "nvim-lua/plenary.nvim",
  },
  opts = function(_, _)
    return {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden", -- Include hidden files
          "--fixed-strings",
        },
        wrap_results = true,
        layout_strategy = "vertical",
        path_display = { "smart" },
        sorting_strategy = "ascending",
        layout_config = {
          vertical = {
            height = vim.o.lines, -- maximally available lines
            preview_height = 0.6, -- 60% of available lines
            prompt_position = "top",
            mirror = true,
          },
        },
      },
      pickers = {
        live_grep = {
          debounce = 200,
          path_display = { "shorten" },
        },
        buffers = {
          theme = "ivy",
        },
        find_files = {
          previewer = false,
          debounce = 200,
          file_ignore_patterns = { "node_modules", ".git", ".venv" },
          hidden = true,
        },
        lsp_document_symbols = {
          show_line = true,
        },
        lsp_dynamic_workspace_symbols = {
          show_line = true,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
      },
      require("telescope").load_extension("fzf"),
    }
  end,
}
