-- barbar.nvim navigation
vim.keymap.set("n", "<Tab>", vim.cmd.BufferNext, { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", vim.cmd.BufferPrevious, { desc = "Previous buffer" })

-- snacks.nvim picker
vim.keymap.set("n", "<C-p>", function()
  Snacks.picker.files()
end, { desc = "Find files" })
vim.keymap.set("n", "<C-g>", function()
  Snacks.picker.grep()
end, { desc = "Live grep" })
vim.keymap.set("n", "<C-S-p>", function()
  Snacks.picker.commands()
end, { desc = "Command palette" })

-- Set the search pattern without jumping. Search count comes from the native message.
vim.keymap.set("n", "*", function()
  vim.fn.setreg("/", "\\<" .. vim.fn.expand("<cword>") .. "\\>")
  vim.fn.histadd("search", vim.fn.getreg("/"))
  vim.o.hlsearch = true
end, { desc = "Search word under cursor" })
vim.keymap.set("n", "<Esc><Esc>", vim.cmd.nohlsearch, { desc = "Clear search highlight" })
-- Native `n` repeats the last search in its original direction, so `?` and `#` invert it.
-- Pin `n` to forward and `N` to backward instead.
vim.keymap.set({ "n", "x", "o" }, "n", "'Nn'[v:searchforward]", {
  expr = true,
  desc = "Next search result",
})
vim.keymap.set({ "n", "x", "o" }, "N", "'nN'[v:searchforward]", {
  expr = true,
  desc = "Previous search result",
})

-- undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- LSP
-- Format document
vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.code_action({
    apply = true,
    context = {
      diagnostics = {},
      only = { "source.organizeImports" },
    },
  })
  vim.lsp.buf.format()
end, { desc = "Format Document" })
-- Jump to definition
vim.keymap.set("n", "<F12>", vim.lsp.buf.definition, { desc = "Jump to definition" })
vim.keymap.set("i", "<F12>", vim.lsp.buf.definition, { desc = "Jump to definition" })
-- Rename
vim.keymap.set("n", "<F2>", function()
  require("live-rename").rename({ curpos = -1, insert = true })
end, { desc = "Rename" })
vim.keymap.set("i", "<F2>", function()
  require("live-rename").rename({ curpos = -1, insert = true })
end, { desc = "Rename" })
-- Show callers
vim.keymap.set("n", "<leader>fr", function()
  Snacks.picker.lsp_references()
end, { desc = "Show callers" })
-- Code Actions
vim.keymap.set("n", "<C-.>", vim.lsp.buf.code_action, { desc = "Show code actions" })
-- Diagnostics
vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic" })
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = -1 })
end, { desc = "Previous diagnostic" })

-- nvim-tree
vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })

-- trouble.nvim
vim.keymap.set("n", "<F8>", "<ESC>:Trouble diagnostics toggle<CR>", { desc = "Toggle diagnostics" })
vim.keymap.set(
  "i",
  "<F8>",
  "<ESC>:Trouble diagnostics toggle<CR>a",
  { desc = "Toggle diagnostics" }
)

-- Move lines using Alt+[jk]
vim.keymap.set("n", "<M-j>", "mz:m+<cr>`z", { desc = "Move line down" })
vim.keymap.set("n", "<M-k>", "mz:m-2<cr>`z", { desc = "Move line up" })
vim.keymap.set("v", "<M-j>", ":m'>+<cr>`<my`>mzgv`yo`z", { desc = "Move selection down" })
vim.keymap.set("v", "<M-k>", ":m'<-2<cr>`>my`<mzgv`yo`z", { desc = "Move selection up" })

-- Tab & Shift+Tab in visual mode
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent selection" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Unindent selection" })

-- diffview.nvim
-- Opening during a conflict automatically lands in the merge tool layout
vim.keymap.set("n", "<leader>gd", function()
  if next(require("diffview.lib").views) == nil then
    vim.cmd.DiffviewOpen()
  else
    vim.cmd.DiffviewClose()
  end
end, { desc = "Toggle diff view" })

-- vim-fugitive conflict resolution
local diffget_maps = {
  gb = { "//1", "base" },
  gh = { "//2", "ours" },
  gl = { "//3", "theirs" },
}

--- @param enable boolean
local function set_diffget_maps(enable)
  for lhs, spec in pairs(diffget_maps) do
    if enable then
      vim.keymap.set("n", lhs, "<cmd>diffget " .. spec[1] .. "<cr><cmd>diffupdate<cr>", {
        buffer = 0,
        desc = "Get " .. spec[2] .. " diff",
      })
    else
      pcall(vim.keymap.del, "n", lhs, { buffer = 0 })
    end
  end
end

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "diff",
  callback = function()
    set_diffget_maps(vim.v.option_new)
  end,
  desc = "Conflict resolution maps while in diff mode",
})

-- OptionSet is suppressed during startup, so `nvim -d` and `git mergetool` need their own pass
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.wo[win].diff then
        vim.api.nvim_win_call(win, function()
          set_diffget_maps(true)
        end)
      end
    end
  end,
  desc = "Conflict resolution maps when starting in diff mode",
})
