local fidget = require("fidget")

fidget.setup({
  notification = {
    window = {
      avoid = {
        "NvimTree",
      },
      border = "rounded",
      winblend = 0,
    },
  },
})

vim.notify = fidget.notify
