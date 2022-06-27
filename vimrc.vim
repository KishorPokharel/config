set enc=utf-8
set nocompatible
set number
filetype plugin indent on
set tabstop=4 "show existing tab with 4 spaces width
set shiftwidth=4 "when indenting with '>', use 4 spaces width
set numberwidth=4 "change width of 'gutter' column used for numbering
set expandtab "on pressing tab, insert 4 spaces
set ttimeoutlen=100

" search down into subfolders
set path+=**
set wildignore+=**/node_modules/*
set wildignore+=**/.git/*

"display all matching files when we tab complete
set wildmenu

let mapleader = " "
set linespace=9 "for gui vim
set lazyredraw

call plug#begin('~/.vim/plugged')
    Plug 'tpope/vim-commentary'
    Plug 'scrooloose/nerdtree'
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'markonm/traces.vim'
    Plug 'mattn/emmet-vim'
call plug#end()

colorscheme ghdarkcustom

syntax on
highlight Normal ctermbg=None
highlight LineNr ctermfg=DarkGrey
highlight Comment ctermfg=DarkGrey

" for gui vim
highlight LineNr guifg=DarkGrey
highlight Comment guifg=DarkGrey
"end for gui vim

map <C-n> :NERDTree<CR>
map <leader>t :NERDTreeToggle<CR>
map <leader>z <c-z>
map <leader>c "+y
map <leader>q :q<CR>
map <leader>w :w<CR>

"Keybindings for tab navigation with leader and number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt

noremap <leader>0 :tablast<cr>
nnoremap <leader>x :tabclose<Cr>

noremap <C-p> :Files<cr>

"splits navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

let g:go_doc_popup_window = 1
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
