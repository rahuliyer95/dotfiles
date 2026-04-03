local fidget = require("fidget")

fidget.setup({
  notification = {
    override_vim_notify = true,
    window = {
      align = "avoid_cursor",
      avoid = {
        "NvimTree",
      },
      border = "rounded",
      winblend = 0,
    },
  },
})
