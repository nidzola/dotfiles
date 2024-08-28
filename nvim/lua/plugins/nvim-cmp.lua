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
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        config = function()
          local luasnip = require("luasnip")

          require("luasnip.loaders.from_vscode").lazy_load()

          -- HACK: Cancel the snippet session when leaving insert mode.
          vim.api.nvim_create_autocmd("ModeChanged", {
            group = vim.api.nvim_create_augroup("UnlinkSnippetOnModeChange", { clear = true }),
            pattern = { "s:n", "i:*" },
            callback = function(event)
              if luasnip.session and luasnip.session.current_nodes[event.buf] and not luasnip.session.jump_active then
                luasnip.unlink_current()
              end
            end,
          })
        end,
      },
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "lukas-reineke/cmp-under-comparator",
    },
    version = false,
    event = "InsertEnter",
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local types = require("cmp.types")

      -- Inside a snippet, use backspace to remove the placeholder.
      vim.keymap.set("s", "<BS>", "<C-O>s")

      ---@diagnostic disable: missing-fields
      cmp.setup({
        performance = {
          debounce = 15, -- default is 60ms
          throttle = 15, -- default is 30ms
        },
        -- Disable preselect. On enter, the first thing will be used if nothing
        -- is selected.
        preselect = cmp.PreselectMode.None,
        -- Add icons to the completion menu.
        formatting = {
          format = function(_, vim_item)
            vim_item.kind = (symbol_kinds[vim_item.kind] or "") .. "  " .. vim_item.kind
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
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
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
            behavior = cmp.ConfirmBehavior.Replace,
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
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.expand_or_locally_jumpable(-1) then
              luasnip.jump(-1)
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
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "crates" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
      ---@diagnostic enable: missing-fields
    end,
  },
}
