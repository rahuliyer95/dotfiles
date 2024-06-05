" Plug {{{
call plug#begin()

" Core {{{

Plug 'sheerun/vim-polyglot'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf.vim'
Plug 'raimondi/delimitmate'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-eunuch'

function NvimTreeSitterPostInstall(info)
  TSInstall! lua
  TSInstall! vim
  TSInstall! vimdoc
  TSUpdate
endfunction
Plug 'nvim-treesitter/nvim-treesitter', { 'do': function('NvimTreeSitterPostInstall') }

" }}}

" Code {{{

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'joom/vim-commentary'
Plug 'tmhedberg/SimpylFold'
Plug 'darfink/vim-plist'
Plug 'apple/pkl-neovim'
Plug 'honza/vim-snippets'

" }}}

" Documentation {{{

Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'PeterRincker/vim-argumentative'
Plug 'FooSoft/vim-argwrap'
Plug 'heavenshell/vim-pydocstring'

" }}}

" Utilities {{{

Plug 'kana/vim-repeat'
Plug 'anyakichi/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'editorconfig/editorconfig-vim'
if has('unix')
  let s:uname = system('uname -s')
  if s:uname == 'Darwin\n'
    Plug 'rizzatti/dash.vim'
  endif
endif
Plug 'luochen1990/rainbow'
Plug 'junegunn/vim-easy-align'
Plug 'ntpeters/vim-better-whitespace'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'gisphm/vim-gitignore'
Plug 'dstein64/vim-startuptime'
Plug 'osyo-manga/vim-anzu'
Plug 'tpope/vim-abolish'
Plug 'nvim-telescope/telescope.nvim'
" Required by telescope.nvim
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'

" }}}

" Look & Feel {{{

Plug 'olimorris/onedarkpro.nvim'
Plug 'lunacookies/vim-colors-xcode'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'RRethy/vim-illuminate'
Plug 'romgrk/barbar.nvim'
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

" Python setup using `pyenv`
let g:python3_host_prog = $PYENV_ROOT . "/versions/neovim/bin/python3"

" }}}

" Colors and Fonts {{{

set background=dark

" OneDark {{{

lua << EOF

require('onedarkpro').setup {
  options = {
    cursorline   = true,
    transparency = true,
  },
  styles = {
    types        = "NONE",
    methods      = "NONE",
    numbers      = "NONE",
    strings      = "NONE",
    comments     = "italic",
    keywords     = "NONE",
    constants    = "NONE",
    functions    = "NONE",
    operators    = "NONE",
    variables    = "NONE",
    parameters   = "italic",
    conditionals = "italic",
    virtual_text = "italic",
  },
}

EOF

colorscheme onedark

" }}}

" XCode {{{

" Italic Comments

" augroup vim-colors-xcode
"   autocmd!
" augroup END
" autocmd vim-colors-xcode ColorScheme * hi Comment        cterm=italic gui=italic
" autocmd vim-colors-xcode ColorScheme * hi SpecialComment cterm=italic gui=italic

" let g:xcodedark_green_comments = 1
" let g:xcodedark_dim_punctuation = 0

" colorscheme xcodedark

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
    theme = 'auto',
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
    lualine_y = {'progress'},
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

require('barbar').setup {
  icons = {
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = {enabled = true},
      [vim.diagnostic.severity.WARN] = {enabled = true},
      [vim.diagnostic.severity.INFO] = {enabled = true},
      [vim.diagnostic.severity.HINT] = {enabled = true},
    },
  }
}

EOF

" }}}

" SimplyFold {{{

let g:SimpylFold_docstring_preview=1
set foldlevel=99

" }}}

" coc.nvim {{{

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Map <tab> for trigger completion, completion confirm, snippet expand and jump like VSCode:
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#_select_confirm() :
  \ coc#expandableOrJumpable() ?
  \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()

inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Use <c-space> to trigger completion: >
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" To make <CR> to confirm selection of selected complete item or notify coc.nvim to format on enter
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

let g:coc_snippet_next = '<tab>'

" Key maps
inoremap <silent> <c-space><expr> CocAction("showSignatureHelp")
inoremap <silent> <c-q><expr> CocAction("doHover")
inoremap <silent> <c-p><expr> CocCommand
nnoremap <silent> <c-q><expr> CocAction("doHover")
nnoremap <silent> <c-p><expor> CocCommand
nmap <F2> <Plug>(coc-rename)
nmap <silent> <F12> <Plug>(coc-definition)
nmap <silent> <leader><F12> <Plug>(coc-references)
nmap <silent> <leader>f <Plug>(coc-format)<ESC>:call CocAction("organizeImport")<CR>
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
xmap <leader>f <Plug>(coc-format-selected)
" navigate conflicts of current buffer
nmap [c <Plug>(coc-git-prevconflict)
nmap ]c <Plug>(coc-git-nextconflict)

" 'coc-highlight' => Add this to support highlight
let g:coc_global_extensions = [
      \ 'coc-diagnostic',
      \ 'coc-docker',
      \ 'coc-emoji',
      \ 'coc-git',
      \ 'coc-gocode',
      \ 'coc-json',
      \ 'coc-pyright',
      \ 'coc-sh',
      \ 'coc-snippets',
      \ 'coc-sql',
      \ 'coc-xml',
      \ 'coc-yaml',
      \ ]

set sessionoptions+=globals

" }}}

" pkl {{{

lua << EOF
local hasConfigs, configs = pcall(require, "nvim-treesitter.configs")
if hasConfigs then
  configs.setup {
    ensure_installed = { "pkl" },
    highlight = {
      enable = true,              -- false will disable the whole extension
    },
    indent = {
      enable = true,
    },
  }
end
EOF

" }}}

" vim-pydocstring {{{

nmap <silent> <C-_> <Plug>(pydocstring)
let g:pydocstring_formatter = "google"

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

" rainbow {{{

let g:rainbow_active = 1

" }}}

" vim-indent-guides {{{

let g:indent_guides_enable_on_vim_startup = 1

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

" {{{ vim-easy-align

let g:easy_align_ignore_groups = ['Comment', 'String']

nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" }}}

" {{{ nvim-tree

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

" gitsigns {{{

lua << EOF

require('gitsigns').setup {
}

EOF

" }}}

" vim-illuminate {{{

lua << EOF

require('illuminate').configure({
  delay = 0,
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
vmap <Tab> >gv
vmap <S-Tab> <gv

" }}}

" Read from local vimrc {{{

if filereadable($HOME . "/.vimrc.local")
  source $HOME/.vimrc.local
endif

" }}}
