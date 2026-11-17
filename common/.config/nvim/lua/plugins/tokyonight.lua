require("tokyonight").setup({
  dim_inactive = true,
  on_highlights = function(hl, colors)
    hl["@variable.parameter"] = { fg = colors.orange, italic = true }
    -- Make sure all keyword variants are italic because settings `keywords = { italic = true }`
    -- in `styles` section below is not working
    hl["@keyword"] = { italic = true, fg = colors.purple }
    hl["@keyword.conditional"] = { italic = true, fg = colors.purple }
    hl["@keyword.repeat"] = { italic = true, fg = colors.purple }
    hl["@keyword.return"] = { italic = true, fg = colors.purple }
    hl["@keyword.operator"] = { italic = true, fg = colors.purple }
    hl["@keyword.import"] = { italic = true, fg = colors.purple }
    hl["@keyword.export"] = { italic = true, fg = colors.purple }
    hl["@keyword.function"] = { italic = true, fg = colors.purple }
    hl["@keyword.modifier"] = { italic = true, fg = colors.purple }
    hl["@keyword.type"] = { italic = true, fg = colors.purple }
    -- Virtual text (diagnostics)
    hl.DiagnosticVirtualTextError = { fg = colors.error, italic = true }
    hl.DiagnosticVirtualTextHint = { fg = colors.hint, italic = true }
    hl.DiagnosticVirtualTextInfo = { fg = colors.info, italic = true }
    hl.DiagnosticVirtualTextWarn = { fg = colors.warning, italic = true }
    -- LSP inlay hints
    hl.LspInlayHint = { fg = colors.comment, italic = true }
    -- Status line
    hl.StatusLine = { bg = colors.none }
    hl.StatusLineNC = { bg = colors.none }
  end,
  plugins = {
    auto = true,
  },
  style = "storm",
  styles = {
    comments = { italic = true },
    floats = "transparent",
    keywords = { italic = true },
    sidebars = "transparent",
  },
  transparent = true,
})

vim.cmd.colorscheme("tokyonight")
