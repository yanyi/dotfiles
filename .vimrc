""""""""""""""""""""""""""""""""""""""""""""
" General Settings
""""""""""""""""""""""""""""""""""""""""""""
" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" Height of the command bar
set cmdheight=2

set encoding=utf8
set number
""""""""""""""""""""""""""""""""""""""""""""
" Color Settings
""""""""""""""""""""""""""""""""""""""""""""
syntax on
set background=dark

""""""""""""""""""""""""""""""""""""""""""""
" Git Settings
""""""""""""""""""""""""""""""""""""""""""""
set noswapfile
autocmd Filetype gitcommit setlocal spell textwidth=72
