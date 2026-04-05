local ensureInstalled = {
  "json",
  "lua",
  "markdown",
  "python",
  "regex",
  "vim",
  "vimdoc",
  "yaml",
}
local alreadyInstalled = require("nvim-treesitter.config").get_installed()
require("nvim-treesitter").install(vim
  .iter(ensureInstalled)
  :filter(function(parser)
    return not vim.tbl_contains(alreadyInstalled, parser)
  end)
  :totable())
