require("mason").setup({
  log_level = vim.log.levels.OFF,
  ui = {
    border = "rounded",
  },
})

local mason_compiler = require("mason-core.installer.compiler")
local mason_path = require("mason-core.path")
local mason_result = require("mason-core.result")
local npm_compiler = require("mason-core.installer.compiler.compilers.npm")
local pypi_compiler = require("mason-core.installer.compiler.compilers.pypi")

-- Install pypi packages with `uv` instead of pip.
local uv_pypi = setmetatable({
  ---@async
  ---@param ctx InstallContext
  ---@param source ParsedPypiSource
  install = function(ctx, source)
    return mason_result.try(function(try)
      -- uv (like pip) hardcodes absolute paths into the venv, so promote the staging dir to its
      -- final install path before creating the venv.
      ctx:promote_cwd()
      local venv = mason_path.concat({ ctx.cwd:get(), "venv" })
      ctx.stdio_sink:stdout("Creating virtual environment with uv\n")
      try(ctx.spawn.uv({ "venv", "--system-site-packages", "venv" }))
      local pkg = source.extra
          and ("%s[%s]==%s"):format(source.package, source.extra, source.version)
        or ("%s==%s"):format(source.package, source.version)
      ctx.stdio_sink:stdout(
        ("Installing pip package %s@%s with uv\n"):format(source.package, source.version)
      )
      try(ctx.spawn.uv({
        "pip",
        "install",
        pkg,
        source.extra_packages or vim.NIL,
        env = { VIRTUAL_ENV = venv },
      }))
    end)
  end,
}, { __index = pypi_compiler })

-- Install npm packages with `pnpm`.
local pnpm_npm = setmetatable({
  ---@async
  ---@param ctx InstallContext
  ---@param source ParsedNpmSource
  install = function(ctx, source)
    return mason_result.try(function(try)
      -- Initialize a pnpm root, then scope the package name like the manager does.
      try(ctx.spawn.pnpm({ "init" }))
      local package_json =
        try(mason_result.pcall(vim.json.decode, ctx.fs:read_file("package.json")))
      package_json.name = "@mason/" .. package_json.name
      package_json.devEngines = nil
      package_json = try(mason_result.pcall(vim.json.encode, package_json, {}))
      ctx.fs:write_file("package.json", package_json)
      ctx.stdio_sink:stdout(
        ("Installing npm package %s@%s with pnpm\n"):format(source.package, source.version)
      )
      try(ctx.spawn.pnpm({
        "add",
        -- Flat layout so `node_modules/.bin/*` are symlinks mason can link to.
        "--config.node-linker=hoisted",
        ("%s@%s"):format(source.package, source.version),
        source.extra_packages or vim.NIL,
      }))
    end)
  end,
}, { __index = npm_compiler })

mason_compiler.register_compiler("npm", pnpm_npm)
mason_compiler.register_compiler("pypi", uv_pypi)

require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    "lua_ls",
  },
})

-- Setup all available servers
require("lsp-auto-setup").setup({
  exclude = {
    "gitlab_duo",
    "rls",
    "systemd_ls",
    "tvm_ffi_navigator",
    "vscoqtop",
  },
})

local null_ls = require("null-ls")

-- Sort all keys in a JSON document using jq
local sort_json_keys = {
  name = "sort_json_keys",
  method = null_ls.methods.CODE_ACTION,
  filetypes = { "json" },
  generator = {
    fn = function(params)
      return {
        {
          title = "Sort JSON keys",
          action = function()
            local bufnr = params.bufnr
            local content = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")
            local result = vim.fn.system("jq -S .", content)
            if vim.v.shell_error == 0 then
              local lines = vim.split(result, "\n")
              if lines[#lines] == "" then
                table.remove(lines)
              end
              vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
            end
          end,
        },
      }
    end,
  },
}

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.mypy.with({
      prefer_local = ".venv/bin",
      runtime_condition = function(params)
        return not params.bufname:find("%.venv")
      end,
    }),
    sort_json_keys,
  },
})

require("mason-null-ls").setup({
  automatic_installation = true,
  ensure_installed = {
    "stylua",
  },
  handlers = {
    -- We use bashls to format. Since bashls requires shfmt binary to be installed separately (which
    -- we manage using Mason) we need to disable this so that null-ls doesn't register shfmt.
    shfmt = function() end,
    -- Use ~/.markdownlint-cli2.yml as the base config so project-local configs can override it.
    markdownlint_cli2 = function()
      null_ls.register(null_ls.builtins.diagnostics.markdownlint_cli2.with({
        extra_args = { "--config", vim.env.HOME .. "/.markdownlint-cli2.yml" },
      }))
    end,
  },
})

-- Show diagnostic information on the current line as virtual text
vim.diagnostic.config({
  float = { border = "rounded", source = "if_many" },
  severity_sort = true,
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  } or {},
  underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = {
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
    source = "if_many",
    spacing = 2,
  },
})

-- Enable inlay hints
vim.lsp.inlay_hint.enable(true)
vim.lsp.log.set_level("off")
