-- barbar.nvim navigation
vim.keymap.set("n", "<Tab>", ":bn<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":bp<cr>", { desc = "Previous buffer" })

-- telescope.nvim
vim.keymap.set("n", "<C-f>", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<C-g>", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })

-- vim-anzu search progress
vim.keymap.set("n", "n", "<Plug>(anzu-n-with-echo)", { desc = "Next search result" })
vim.keymap.set("n", "N", "<Plug>(anzu-N-with-echo)", { desc = "Previous search result" })
vim.keymap.set("n", "*", "<Plug>(anzu-star-with-echo)", { desc = "Search word under cursor" })
vim.keymap.set("n", "#", "<Plug>(anzu-sharp-with-echo)", { desc = "Search word under cursor backwards" })
vim.keymap.set("n", "<Esc><Esc>", "<Plug>(anzu-clear-search-status)", { desc = "Clear search status" })

-- LSP
-- Format document
vim.keymap.set(
  "n",
  "<leader>f",
  function()
    vim.lsp.buf.code_action({
      context = { only = { "source.organizeImports" } },
      apply = true,
    })
    vim.lsp.buf.format()
  end,
  { desc = "Format Document" }
)
-- Jump to definition
vim.keymap.set('n', '<F12>', vim.lsp.buf.definition, { buffer = bufnr, desc = "Jump to definition" })
vim.keymap.set('i', '<F12>', vim.lsp.buf.definition, { buffer = bufnr, desc = "Jump to definition" })
-- Rename
vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
vim.keymap.set('i', '<F2>', vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })

-- nvim-tree
vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })

-- trouble.nvim
vim.keymap.set("n", "<F8>", "<ESC>:Trouble diagnostics toggle<CR>", { desc = "Toggle diagnostics" })
vim.keymap.set("i", "<F8>", "<ESC>:Trouble diagnostics toggle<CR>a", { desc = "Toggle diagnostics" })

-- Move lines using Alt+[jk]
vim.keymap.set("n", "<M-j>", "mz:m+<cr>`z", { desc = "Move line down" })
vim.keymap.set("n", "<M-k>", "mz:m-2<cr>`z", { desc = "Move line up" })
vim.keymap.set("v", "<M-j>", ":m'>+<cr>`<my`>mzgv`yo`z", { desc = "Move selection down" })
vim.keymap.set("v", "<M-k>", ":m'<-2<cr>`>my`<mzgv`yo`z", { desc = "Move selection up" })

-- Tab & Shift+Tab in visual mode
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent selection" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Unindent selection" })
