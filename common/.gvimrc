" auto-source gvimrc
autocmd! BufWritePost .gvimrc source $MYGVIMRC
" Don’t blink cursor in normal mode
set guicursor=n:blinkon0
" Better line-height
set linespace=1
set guioptions-=T
set guioptions+=e
set t_Co=256
set guitablabel=%M\ %t
" Enable ligatures
if has("unix")
    let s:uname = system("uname -s")
    if s:uname == "Darwin\n"
        " set macligatures
    endif
endif
set guifont=OperatorMonoSSmLig\ NF:h18

