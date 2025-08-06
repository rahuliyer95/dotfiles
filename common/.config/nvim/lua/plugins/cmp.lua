local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

cmp.setup({
  formatting = {
    format = lspkind.cmp_format()
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.confirm({ select = true })
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end,
      { "i", "s" }
    ),
    ["<S-Tab>"] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end,
      { "i", "s" }
    ),
  }),
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = cmp.config.sources({
    { name = "buffer" },
    { name = "luasnip" },
    { name = "nvim_cmp" },
    { name = "nvim_lsp" },
    { name = "path" },
  }),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
    winhighlight = "Normal:CmpNormal,CursorLine:CmpSelect,FloatBorder:CmpBorder",
  },
})
