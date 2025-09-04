local Util = require("tokyonight.util")

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
    -- barbar.nvim support (https://github.com/folke/tokyonight.nvim/pull/727)
    hl.BufferAlternate = { bg = colors.fg_gutter, fg = colors.fg }
    hl.BufferAlternateADDED = { bg = colors.fg_gutter, fg = colors.git.add }
    hl.BufferAlternateCHANGED = { bg = colors.fg_gutter, fg = colors.git.change }
    hl.BufferAlternateDELETED = { bg = colors.fg_gutter, fg = colors.git.delete }
    hl.BufferAlternateERROR = { bg = colors.fg_gutter, fg = colors.error }
    hl.BufferAlternateHINT = { bg = colors.fg_gutter, fg = colors.hint }
    hl.BufferAlternateINFO = { bg = colors.fg_gutter, fg = colors.info }
    hl.BufferAlternateIndex = { bg = colors.fg_gutter, fg = colors.info }
    hl.BufferAlternateMod = { bg = colors.fg_gutter, fg = colors.warning }
    hl.BufferAlternateSign = { bg = colors.fg_gutter, fg = colors.info }
    hl.BufferAlternateTarget = { bg = colors.fg_gutter, fg = colors.red }
    hl.BufferAlternateWARN = { bg = colors.fg_gutter, fg = colors.warning }
    hl.BufferCurrent = { bg = colors.bg, fg = colors.fg }
    hl.BufferCurrentADDED = { bg = colors.bg, fg = colors.git.add }
    hl.BufferCurrentCHANGED = { bg = colors.bg, fg = colors.git.change }
    hl.BufferCurrentDELETED = { bg = colors.bg, fg = colors.git.delete }
    hl.BufferCurrentERROR = { bg = colors.bg, fg = colors.error }
    hl.BufferCurrentHINT = { bg = colors.bg, fg = colors.hint }
    hl.BufferCurrentINFO = { bg = colors.bg, fg = colors.info }
    hl.BufferCurrentIndex = { bg = colors.bg, fg = colors.info }
    hl.BufferCurrentMod = { bg = colors.bg, fg = colors.warning }
    hl.BufferCurrentSign = { bg = colors.bg, fg = colors.bg }
    hl.BufferCurrentTarget = { bg = colors.bg, fg = colors.red }
    hl.BufferCurrentWARN = { bg = colors.bg, fg = colors.warning }
    hl.BufferInactive =
    { bg = Util.blend_bg(colors.bg_highlight, 0.4), fg = Util.blend_bg(colors.dark5, 0.8) }
    hl.BufferInactiveADDED =
    { bg = Util.blend_bg(colors.bg_highlight, 0.4), fg = Util.blend_bg(colors.git.add, 0.8) }
    hl.BufferInactiveCHANGED = {
      bg = Util.blend_bg(colors.bg_highlight, 0.4),
      fg = Util.blend_bg(colors.git.change, 0.8),
    }
    hl.BufferInactiveDELETED = {
      bg = Util.blend_bg(colors.bg_highlight, 0.4),
      fg = Util.blend_bg(colors.git.delete, 0.8),
    }
    hl.BufferInactiveERROR =
    { bg = Util.blend_bg(colors.bg_highlight, 0.4), fg = Util.blend_bg(colors.error, 0.8) }
    hl.BufferInactiveHINT =
    { bg = Util.blend_bg(colors.bg_highlight, 0.4), fg = Util.blend_bg(colors.hint, 0.8) }
    hl.BufferInactiveINFO =
    { bg = Util.blend_bg(colors.bg_highlight, 0.4), fg = Util.blend_bg(colors.info, 0.8) }
    hl.BufferInactiveIndex = { bg = Util.blend_bg(colors.bg_highlight, 0.4), fg = colors.dark5 }
    hl.BufferInactiveMod =
    { bg = Util.blend_bg(colors.bg_highlight, 0.4), fg = Util.blend_bg(colors.warning, 0.8) }
    hl.BufferInactiveSign = { bg = Util.blend_bg(colors.bg_highlight, 0.4), fg = colors.bg }
    hl.BufferInactiveTarget = { bg = Util.blend_bg(colors.bg_highlight, 0.4), fg = colors.red }
    hl.BufferInactiveWARN =
    { bg = Util.blend_bg(colors.bg_highlight, 0.4), fg = Util.blend_bg(colors.warning, 0.8) }
    hl.BufferOffset = { bg = colors.bg_statusline, fg = colors.dark5 }
    hl.BufferTabpageFill = { bg = Util.blend_bg(colors.bg_highlight, 0.8), fg = colors.dark5 }
    hl.BufferTabpages = { bg = colors.bg_statusline, fg = colors.none }
    hl.BufferVisible = { bg = colors.bg_statusline, fg = colors.fg }
    hl.BufferVisibleADDED = { bg = colors.bg_statusline, fg = colors.git.add }
    hl.BufferVisibleCHANGED = { bg = colors.bg_statusline, fg = colors.git.change }
    hl.BufferVisibleDELETED = { bg = colors.bg_statusline, fg = colors.git.delete }
    hl.BufferVisibleERROR = { bg = colors.bg_statusline, fg = colors.error }
    hl.BufferVisibleHINT = { bg = colors.bg_statusline, fg = colors.hint }
    hl.BufferVisibleINFO = { bg = colors.bg_statusline, fg = colors.info }
    hl.BufferVisibleIndex = { bg = colors.bg_statusline, fg = colors.info }
    hl.BufferVisibleMod = { bg = colors.bg_statusline, fg = colors.warning }
    hl.BufferVisibleSign = { bg = colors.bg_statusline, fg = colors.info }
    hl.BufferVisibleTarget = { bg = colors.bg_statusline, fg = colors.red }
    hl.BufferVisibleWARN = { bg = colors.bg_statusline, fg = colors.warning }
    -- Virtual text (diagnostics)
    hl.DiagnosticVirtualTextError = { fg = colors.error, italic = true }
    hl.DiagnosticVirtualTextHint = { fg = colors.hint, italic = true }
    hl.DiagnosticVirtualTextInfo = { fg = colors.info, italic = true }
    hl.DiagnosticVirtualTextWarn = { fg = colors.warning, italic = true }
    -- LSP inlay hints
    hl.LspInlayHint = { fg = colors.comment, italic = true }
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
