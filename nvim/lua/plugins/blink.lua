return {
  "saghen/blink.cmp",
  opts = {
    completion = {
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
