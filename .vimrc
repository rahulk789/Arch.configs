syntax on
set encoding=utf-8
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set undodir=~/.vim/undodir
set undofile
set nowrap
set smartcase
set noswapfile
set nobackup
set cursorline

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'https://github.com/Valloric/YouCompleteMe.git'
Plug 'lyuts/vim-rtags'
Plug 'https://github.com/kien/ctrlp.vim.git'
Plug 'mbbill/undotree'
Plug 'https://github.com/srcery-colors/srcery-vim'

call plug#end()

let g:srcery_bg_passthrough = 1
colorscheme srcery
set background=dark
let g:lightline = {
      \ 'colorscheme': 'srcery',
      \ }






