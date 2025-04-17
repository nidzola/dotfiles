return {
  "mfussenegger/nvim-dap",
  opts = function(_, opts)
    local dap = require("dap")

    dap.configurations.go = dap.configurations.go or {}
    -- table.insert(dap.configurations.go, {
    --   type = "go",
    --   name = "Debug with SOCKS5 Proxy",
    --   request = "launch",
    --   program = "${file}",
    --   env = {
    --     -- SOCKS5_PROXY = "192.168.50.201:1080", -- replace with your actual SOCKS5 proxy
    --     http_proxy = "socks5h://localhost:1080",
    --     https_proxy = "socks5h://localhost:1080",
    --   },
    -- })
    ----------------------------------------------------------------------------
    -- LISTEN FOR 'event_output' AND STRIP/REFORMAT LOG LINES
    ----------------------------------------------------------------------------

    -- Function to strip ANSI color codes
    local function strip_ansi_codes(s)
      -- Matches typical "\x1b[...m" sequences
      return s:gsub("\x1b%[%d*;?%d*;?%d*m", "")
    end

    -- Simple reformatter to mimic JetBrains-like logs:
    -- e.g. "2025-03-12 19:18:35 [INFO] rest of the message..."
    local function reformat_log_line(line)
      -- Match the format: "2025-03-13 [7:43PM] INFupdating subsections..."
      local date, time_bracket, level_msg = line:match("^%s*(%d%d%d%d%-%d%d%-%d%d)%s+(%[%d+:%d+%u%u%])%s*(%u%u%u.*)")

      if date and time_bracket and level_msg then
        -- Extract the level (first 3 characters) and the message (rest of the string)
        local level = level_msg:sub(1, 3)
        local msg = level_msg:sub(4)

        -- Format with proper spacing
        return string.format("%s %s [%s] %s", date, time_bracket, level, msg)
      end

      -- Fallback for other formats
      local time_12h, level, msg = line:match("^(%d+:%d+%u%u)%s+(%u%u%u)%s+(.*)")
      if time_12h then
        local date_prefix = os.date("%Y-%m-%d") -- e.g., "2025-03-12"
        return string.format("%s %s [%s] %s", date_prefix, time_12h, level, msg)
      end

      -- If we don't match any pattern, just return line as-is
      return line
    end

    -- 4) Register a "before" listener for all output events
    dap.listeners.before.event_output["strip-ansi"] = function(session, body)
      if body and body.output then
        local no_ansi = strip_ansi_codes(body.output)
        body.output = reformat_log_line(no_ansi)
      end
    end
  end,
}
