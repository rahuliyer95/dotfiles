require("lsp_signature").setup({
  bind = true,
  handler_opts = {
    border = "rounded"
  },
  hint_prefix = "",
  hint_inline = function() return true end,
  transparency = 100,
})
