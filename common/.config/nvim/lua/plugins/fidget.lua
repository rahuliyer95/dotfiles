local fidget = require("fidget")

fidget.setup({
  window = {
    blend = 0,
  },
  notification = {
    override_vim_notify = true,
    window = {
      align = "avoid_cursor",
      avoid = {},
      border = "rounded",
      winblend = 0,
    },
  },
})
