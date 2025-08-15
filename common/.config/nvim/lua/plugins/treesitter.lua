local hasConfigs, configs = pcall(require, "nvim-treesitter.configs")
if hasConfigs then
  configs.setup({
    ensure_installed = {
      "json",
      "lua",
      "markdown",
      "python",
      "vim",
      "vimdoc",
      "yaml",
    },
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  })
end
