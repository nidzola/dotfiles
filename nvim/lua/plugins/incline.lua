return {
  "b0o/incline.nvim",
  config = function()
    require("incline").setup({
      window = {
        padding = 0,
        margin = { horizontal = 0 },
      },
      render = function(props)
        local mini_icons = require("mini.icons")

        local function get_filename()
          local filepath = vim.api.nvim_buf_get_name(props.buf)
          local relative_filepath = vim.fn.fnamemodify(filepath, ":~:.")
          local filename = vim.fn.fnamemodify(filepath, ":t")
          if filename == "" then
            filename = "[No Name]"
          end
          local ft_icon, ft_color = mini_icons.get("file", filename)
          local modified = vim.bo[props.buf].modified
          return {
            " ",
            { relative_filepath, gui = modified and "bold,italic" or "bold" },
            " ",
            ft_icon and { ft_icon, " ", guibg = "none", group = ft_color } or "",
          }
        end

        return {
          { get_filename() },
          group = props.focused and "ColorColumn" or "SignColumn",
        }
      end,
    })
  end,
  -- Optional: Lazy load Incline
  event = "VeryLazy",
}
