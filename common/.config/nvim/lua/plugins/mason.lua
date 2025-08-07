require("mason").setup({
  npm = {
    use_pnpm = true,
  },
  pip = {
    use_python3_host_prog = true,
  },
})

require("mason-lspconfig").setup({
  ensure_installed = { "bashls" },
})

-- Configure LSP servers
require("mason-null-ls").setup({
  ensure_installed = {},
  handlers = {},
})

-- null-ls
local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.mypy
  },
})

-- Setup all available servers
require("lsp-auto-setup").setup({})

-- Show diagnostic information on the current line as virtual text
vim.diagnostic.config({
  virtual_text = {
    current_line = true
  }
})
