syntax on
filetype on
filetype plugin on
filetype indent on
command W w

" Keep selection after indent
vnoremap < <gv
vnoremap > >gv

map <F2> :mksession! ~/vim_session <cr> " Quick write session with F2
map <F3> :source ~/vim_session <cr>     " And load session with F3

augroup kitty_mp
    autocmd!
    au VimLeave * :silent !kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=4
    au VimEnter * :silent !kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=0
augroup END

map <C-M> V/###dGV/##d
onoremap <expr> *  v:count ? '*'  : '<esc>*g``'.v:operator.'gn'
lua require'impatient'
