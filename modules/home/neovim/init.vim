syntax on
filetype on
filetype plugin on
filetype indent on
command W w

" Keep selection after indent
vnoremap < <gv
vnoremap > >gv

map <C-M> V/###dGV/##d
lua require'impatient'
