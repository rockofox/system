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

nnoremap <C-y> <C-W>h
nnoremap <C-n> <C-W>j
nnoremap <C-i> <C-W>k
nnoremap <C-o> <C-W>l
nnoremap <leader>bd <cmd>bd<cr>
set shellcmdflag=-ic

if has('nvim')
  augroup vimrc_term
    autocmd!
    autocmd WinEnter term://* nohlsearch
    autocmd WinEnter term://* startinsert

    autocmd TermOpen * tnoremap <buffer> <C-y> <C-\><C-n><C-w>h
    autocmd TermOpen * tnoremap <buffer> <C-n> <C-\><C-n><C-w>j
    autocmd TermOpen * tnoremap <buffer> <C-i> <C-\><C-n><C-w>k
    autocmd TermOpen * tnoremap <buffer> <C-o> <C-\><C-n><C-w>l
    autocmd TermOpen * tnoremap <buffer> <Esc> <C-\><C-n>
  augroup END
endif
