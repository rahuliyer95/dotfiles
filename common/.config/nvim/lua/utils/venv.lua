local M = {}

-- Virtual environment candidates, activated one first, then nearest upward from `path`.
---@param path? string
---@return string[]
local function candidates(path)
  local dirs = vim.fs.find({ ".venv", "venv" }, {
    path = path or vim.fn.expand("%:p:h"),
    upward = true,
    type = "directory",
    limit = math.huge,
  })
  if vim.env.VIRTUAL_ENV then
    table.insert(dirs, 1, vim.env.VIRTUAL_ENV)
  end
  return dirs
end

-- Root of the nearest virtualenv, for tools that only need to be pointed at its interpreter.
---@param path? string
---@return string|nil
function M.dir(path)
  for _, dir in ipairs(candidates(path)) do
    if vim.fn.executable(vim.fs.joinpath(dir, "bin", "python3")) == 1 then
      return dir
    end
  end
  return nil
end

-- Executable from the nearest virtualenv providing it, for tools run as a binary.
---@param tool string
---@param path? string
---@return string|nil
function M.bin(tool, path)
  for _, dir in ipairs(candidates(path)) do
    local exe = vim.fs.joinpath(dir, "bin", tool)
    if vim.fn.executable(exe) == 1 then
      return exe
    end
  end
  return nil
end

return M
