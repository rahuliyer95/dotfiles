" Plug {{{
call plug#begin()

" Core {{{

Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf.vim'
Plug 'raimondi/delimitmate'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-eunuch'
Plug 'nvim-treesitter/nvim-treesitter'

" }}}

" Code {{{

" LSP {{{

Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvimtools/none-ls.nvim'
Plug 'jay-babu/mason-null-ls.nvim'

"}}}

" TAB completion {{{

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

" }}}

Plug 'ray-x/lsp_signature.nvim'
Plug 'joom/vim-commentary'
Plug 'darfink/vim-plist'
Plug 'apple/pkl-neovim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'folke/trouble.nvim'

" }}}

" Utilities {{{

Plug 'kana/vim-repeat'
Plug 'anyakichi/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/vim-easy-align'
Plug 'ntpeters/vim-better-whitespace'
Plug 'gisphm/vim-gitignore'
Plug 'dstein64/vim-startuptime'
Plug 'osyo-manga/vim-anzu'
Plug 'tpope/vim-abolish'
Plug 'nvim-telescope/telescope.nvim'
" Required by telescope.nvim
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'christoomey/vim-sort-motion'

" }}}

" Look & Feel {{{

Plug 'olimorris/onedarkpro.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'RRethy/vim-illuminate'
Plug 'HiPhish/rainbow-delimiters.nvim'
Plug 'romgrk/barbar.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-lualine/lualine.nvim'

" }}}

" Local

if filereadable($HOME . "/.vimrc.plug")
  source $HOME/.vimrc.plug
endif

call plug#end()

" }}}

" Basic Settings {{{

if filereadable($HOME . "/.vimrc.minimal")
  source $HOME/.vimrc.minimal
endif

" Auto reload vimrc
autocmd! BufWritePost .vimrc source $MYVIMRC

" Disable optional `perl` provider
let g:loaded_perl_provider = 0

" Disable optional `ruby` provider
let g:loaded_ruby_provider = 0

" Python setup using `uv`
let g:python3_host_prog = $HOME . "/.local/share/nvim/.venv/bin/python3"

" Cursor blinking
set guicursor=a:blinkwait200-blinkon250-blinkoff200,i:ver25-blinkwait200-blinkon200-blinkoff200

" }}}

" Colors and Fonts {{{

set background=dark

" OneDark {{{

lua << EOF

require('onedarkpro').setup({
  highlights = {
    -- barbar.nvim {{{
    -- }}}
    -- diagnostics {{{
    BufferCurrentERROR = {
      fg = "${red}",
    },
    BufferCurrentINFO = {
      fg = "${blue}",
    },
    BufferCurrentWARN = {
      fg = "${yellow}",
    },
    -- }}}
    -- git signs {{{
    BufferCurrentADDED = {
      fg = "${green}",
    },
    BufferCurrentCHANGED = {
      fg = "${yellow}",
    },
    BufferCurrentDELETED = {
      fg = "${red}",
    },
    -- }}}
  },
  options = {
    cursorline   = true,
    transparency = true,
  },
  plugins = {
    all = true,
  },
  styles = {
    types        = "NONE",
    methods      = "NONE",
    numbers      = "NONE",
    strings      = "NONE",
    comments     = "italic",
    keywords     = "italic",
    constants    = "NONE",
    functions    = "NONE",
    operators    = "NONE",
    variables    = "NONE",
    parameters   = "italic",
    conditionals = "italic",
    virtual_text = "italic",
  },
})

EOF

colorscheme onedark

" }}}

" }}}

" Status line {{{

" Always show the status line
set laststatus=2
set noshowmode

" lualine.nvim {{{

lua << EOF

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = require('lualine.themes.onedark'),
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename', 'HasPaste'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {},
    lualine_z = {'location'}
  },
}

require('lualine').hide {
  place = {'tabline'},
  unhide = false,
}

EOF

" }}}

" }}}

" barbar.nvim {{{

map <Tab> :bn<cr>
map <S-Tab> :bp<cr>

lua << EOF

vim.g.barbar_auto_setup = false
require('barbar').setup {
  icons = {
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = { enabled = true },
      [vim.diagnostic.severity.WARN] = { enabled = true },
      [vim.diagnostic.severity.INFO] = { enabled = true },
      [vim.diagnostic.severity.HINT] = { enabled = false },
    },
    gitsigns = {
      added = { enabled = true },
      deleted = { enabled = true },
      changed = { enabled = true },
    },
  }
}

EOF

" }}}

" pkl {{{

lua << EOF

local hasConfigs, configs = pcall(require, "nvim-treesitter.configs")
if hasConfigs then
  configs.setup {
    ensure_installed = { "pkl" },
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  }
end

EOF

" }}}

" vim-polyglot {{{

" Markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0

" }}}

" telescope.nvim {{{

lua << EOF
require('telescope').setup {}
EOF

nnoremap <C-f> <cmd>Telescope find_files<cr>
nnoremap <C-g> <cmd>Telescope live_grep<cr>

set rtp+=~/.fzf

" }}}

" rainbow-delimiters.nvim {{{

lua << EOF

---@type rainbow_delimiters.config
vim.g.rainbow_delimiters = {
    strategy = {
        [""] = "rainbow-delimiters.strategy.global",
        vim = "rainbow-delimiters.strategy.local",
    },
    query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks",
    },
    priority = {
        [""] = 110,
        lua = 210,
    },
    highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
    },
}

EOF

" }}}

" indent-blankline.nvim {{{

lua << EOF

require("ibl").setup({})

EOF

" }}}

" vim-better-whitespace {{{

