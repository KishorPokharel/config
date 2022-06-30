set enc=utf-8
set nocompatible
set number
filetype plugin indent on
set tabstop=4 "show existing tab with 4 spaces width
set shiftwidth=4 "when indenting with '>', use 4 spaces width
set numberwidth=4 "change width of 'gutter' column used for numbering
set expandtab "on pressing tab, insert 4 spaces
set cursorline "highlight current line
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

nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <leader>t :term<CR>
nnoremap <leader>z <c-z>
nnoremap <leader>c "+y
nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>
nnoremap <Tab> %

"ominfunc autocomplete
inoremap <C-\> <C-x><C-o>

"Keybindings for tab navigation with leader and number
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt

nnoremap <leader>0 :tablast<cr>
nnoremap <leader>x :tabclose<Cr>

"fzf
nnoremap <C-p> :Files<cr>
nnoremap <leader>f :BLines<cr>
nnoremap <leader>b :Lines<cr>
nnoremap <leader>r :Rg<cr>

"splits navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

let g:go_doc_popup_window = 1
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" window resizing
nnoremap <leader><Up>    :resize -2<CR>
nnoremap <leader><Down>  :resize +2<CR>
nnoremap <leader><Left>  :vertical resize -2<CR>
nnoremap <leader><Right> :vertical resize +2<CR>

"title case
vnoremap tc :s/\<\(\w\)\(\w*\)\>/\u\1\L\2/g<CR>
