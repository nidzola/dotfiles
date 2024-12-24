return {
  "rebelot/heirline.nvim",
  enabled = true,
  config = function()
    local heirline = require("heirline")

    -- Everforest color palette
    local colors = {
      bg = "#2b3339",
      fg = "#d3c6aa",
      green = "#a7c080",
      red = "#e67e80",
      yellow = "#dbbc7f",
      blue = "#7fbbb3",
      magenta = "#d699b6",
      cyan = "#83c092",
      gray = "#868d80",
      bg_dim = "#1e2326",
      bg0 = "#272e33",
      bg1 = "#2e383c",
      bg2 = "#374145",
      bg3 = "#414b50",
      bg4 = "#495156",
      bg5 = "#4f5b58",
      bg_visual = "#4c3743",
      bg_red = "#493b40",
      bg_green = "#3c4841",
      bg_blue = "#384b55",
      bg_yellow = "#45443c",
    }

    -- Define Mode component
    local mode = {
      provider = function()
        local mode_names = {
          n = "NORMAL",
          i = "INSERT",
          v = "VISUAL",
          V = "V-LINE",
          [""] = "V-BLOCK", -- This is for visual block mode
          c = "COMMAND",
          R = "REPLACE",
          t = "TERMINAL",
        }

        return " " .. (mode_names[vim.fn.mode()] or "Unknown") .. " "
      end,
      hl = function()
        local mode_color = {
          n = colors.green, -- Normal
          i = colors.fg, -- Insert
          v = colors.red, -- Visual
          V = colors.red,
          [""] = colors.red,
          c = colors.yellow, -- Command
          s = colors.green, -- Select
          S = colors.green,
          [""] = colors.green,
          R = colors.magenta, -- Replace
          r = colors.magenta,
        }
        return { fg = colors.bg, bg = mode_color[vim.fn.mode()] or colors.fg, bold = true }
      end,
    }

    -- Define Git Branch component
    local git_branch = {
      provider = function()
        local branch = vim.fn.system("git branch --show-current 2>/dev/null"):gsub("\n", "")
        if branch and #branch > 0 then
          return "  " .. branch .. " "
        else
          return ""
        end
      end,
      hl = { fg = colors.yellow, bg = colors.bg2, bold = true },
    }

    local dap_status = {
      provider = function()
        local dap_exists = pcall(require, "dap")
        if not dap_exists then
          return ""
        end

        local status = require("dap").status()
        if status ~= "" then
          return "  " .. status
        end
      end,
      hl = { bg = colors.bg2, fg = colors.red, bold = true },
    }

    local copilot_icon = {
      provider = function()
        local copilot_exists = pcall(require, "copilot")
        if copilot_exists and require("copilot.client").buf_is_attached() then
          return "   "
        end
        return ""
      end,
      hl = { bg = colors.bg2, fg = colors.yellow, bold = true },
    }

    local char_count = {
      provider = function()
        if vim.fn.mode():find("[Vv]") == nil then
          return ""
        end

        local starts = vim.fn.line("v")
        local ends = vim.fn.line(".")
        local count = starts <= ends and ends - starts + 1 or starts - ends + 1
        local wc = vim.fn.wordcount()
        return count .. ":" .. wc["visual_chars"]
      end,
      hl = { bg = colors.bg2, fg = colors.yellow, bold = true },
    }

    local statusline = {
      -- Left side
      mode,
      git_branch,
      { provider = "%=" }, -- Spacer

      -- Right side
      dap_status,
      char_count,
      copilot_icon,
    }

    -- Setup Heirline
    heirline.setup({
      statusline = statusline,
    })
  end,
}
