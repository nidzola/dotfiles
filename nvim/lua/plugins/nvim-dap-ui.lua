return {
  "rcarriga/nvim-dap-ui",
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    dapui.setup()

    vim.api.nvim_set_hl(0, "DapUIVariable", { fg = "#7fbbb3", bg = "#1b2b34", bold = true })
    vim.api.nvim_set_hl(0, "DapUIValue", { fg = "#d699b6", bg = "#1b2b34" })
    vim.api.nvim_set_hl(0, "DapUIScope", { fg = "#7fbbb3", bg = "#1b2b34", bold = true })
    vim.api.nvim_set_hl(0, "DapUIType", { fg = "#a3be8c", bg = "#1b2b34", italic = true })

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
      -- removing the type from the left side
      local render = require("dapui.config").render
      render.max_type_length = (render.max_type_length == nil) and 0 or nil
    end
  end,
}
