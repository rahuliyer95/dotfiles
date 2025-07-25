-- Source minimal settings if available
if vim.fn.filereadable(vim.env.HOME .. "/.vimrc.minimal") == 1 then
  vim.cmd("source " .. vim.env.HOME .. "/.vimrc.minimal")
end

-- Load configuration modules
require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocommands")

-- Source local configuration if available
if vim.fn.filereadable(vim.env.HOME .. "/.vimrc.local") == 1 then
  vim.cmd("source " .. vim.env.HOME .. "/.vimrc.local")
end
