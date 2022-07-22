set enc=utf-8
set nocompatible
set number
set mouse=a
set ignorecase
set smartcase
filetype plugin indent on
set tabstop=4 "show existing tab with 4 spaces width
set shiftwidth=4 "when indenting with '>', use 4 spaces width
set numberwidth=4 "change width of 'gutter' column used for numbering
set expandtab "on pressing tab, insert 4 spaces
"set clipboard^=unnamed,unnamedplus
"set cursorline "highlight current line
set viminfo='200,<50,s10,h
set backspace=indent,eol,start
set laststatus=2
set noruler
set wrap
set shiftround
set linebreak "prevent word from being split while wrapping
set ttimeoutlen=100 "fixes Shift-o lag :\
if v:version >= 900
    set wildoptions+=fuzzy
    "set wildoptions+=pum
endif

" search down into subfolders
set path+=**
set wildignore+=**/node_modules/*
set wildignore+=**/.git/*
set wildignore+=*.swp

"display all matching files when we tab complete
set wildmenu

vnoremap > >gv
vnoremap < <gv
" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

let mapleader = " "
set linespace=9 "for gui vim
set lazyredraw

call plug#begin('~/.vim/plugged')
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'scrooloose/nerdtree'
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'markonm/traces.vim'
    Plug 'mattn/emmet-vim'
    Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production', 'branch': 'release/0.x' }
    Plug 'godlygeek/tabular'
    Plug 'hrsh7th/vim-vsnip'
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

let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__', 'node_modules']
"let g:NERDTreeMinimalMenu = 1

nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTree %:h<CR>
nnoremap <leader>t :term<CR>
nnoremap <leader>dt :let $VIM_DIR=expand('%:p:h')<CR>:terminal<CR>cd $VIM_DIR<CR>
nnoremap <leader>z <c-z>
vnoremap <leader>c "+y
nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>vs :vnew<CR>
nnoremap <leader>sp :new<CR>
nnoremap <Tab> %

nnoremap <leader><leader>q :q!<CR>
nnoremap <leader><leader>s :source ~/.vimrc<CR>
nnoremap <leader><leader>v :tabe ~/.vimrc<CR>
nnoremap <leader><leader>z :tabe ~/.zshrc<CR>

"emmet
imap <C-p> <C-y>,

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

"fzf.vim
nnoremap <C-p> :Files<cr>
nnoremap <leader>f :BLines<cr>
nnoremap <leader>b :Lines<cr>
nnoremap <leader>r :Rg<cr>
nnoremap <leader>h :History<cr>
nnoremap <leader>sh :History/<cr>
nnoremap <leader>ch :History:<cr>
nnoremap <leader><Tab> :Buffers<cr>
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')
" Replace the default dictionary completion with fzf-based fuzzy completion
inoremap <expr> <c-x><c-k> fzf#vim#complete('cat /usr/share/dict/words')
imap <c-x><c-l> <plug>(fzf-complete-line)

"splits navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

let g:go_doc_popup_window = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_format_strings = 1
"let g:go_highlight_structs = 1
"let g:go_highlight_methods = 1
"let g:go_highlight_functions = 1
"let g:go_highlight_operators = 1
"let g:go_highlight_build_constraints = 1
"let g:go_highlight_function_parameters = 1
"let g:go_highlight_types = 1
"let g:go_highlight_fields = 1

" window resizing
nnoremap <leader><Up>    :resize -2<CR>
nnoremap <leader><Down>  :resize +2<CR>
nnoremap <leader><Left>  :vertical resize -2<CR>
nnoremap <leader><Right> :vertical resize +2<CR>

"title case
vnoremap tc :s/\<\(\w\)\(\w*\)\>/\u\1\L\2/g<CR>
"autocmd Filetype python set cursorcolumn
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"snippets
autocmd Filetype go ia <buffer> hfsig w http.ResponseWriter, r *http.Request

autocmd Filetype javascript,html,css set sw=2 sts=2
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.svelte,*.yaml,*.html PrettierAsync
autocmd Filetype c,cpp nnoremap <leader>p ggVG:!clang-format % --style=google<CR>:w<CR>

tnoremap <C-h> <C-w>h
tnoremap <C-j> <C-w>j
tnoremap <C-k> <C-w>k
tnoremap <C-l> <C-w>l
tnoremap <C-b> <C-\><C-n>

"vsnip settings
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)
