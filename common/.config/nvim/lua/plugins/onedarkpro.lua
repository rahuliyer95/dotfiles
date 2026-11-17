require("onedarkpro").setup({
  highlights = {
    -- lsp
    LspInlayHint = { fg = "${gray}", italic = true },
  },
  options = {
    cursorline = true,
    highlight_inactive_windows = true,
    lualine_transparency = true,
    terminal_colors = true,
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

vim.cmd.colorscheme("onedark")
