" Plug {{{
call plug#begin()

" Core
Plug 'sheerun/vim-polyglot'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'raimondi/delimitmate'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-eunuch'
" Please ensure to do `:TSInstall! vim` and `:TSInstall! lua` after installation
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

" Code
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'antoinemadec/coc-fzf'
Plug 'joom/vim-commentary'
Plug 'tmhedberg/SimpylFold'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm i'  }
Plug 'darfink/vim-plist'
Plug 'https://github.com/apple/pkl-neovim.git'

" Documentation
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'PeterRincker/vim-argumentative'
Plug 'FooSoft/vim-argwrap'
Plug 'heavenshell/vim-pydocstring'

" Utilities
" Plug 'ervandew/supertab'
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
Plug 'mattn/emmet-vim'
Plug 'gisphm/vim-gitignore'
Plug 'dstein64/vim-startuptime'
Plug 'osyo-manga/vim-anzu'
Plug 'tpope/vim-abolish'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Look & Feel
Plug 'rafi/awesome-vim-colorschemes'
Plug 'lunacookies/vim-colors-xcode'
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'
Plug 'liuchengxu/vista.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }

call plug#end()
" }}}

" Basic Settings {{{

if filereadable($HOME . "/.vimrc.minimal")
  source $HOME/.vimrc.minimal
endif

" Auto reload vimrc
autocmd! BufWritePost .vimrc source $MYVIMRC

" }}}

" Vista {{{

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

map <C-t> :Vista coc<CR>

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

" Insert <tab> when previous text is space, refresh completion if not.
" inoremap <silent><expr> <TAB>
"   \ coc#pum#visible() ? coc#pum#next(1):
"   \ <SID>check_back_space() ? "\<Tab>" :
"   \ coc#refresh()

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
nmap <leader>f <Plug>(coc-format)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
xmap <leader>f <Plug>(coc-format-selected)
" navigate conflicts of current buffer
nmap [c <Plug>(coc-git-prevconflict)
nmap ]c <Plug>(coc-git-nextconflict)

" 'coc-highlight' => Add this to support highlight
let g:coc_global_extensions = [
      \ 'coc-css',
      \ 'coc-diagnostic',
      \ 'coc-docker',
      \ 'coc-emoji',
      \ 'coc-git',
      \ 'coc-gocode',
      \ 'coc-html',
      \ 'coc-json',
      \ 'coc-pyright',
      \ 'coc-sh',
      \ 'coc-snippets',
      \ 'coc-sql',
      \ 'coc-tsserver',
      \ 'coc-yaml',
      \ ]

set sessionoptions+=globals
command! -range FormatShellCmd <line1>!~/.rc.d/format_shell_cmd.py
" }}}

" pcl/pkl {{{

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

" SuperTAB {{{

" let g:SuperTabDefaultCompletionType = "<c-n>"
" let g:SuperTabContextDefaultCompletionType = "<c-n>"

" }}}

" telescope.nvim {{{

lua << EOF
require('telescope').setup {}
EOF

nnoremap <C-f> <cmd>Telescope find_files<cr>
nnoremap <C-g> <cmd>Telescope live_grep<cr>

set rtp+=~/.fzf

" }}}

" bufferline.nvim {{{

map <Tab> :bn<cr>
map <S-Tab> :bp<cr>

lua << EOF
require('bufferline').setup {
  options = {
    mode        = "buffers",
    numbers     = "buffer_id",
    diagnostics = "coc",
    offsets     = {
      {
          filetype   = "NvimTree",
          text       = "File Explorer",
          text_align = "center",
      }
    },
  },
}
EOF

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

" Colors and Fonts {{{

set background=dark

" OneDark {{{
" let g:onedark_terminal_italics=1
" colorscheme onedark
" }}}

" XCode {{{

" Italic Comments

augroup vim-colors-xcode
  autocmd!
augroup END
autocmd vim-colors-xcode ColorScheme * hi Comment        cterm=italic gui=italic
autocmd vim-colors-xcode ColorScheme * hi SpecialComment cterm=italic gui=italic

let g:xcodedark_green_comments = 1
let g:xcodedark_dim_punctuation = 0

colorscheme xcodedark

" }}}

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

" Status line (lightline) {{{

" Always show the status line
set laststatus=2
set noshowmode " lightline shows insert

let g:lightline = {
      \ 'active': {
      \   'left': [
      \     ['mode', 'paste'],
      \     ['gitbranch', 'cocstatus', 'readonly', 'filename', 'modified'],
      \     ['vista'],
      \   ],
      \   'right': [
      \     ['lineinfo'],
      \     ['percent'],
      \     ['fileformat', 'fileencoding', 'filetype', 'anzustatus', 'scrollbar'],
      \   ]
      \ },
      \ 'enable': {
      \   'tabline': 0,
      \ },
      \ 'component_function': {
      \   'gitbranch': 'LightlineGit',
      \   'cocstatus': 'coc#status',
      \   'anzustatus': 'anzu#search_status',
      \   'vista': 'NearestMethodOrFunction',
      \ },
      \ 'colorscheme': 'one',
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
      \ }

function LightlineGit() abort
  return get(g:, 'coc_git_status', '')
endfunction

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

function! CmdLine(str)
  exe "menu Foo.Bar :" . a:str
  emenu Foo.Bar
  unmenu Foo
endfunction

function! VisualSelection(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

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
