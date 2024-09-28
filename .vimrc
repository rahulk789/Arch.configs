syntax on
set encoding=utf-8
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set nu
set smartindent
set undodir=~/.vim/undodir
set undofile
set smartcase
set noswapfile
set nobackup
set cursorline

" or leave the argument empty, download vim-plug through a curl command
 call plug#begin('~/.vim/plugged')
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'preservim/nerdtree'
 call plug#end()

autocmd VimEnter * NERDTree | wincmd p
hi CursorLine cterm=NONE ctermbg=black
hi CursorLineNr cterm-NONE ctermbg=black ctermfg=darkred
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
nnoremap <C-q> :NERDTreeFocus<CR>

nnoremap <C-g> :call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case ""', 1, fzf#vim#with_preview(), 0)<CR>

nnoremap <C-s> :Files<CR>





