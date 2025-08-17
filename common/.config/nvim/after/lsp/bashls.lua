return {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
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
