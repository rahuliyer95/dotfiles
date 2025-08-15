require("onedarkpro").setup({
  highlights = {
    -- barbar.nvim diagnostics
    BufferCurrentERROR = {
      fg = "${red}",
    },
    BufferCurrentINFO = {
      fg = "${blue}",
    },
    BufferCurrentWARN = {
      fg = "${yellow}",
    },
    -- git signs
    BufferCurrentADDED = {
      fg = "${green}",
    },
    BufferCurrentCHANGED = {
      fg = "${yellow}",
    },
    BufferCurrentDELETED = {
      fg = "${red}",
    },
    -- lsp
    LspInlayHint = { fg = "${comment}", italic = true }
  },
  options = {
    cursorline = true,
    transparency = true,
  },
  plugins = {
    all = true,
  },
  styles = {
    types = "NONE",
    methods = "NONE",
    numbers = "NONE",
    strings = "NONE",
    comments = "italic",
    keywords = "italic",
    constants = "NONE",
    functions = "NONE",
    operators = "NONE",
    variables = "NONE",
    parameters = "italic",
    conditionals = "italic",
    virtual_text = "italic",
  },
})

vim.cmd("colorscheme onedark")
