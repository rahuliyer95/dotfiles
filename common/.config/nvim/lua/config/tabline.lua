-- lua_ls indexes this file twice (repo path and the ~/.config/nvim symlink in its runtime library)
---@diagnostic disable: duplicate-set-field
local severities = {
  { vim.diagnostic.severity.ERROR, "DiagnosticError", "\u{f057} " },
  { vim.diagnostic.severity.WARN, "DiagnosticWarn", "\u{f071} " },
  { vim.diagnostic.severity.INFO, "DiagnosticInfo", "\u{f05a} " },
}
local git_signs = {
  { "added", "GitSignsAdd", "+" },
  { "changed", "GitSignsChange", "~" },
  { "removed", "GitSignsDelete", "-" },
}

---Click handler for a tab label. Must be global so `%@v:lua.tabline_goto@` can call it.
---@param buf integer buffer number embedded in the click region
function _G.tabline_goto(buf)
  vim.api.nvim_set_current_buf(buf)
end

---Click handler for a tab's close button. Must be global so `%@v:lua.tabline_close@` can call it.
---@param buf integer buffer number embedded in the click region
function _G.tabline_close(buf)
  Snacks.bufdelete(buf)
end

---Render one tab: icon, name, diagnostic and git sign counts, and the close/modified marker.
---@param buf integer
---@return string tabline fragment with highlight groups and click regions
local function tab(buf)
  local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
  if name == "" then
    name = "[No Name]"
  end
  local icon, icon_hl = require("mini.icons").get("file", name)
  local current = buf == vim.api.nvim_get_current_buf()
  local out = {
    ("%%%d@v:lua.tabline_goto@%%#%s#%s %%#%s#%s"):format(
      buf,
      icon_hl,
      icon,
      current and "TabLineCurrent" or "TabLineInactive",
      name:gsub("%%", "%%%%")
    ),
  }
  local diagnostics = vim.diagnostic.count(buf)
  for _, sev in ipairs(severities) do
    if diagnostics[sev[1]] then
      out[#out + 1] = ("%%#%s# %s%d"):format(sev[2], sev[3], diagnostics[sev[1]])
    end
  end
  local status = vim.b[buf].gitsigns_status_dict or {}
  for _, sign in ipairs(git_signs) do
    if (status[sign[1]] or 0) > 0 then
      out[#out + 1] = ("%%#%s# %s%d"):format(sign[2], sign[3], status[sign[1]])
    end
  end
  local modified = vim.bo[buf].modified
  out[#out + 1] = ("%%X %%%d@v:lua.tabline_close@%%#%s#%s%%X  "):format(
    buf,
    modified and "DiagnosticWarn" or "TabLineInactive",
    modified and "\u{25cf}" or "\u{f0156}"
  )
  return table.concat(out)
end

---Render the whole tabline from `vim.opt.tabline`, one tab per listed buffer.
---shortcut: no scrolling when tabs overflow the screen, add it if that becomes a problem
---@return string
function _G.tabline()
  local tabs = vim.tbl_map(function(b)
    return tab(b.bufnr)
  end, vim.fn.getbufinfo({ buflisted = 1 }))
  return " " .. table.concat(tabs) .. "%#Normal#"
end

local function set_hl()
  vim.api.nvim_set_hl(0, "TabLineCurrent", { bold = true })
  vim.api.nvim_set_hl(0, "TabLineInactive", { link = "Conceal" })
end

vim.api.nvim_create_autocmd(
  "ColorScheme",
  { callback = set_hl, desc = "Recreate tabline highlight" }
)
vim.api.nvim_create_autocmd({ "DiagnosticChanged", "BufModifiedSet" }, {
  command = "redrawtabline",
  desc = "Refresh tabline diagnostics and modified marker",
})
vim.api.nvim_create_autocmd("User", {
  pattern = "GitSignsUpdate",
  command = "redrawtabline",
  desc = "Refresh tabline git signs",
})

vim.opt.tabline = "%!v:lua.tabline()"
