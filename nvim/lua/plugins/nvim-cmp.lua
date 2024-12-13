local symbol_kinds = {
  Class = "",
  Color = "",
  Constant = "",
  Constructor = "",
  Enum = "",
  EnumMember = "",
  Event = "",
  Field = "",
  File = "",
  Folder = "",
  Function = "",
  Interface = "",
  Keyword = "",
  Method = "",
  Module = "",
  Operator = "",
  Property = "",
  Reference = "",
  Snippet = "",
  Struct = "",
  Text = "",
  TypeParameter = "",
  Unit = "",
  Value = "",
  Variable = "",
}

local function deprio(kind)
  return function(e1, e2)
    if e1:get_kind() == kind then
      return false
    end
    if e2:get_kind() == kind then
      return true
    end
  end
end

return {
  {
    "hrsh7th/nvim-cmp",
    enabled = false,
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "lukas-reineke/cmp-under-comparator",
      {
        "MattiasMTS/cmp-dbee",
        dependencies = {
          { "kndndrj/nvim-dbee" },
        },
        ft = "sql", -- optional but good to have
        opts = {}, -- needed
      },
    },
    version = false,
    event = "InsertEnter",
    config = function()
      local cmp = require("cmp")
      local types = require("cmp.types")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")

      -- Inside a snippet, use backspace to remove the placeholder.
      vim.keymap.set("s", "<BS>", "<C-O>s")

      ---@diagnostic disable: missing-fields
      cmp.setup({
        matching = {
          disallow_fuzzy_matching = false, -- Allow fuzzy matching
          disallow_exact_fuzzy_matching = false, -- Allow exact matches to be fuzzy-matched
          disallow_prefix_unmatching = false, -- Allow partial prefixes
          case_insensitive = true, -- Enable case-insensitive matching,
        },
        performance = {
          debounce = 10, -- default is 60ms
          throttle = 10, -- default is 30ms
          max_view_entries = 100, -- default is 300
        },
        -- Disable preselect. On enter, the first thing will be used if nothing
        -- is selected.
        preselect = cmp.PreselectMode.None,
        -- Add icons to the completion menu.
        formatting = {
          format = function(entry, vim_item)
            if vim_item == nil then
              return {}
            end
            if vim_item.kind then
              vim_item.kind = (symbol_kinds[vim_item.kind] or "") .. " " .. vim_item.kind
            end
            local function truncate(s, length)
              if #s > length then
                return s:sub(1, length) .. "..."
              end
              return s
            end
            -- Adding more details f.e module name in go etc.
            if entry.source.name == "nvim_lsp" then
              local detail = entry.completion_item.detail
              if detail then
                vim_item.menu = " " .. truncate(detail, 70)
              end
            end
            return vim_item
          end,
        },
        sorting = {
          comparators = {
            deprio(types.lsp.CompletionItemKind.Snippet),
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            require("cmp-under-comparator").under,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        window = {
          -- Make the completion menu bordered.
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        view = {
          -- Explicitly request documentation.
          docs = { auto_open = false },
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),
          -- Explicitly request completions.
          ["<C-Space>"] = cmp.mapping.complete(),
          ["/"] = cmp.mapping.close(),
          -- Overload tab to accept Copilot suggestions.
          ["<Tab>"] = cmp.mapping(function(fallback)
            local copilot = require("copilot.suggestion")

            if copilot.is_visible() then
              copilot.accept()
            elseif cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-d>"] = function()
            if cmp.visible_docs() then
              cmp.close_docs()
            else
              cmp.open_docs()
            end
          end,
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },
          { name = "buffer", priority = 900 },
          { name = "path", priority = 800 },
          { name = "cmp-dbee", priority = 700 },
        }),
      })
      ---@diagnostic enable: missing-fields

      -- Autopairs integration
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
}
