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
