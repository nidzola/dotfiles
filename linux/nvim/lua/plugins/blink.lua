return {
  "saghen/blink.cmp",
  dependencies = {
    "onsails/lspkind.nvim",
  },
  version = "*",
  build = "cargo +nightly build --release",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
    },
    completion = {
      ghost_text = {
        enabled = false,
      },
      accept = { auto_brackets = { enabled = true } },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 250,
        treesitter_highlighting = true,
        window = { border = "rounded" },
      },

      menu = {
        border = "rounded",
        draw = {
          columns = { { "label", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
          components = {
            kind_icon = {
              text = function(item)
                local kind = require("lspkind").symbol_map[item.kind] or ""
                return kind
              end,
              highlight = "CmpItemKind",
            },
          },
        },
      },
    },

    keymap = {
      ["<Tab>"] = {
        LazyVim.cmp.map({ "ai_accept" }),
        "fallback",
      },
    },

    sources = {
      default = { "lsp", "path", "buffer" },
      -- disable snippets
      transform_items = function(_, items)
        return vim.tbl_filter(function(item)
          return item.kind ~= require("blink.cmp.types").CompletionItemKind.Snippet
        end, items)
      end,
      providers = {
        lsp = { enabled = true },
        path = { enabled = true },
        buffer = { enabled = true },

        -- disabled providers
        snippets = { enabled = false },
        copilot = { enabled = false },
        dadbod = { enabled = false },
      },
    },
  },
}
