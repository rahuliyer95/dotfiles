-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
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
  -- Core plugins
  { "junegunn/fzf.vim" },
  { "raimondi/delimitmate" },
  { "tpope/vim-sensible" },
  { "tpope/vim-eunuch" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("plugins.treesitter")
    end
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
  },
  { "sindrets/diffview.nvim" },

  -- LSP and completion
  { "neovim/nvim-lspconfig" },
  {
    "rahuliyer95/mason.nvim",
    branch = "feats",
    build = ":MasonUpdate",
    config = function()
      require("plugins.mason")
    end,
    dependencies = { "neovim/nvim-lspconfig" }
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "rahuliyer95/mason.nvim"}
  },
  { "nvimtools/none-ls.nvim" },
  { "jay-babu/mason-null-ls.nvim" },
  { "massolari/lsp-auto-setup.nvim" },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("plugins.cmp")
    end
  },

  -- Other code plugins
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("plugins.lsp-signature")
    end
  },
  { "joom/vim-commentary" },
  { "darfink/vim-plist" },
  { "apple/pkl-neovim" },
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("plugins.luasnip")
    end
  },
  { "rafamadriz/friendly-snippets" },
  {
    "folke/trouble.nvim",
    config = function()
      require("plugins.trouble")
    end
  },

  -- Utilities
  { "kana/vim-repeat" },
  { "anyakichi/vim-surround" },
  { "tpope/vim-unimpaired" },
  { "junegunn/vim-easy-align" },
  {
    "ntpeters/vim-better-whitespace",
    config = function()
      require("plugins.better-whitespace")
    end
  },
  { "gisphm/vim-gitignore" },
  { "dstein64/vim-startuptime" },
  { "osyo-manga/vim-anzu" },
  { "tpope/vim-abolish" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins.telescope")
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.gitsigns")
    end
  },
  { "christoomey/vim-sort-motion" },

  -- Look & Feel
  {
    "olimorris/onedarkpro.nvim",
    config = function()
      require("plugins.onedarkpro")
    end
  },
  { "kyazdani42/nvim-web-devicons" },
  { "onsails/lspkind.nvim" },
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("plugins.nvim-tree")
    end
  },
  {
    "RRethy/vim-illuminate",
    config = function()
      require("plugins.illuminate")
    end
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      require("plugins.rainbow-delimiters")
    end
  },
  {
    "romgrk/barbar.nvim",
    config = function()
      require("plugins.barbar")
    end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("plugins.indent-blankline")
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("plugins.lualine")
    end
  },
}, {
  -- lazy.nvim configuration
  install = {
    colorscheme = { "onedark" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
})
