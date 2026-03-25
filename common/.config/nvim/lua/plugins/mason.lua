require("mason").setup({
  npm = {
    use_pnpm = true,
  },
  pip = {
    use_python3_host_prog = true,
  },
  ui = {
    border = "rounded",
  },
})

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
  ensure_installed = {
    "stylua",
  },
  handlers = {
    -- We use bashls to format. Since bashls requires shfmt binary to be installed separately (which
    -- we manage using Mason) we need to disable this so that null-ls doesn't register shfmt.
    shfmt = function() end,
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
vim.lsp.set_log_level("off")
