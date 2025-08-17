-- Auto reload init.lua
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "init.lua",
  command = "source $MYVIMRC",
})

-- Disable optional providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Python setup using uv
vim.g.python3_host_prog = vim.fn.stdpath("data") .. "/.venv/bin/python3"

-- Cursor blinking
vim.opt.guicursor =
  "a:blinkwait200-blinkon250-blinkoff200,i:ver25-blinkwait200-blinkon200-blinkoff200"

-- Colors and appearance
vim.opt.background = "dark"
vim.opt.laststatus = 2
vim.opt.showmode = false

-- FZF integration
vim.opt.runtimepath:append("~/.fzf")

-- vim-polyglot markdown settings
vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_conceal = 0

-- RTF support
vim.g.html_number_lines = 1

-- Undo
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true
