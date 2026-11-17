require("snacks").setup({
  bigfile = { enabled = true },
  dim = { enabled = true },
  explorer = { enabled = true },
  input = { enabled = true },
  git = { enabled = true },
  gh = { enabled = true },
  image = { enabled = true },
  notifier = { enabled = true, timeout = 2000 },
  picker = {
    enabled = true,
    sources = {
      explorer = {
        hidden = true,
        git_status = false,
        git_untracked = false,
        actions = {
          --- Reveal the item in the system file manager (the built-in `explorer_open` opens a
          --- file in its default app instead). Directories open themselves, files open their parent.
          ---@param item? snacks.picker.Item
          reveal_in_finder = function(_, item)
            if not item then
              return
            end
            vim.ui.open(item.dir and item.file or vim.fn.fnamemodify(item.file, ":h"))
          end,
        },
        win = {
          list = {
            keys = {
              o = "confirm",
              O = "reveal_in_finder",
            },
          },
        },
      },
    },
  },
  scroll = { enabled = true },
})

-- Hidden files default to NonText, which is unreadable on the transparent background
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("SnacksExplorerHighlights", { clear = true }),
  callback = function()
    vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { link = "Conceal" })
    vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored", { link = "Conceal" })
  end,
  desc = "Recreate snacks explorer highlights",
})
