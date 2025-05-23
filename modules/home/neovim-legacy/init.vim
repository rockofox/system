syntax on
filetype on
filetype plugin on
filetype indent on
" command W w
command Wd w !diff % -

" Keep selection after indent
vnoremap < <gv
vnoremap > >gv

" map <leader>Ss :mksession! ~/vim_session <cr> " Quick write session
" map <leader>Sl :source ~/vim_session <cr>     " And load session

map <F2> :mksession! ~/vim_session <cr> " Quick write session
map <F3> :source ~/vim_session <cr>     " And load session
augroup kitty_mp
    autocmd!
    au VimLeave * :silent !kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=4
    au VimEnter * :silent !kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=0
augroup END

onoremap <expr> *  v:count ? '*'  : '<esc>*g``'.v:operator.'gn'

nnoremap <C-y> <C-W>h
nnoremap <C-n> <C-W>j
nnoremap <C-i> <C-W>k
nnoremap <C-o> <C-W>l
nnoremap <S-Enter> o<Esc>
nnoremap \ <C-o>
nnoremap \| <C-i>

set shellcmdflag=-ic
set shortmess+=W

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

let g:cursorhold_updatetime = 100
au BufNewFile,BufRead *.ejs set filetype=html