let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

" }}}

" vim-anzu (search progress) {{{

nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
" clear status
nmap <Esc><Esc> <Plug>(anzu-clear-search-status)

" }}}

" vim-easy-align {{{

let g:easy_align_ignore_groups = ['Comment', 'String']

" }}}

" nvim-tree {{{

nnoremap <leader>n :NvimTreeToggle<CR>

lua << EOF

require('nvim-tree').setup {
  actions             = {
    open_file = {
      resize_window = true,
    },
  },
  filters             = {
    dotfiles = true,
  },
  git                 = {
    enable = false,
  },
  renderer            = {
    highlight_opened_files = 'icon',
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
      },
    },
    indent_markers = {
      enable = true,
    },
  },
  respect_buf_cwd     = true,
  sync_root_with_cwd  = true,
  update_cwd          = true,
  update_focused_file = {
    enable      = true,
    update_cwd  = true,
    ignore_list = {},
  },
}

EOF

" }}}

" gitsigns.nvim {{{

lua << EOF

require('gitsigns').setup {}

EOF

" }}}

" vim-illuminate {{{

lua << EOF

require('illuminate').configure({
  delay = 0,
})

EOF

" }}}

" mason.nvim {{{

lua << EOF

require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "basedpyright",
    "bashls",
    "ruff",
  },
})

-- Setup LSP servers (:h mason-lspconfig-automatic-server-setup)
require("mason-lspconfig").setup_handlers {
  -- The first entry (without a key) will be the default handler and will be called for each
  -- installed server that doesn't have a dedicated handler.
  function (server_name)
    require("lspconfig")[server_name].setup {}
  end,
  ["basedpyright"] = function()
    require("lspconfig").basedpyright.setup({
      settings = {
        basedpyright = {
          -- we are using Ruff for this
          analysis = {
            ignore = { "*" }
          },
          disableOrganizeImports = true,
        },
      },
    })
  end,
  ["bashls"] = function()
    require("lspconfig").bashls.setup({
      settings = {
        bashIde = {
          shfmt = {
            binaryNextLine = true,
            caseIndent = true,
            simplifyCode = true,
            spaceRedirects = true,
          },
        },
      },
    })
  end,
}

require("mason-null-ls").setup({
  ensure_installed = {},
  handlers = {},
})

require("null-ls").setup({
  sources = {},
})

-- Show diagnostic information on the current line as virtual text
vim.diagnostic.config({
  virtual_text = {
    current_line = true
  }
})

-- Format document
vim.keymap.set(
  "n",
  "<leader>f",
  function()
    vim.lsp.buf.code_action({
      context = { only = { "source.organizeImports" } },
      apply = true,
    })
    vim.lsp.buf.format()
  end,
  { desc = "Format Document" }
)

EOF

" }}}

" nvim-cmp  {{{

lua << EOF

local cmp = require('cmp')

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<TAB>'] = cmp.mapping.confirm({ select = true }),
  }),
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end
  },
  sources = cmp.config.sources(
    {
      { name = 'buffer' },
      { name = 'cmdline' },
      { name = 'nvim_lsp' },
      { name = 'path' },
      { name = 'ultisnips' },
    }
  )
})

EOF

" }}}

" trouble.nvim {{{

lua << EOF

require('trouble').setup({
  mode = 'float'
})

EOF

nnoremap <F8> <ESC>:Trouble diagnostics toggle<CR>
inoremap <F8> <ESC>:Trouble diagnostics toggle<CR>a

" }}}

" lsp_signature.nvim {{{

lua << EOF

require("lsp_signature").setup({
  bind = true,
  handler_opts = {
    border = "rounded"
  },
  hint_prefix = "",
  hint_inline = function() return true end,
  transparency = 100,
})

EOF

" }}}

" Moving around, tabs, windows and buffers {{{

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
" Remember info about open buffers on close
set viminfo^=%

" }}}

" RTF {{{

let g:html_number_lines = 1

function! s:CopyRTF(bufnr, line1, line2)

  " check at runtime since this plugin may not load before this one
  if !exists(':TOhtml')
    echoerr 'cannot load copy-as-rtf plugin, TOhtml command not found.'
    finish
  endif

  " save the alternate file and restore it at the end
  let l:alternate=bufnr(@#)

  let lines = getline(a:line1, a:line2)

  call tohtml#Convert2HTML(a:line1, a:line2)
  normal! ggyG
  exe "!pbpaste | textutil -convert rtf -stdin -stdout | pbcopy"

  silent bd!
  silent call setline(a:line1, lines)
endfunction

command! -range=% CopyRTF :call s:CopyRTF(bufnr('%'),<line1>,<line2>)

" }}}

" Editing mappings {{{

" Move a line of text using ALT+[jk]
nnoremap <M-j> mz:m+<cr>`z
nnoremap <M-k> mz:m-2<cr>`z
vnoremap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" }}}

" Helper functions {{{

" Returns true if paste mode is enabled
function! HasPaste()
  if &paste
    return 'PASTE MODE  '
  en
  return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()

function! <SID>BufcloseCloseIt()
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")

  if buflisted(l:alternateBufNum)
    buffer #
  else
    bnext
  endif

  if bufnr("%") == l:currentBufNum
    new
  endif

  if buflisted(l:currentBufNum)
    execute("bdelete! ".l:currentBufNum)
  endif
endfunction

" }}}

" Custom Maps {{{

" Tab & Shift+Tab in visual mode
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" }}}

" Read from local vimrc {{{

if filereadable($HOME . "/.vimrc.local")
  source $HOME/.vimrc.local
endif

" }}}
