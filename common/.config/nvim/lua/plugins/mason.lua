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

require("null-ls").setup({
  sources = {},
})

-- Setup all available servers
require("lsp-auto-setup").setup({
  server_config = {
    basedpyright = function(default_config)
      return {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        settings = {
          basedpyright = {
            -- we are using Ruff for this
            analysis = {
              ignore = { "*" }
            },
            disableOrganizeImports = true,
          },
        },
      }
    end,
    bashls = function(default_config)
      return {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        settings = {
          bashIde = {
            shfmt = {
              binaryNextLine = true,
              caseIndent = true,
              simplifyCode = true,
              spaceRedirects = true,
            },
          },
        },
      }
    end,
  }
})

-- Show diagnostic information on the current line as virtual text
vim.diagnostic.config({
  virtual_text = {
    current_line = true
  }
})

-- Format document
vim.keymap.set(
  "n",
  "<leader>f",
  function()
    vim.lsp.buf.code_action({
      context = { only = { "source.organizeImports" } },
      apply = true,
    })
    vim.lsp.buf.format()
  end,
  { desc = "Format Document" }
)
