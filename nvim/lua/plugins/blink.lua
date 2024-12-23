return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      accept = { auto_brackets = { enabled = false } },
      ghost_text = {
        enabled = false,
      },
      menu = {
        draw = {
          columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
        },
      },
    },
    sources = {
      default = { "lsp", "buffer", "path" },
    },
    keymap = {
      preset = "enter",
      ["<Tab>"] = {
        LazyVim.cmp.map({ "ai_accept" }),
        "fallback",
      },
    },
  },
}
