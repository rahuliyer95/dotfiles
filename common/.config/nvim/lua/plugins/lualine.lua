-- based off https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets#mixed-indent
local function indent_info()
  local sw = vim.bo.shiftwidth
  if sw == 0 then
    sw = vim.bo.tabstop
  end
  local et = vim.bo.expandtab
  local type = et and "spaces" or "tabs"
  return string.format("%s:%d", type, sw)
end

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "tokyonight",
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
    },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = {
      {
        function()
          return vim.opt.paste:get() and "PASTE MODE" or ""
        end,
        color = { fg = "white", gui = "bold" },
      },
      "filetype",
    },
    lualine_y = { indent_info },
    lualine_z = { "location" },
  },
})
