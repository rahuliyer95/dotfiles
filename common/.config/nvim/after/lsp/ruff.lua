--- Prefer the project's virtualenv ruff so its pinned version and rules are honoured.
--- @param root string
local function venv_ruff(root)
  local dirs = vim.fs.find({ ".venv", "venv" }, {
    path = root or vim.fn.expand("%:p:h"),
    upward = true,
    type = "directory",
    limit = math.huge,
  })
  if vim.env.VIRTUAL_ENV then
    table.insert(dirs, 1, vim.env.VIRTUAL_ENV)
  end
  for _, dir in ipairs(dirs) do
    local exe = vim.fs.joinpath(dir, "bin", "ruff")
    if vim.fn.executable(exe) == 1 then
      return exe
    end
  end
end

return {
  -- Resolved at start time so each root_dir gets its own venv binary, falling back to Mason's.
  cmd = function(dispatchers, config)
    return vim.lsp.rpc.start({ venv_ruff(config.root_dir) or "ruff", "server" }, dispatchers, {
      cwd = config.cmd_cwd,
      env = config.cmd_env,
    })
  end,
}
