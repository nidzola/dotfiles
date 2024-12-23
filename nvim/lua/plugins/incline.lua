return {
  "b0o/incline.nvim",
  config = function()
    require("incline").setup({
      hide = {
        cursorline = true,
      },
      window = {
        padding = 0,
        margin = { horizontal = 0 },
      },
      render = function(props)
        local mini_icons = require("mini.icons")
        local modified = vim.bo[props.buf].modified

        local function get_filename()
          local filepath = vim.api.nvim_buf_get_name(props.buf)
          local relative_filepath = vim.fn.fnamemodify(filepath, ":~:.")
          local filename = vim.fn.fnamemodify(filepath, ":t")
          if filename == "" then
            filename = "[No Name]"
          end
          local ft_icon, ft_color = mini_icons.get("file", filename)
          return {
            " ",
            {
              modified and { relative_filepath .. " *", gui = "bold,italic", guifg = "#D8BA7E" }
                or { relative_filepath, gui = "bold", guifg = "#D8BA7E" },
            },
            " ",
            ft_icon and { ft_icon, " ", guibg = "none", group = ft_color } or "",
          }
        end
        local function get_diagnostic_label()
          local icons = { error = "", warn = "", info = "", hint = "" }
          local label = {}

          for severity, icon in pairs(icons) do
            local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
            if n > 0 then
              table.insert(label, { icon .. " " .. n .. " ", group = "DiagnosticSign" .. severity })
            end
          end
          if #label > 0 then
            table.insert(label, { "┊" })
          end
          return label
        end

        return {
          { get_diagnostic_label() },
          { get_filename() },
          group = props.focused and "ColorColumn" or "SignColumn",
        }
      end,
    })
  end,
  -- Optional: Lazy load Incline
  event = "VeryLazy",
}
