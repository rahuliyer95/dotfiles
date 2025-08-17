return {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
  settings = {
    basedpyright = {
      analysis = {
        -- we are using mypy for this
        typeCheckingMode = "off",
      },
      -- we are using Ruff for this
      disableOrganizeImports = true,
    },
  },
}
