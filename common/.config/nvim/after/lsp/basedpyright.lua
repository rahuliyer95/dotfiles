return {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  settings = {
    basedpyright = {
      analysis = {
        -- we are using mypy for this
        typeCheckingMode = "off"
      },
      -- we are using Ruff for this
      disableOrganizeImports = true,
    },
  },
}
