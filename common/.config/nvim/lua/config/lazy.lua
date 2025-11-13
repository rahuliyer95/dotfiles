-- vi: foldmethod=marker
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

---@diagnostic disable-next-line: undefined-field
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  -- Core plugins {{{
  { "junegunn/fzf.vim" },
  { "raimondi/delimitmate" },
  -- { "tpope/vim-sensible" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("plugins.treesitter")
    end,
  },
  { "tpope/vim-fugitive" },
  { "sindrets/diffview.nvim" },
  -- endregion }}}

  -- LSP and Completion {{{
  { "neovim/nvim-lspconfig" },
  {
    "rahuliyer95/mason.nvim",
    branch = "feats",
    build = ":MasonUpdate",
    config = function()
      require("plugins.mason")
    end,
    dependencies = { "neovim/nvim-lspconfig" },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "rahuliyer95/mason.nvim" },
  },
  { "nvimtools/none-ls.nvim" },
  { "jay-babu/mason-null-ls.nvim" },
  {
    "massolari/lsp-auto-setup.nvim",
    dependencies = { "rahuliyer95/mason.nvim" },
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("plugins.blink")
    end,
    version = "1.x",
  },
  -- }}}

  -- Other code plugins {{{
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("plugins.lsp-signature")
    end,
  },
  { "tpope/vim-commentary" },
  { "darfink/vim-plist" },
  {
    "folke/trouble.nvim",
    config = function()
      require("plugins.trouble")
    end,
  },
  {
    "filipdutescu/renamer.nvim",
    config = function()
      require("plugins.renamer")
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "wintermute-cell/gitignore.nvim",
    config = function()
      require("gitignore")
    end,
  },
  -- }}}

  -- Utilities {{{
  { "kana/vim-repeat" },
  { "anyakichi/vim-surround" },
  { "junegunn/vim-easy-align" },
  {
    "ntpeters/vim-better-whitespace",
    config = function()
      require("plugins.better-whitespace")
    end,
  },
  { "gisphm/vim-gitignore" },
  { "dstein64/vim-startuptime" },
  { "osyo-manga/vim-anzu" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("plugins.telescope")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.gitsigns")
    end,
  },
  { "christoomey/vim-sort-motion" },
  { "mbbill/undotree" },
  { "iamyoki/buffer-reopen.nvim" },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  --- }}}

  -- Look & Feel {{{
  -- {
  --   "olimorris/onedarkpro.nvim",
  --   config = function()
  --     require("plugins.onedarkpro")
  --   end,
  -- },
  {
    "folke/tokyonight.nvim",
    config = function()
      require("plugins.tokyonight")
    end,
    priority = 99,
  },
  {
    "nvim-mini/mini.icons",
    config = function()
      require("plugins.mini-icons")
    end,
    dependencies = { "nvim-mini/mini.nvim" },
  },
  { "onsails/lspkind.nvim" },
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("plugins.nvim-tree")
    end,
    dependencies = { "nvim-mini/mini.icons" },
  },
  {
    "RRethy/vim-illuminate",
    config = function()
      require("plugins.illuminate")
    end,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      require("plugins.rainbow-delimiters")
    end,
  },
  {
    "romgrk/barbar.nvim",
    config = function()
      require("plugins.barbar")
    end,
    dependencies = { "nvim-mini/mini.icons" },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("plugins.indent-blankline")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("plugins.lualine")
    end,
  },
  {
    "j-hui/fidget.nvim",
    config = function()
      require("plugins.fidget")
    end,
  },
  {
    "kosayoda/nvim-lightbulb",
    config = function()
      require("plugins.lightbulb")
    end,
  },
  -- }}}

  -- Local {{{
  pcall(require, "config.lazy-local") and { import = "config.lazy-local" } or nil,
  -- }}}
}, {
  checker = {
    enabled = true,
    notify = false,
  },
  ui = {
    border = "rounded",
  },
})
