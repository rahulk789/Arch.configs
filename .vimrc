syntax on
set encoding=utf-8
set noerrorbells
" set expandtab
" set smartindent
set signcolumn=yes
set undodir=~/.vim/undodir
set undofile
set smartcase
set noswapfile
set nobackup
set cursorline
hi CursorLineNr cterm=NONE ctermbg=black ctermfg=darkred
hi CursorLine cterm=NONE ctermbg=black

call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ficcdaf/ashen.nvim'
Plug 'rebelot/kanagawa.nvim'
Plug 'sho-87/kanagawa-paper.nvim'
Plug 'sainnhe/gruvbox-material'
Plug 'puremourning/vimspector'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
Plug 'psliwka/vim-smoothie'
Plug 'David-Kunz/gen.nvim'
"Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'josa42/coc-sh'
Plug 'editorconfig/editorconfig-vim'
Plug 'sebdah/vim-delve'
call plug#end()

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

colorscheme kanagawa

highlight Normal guibg=none
highlight NonText guibg=none
highlight Normal ctermbg=none
highlight NonText ctermbg=none


filetype plugin indent on
nnoremap <C-s> :Files<CR>
nnoremap <C-q> :q!<CR>

" Initialize configuration dictionary
let g:fzf_vim = {}

let g:fzf_vim.preview_window = []
let g:fzf_layout = { 'down': '~33%' }

" Remove or comment out this if it exists
" command! -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)

" Use FZF's live grep with ripgrep to search for text dynamically in files
" Most probably you wont be using this and you would be using gr gd stuff!!
noremap <C-g> :call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case ""', 1, fzf#vim#with_preview(), 0)<CR>

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'distinguished'

highlight GitGutterAdd    guifg=#22863a ctermfg=2
highlight GitGutterChange guifg=#d29922 ctermfg=3
highlight GitGutterDelete guifg=#cb2431 ctermfg=1
highlight SignColumn guibg=NONE ctermbg=NONE

highlight CocFloating guibg=#000000 ctermbg=0
highlight CocHighlightText guibg=#333333 ctermbg=0
highlight CocHighlightRead guibg=#333333 ctermbg=0
highlight CocHighlightWrite guibg=#333333 ctermbg=0
inoremap <expr> <CR> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
autocmd BufWritePre *.go :call CocAction('format')

nnoremap <C-p> :Commentary<CR>
vnoremap <C-p> :Commentary<CR>

nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
nnoremap <M-x> <C-w>x
nnoremap <silent> <Tab> :bnext<CR>
nnoremap <silent> <S-Tab> :bprevious<CR>
nnoremap <silent> <C-n> :tabnew<CR>
nnoremap <silent> <C-Right> :tabnext<CR>
nnoremap <silent> <C-Left> :tabprevious<CR>
