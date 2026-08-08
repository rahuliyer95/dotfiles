local venv = require("utils.venv")

return {
  -- Ruff never reads site-packages, so only the binary matters: prefer the project's pinned
  -- version, resolved at start time so each root_dir gets its own, falling back to Mason's.
  cmd = function(dispatchers, config)
    local ruff = venv.bin("ruff", config.root_dir) or "ruff"
    return vim.lsp.rpc.start({ ruff, "server" }, dispatchers, {
      cwd = config.cmd_cwd,
      env = config.cmd_env,
    })
  end,
}
