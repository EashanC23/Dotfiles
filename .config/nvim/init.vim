set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
    source ~/.vimrc

set number
set nocompatible 
set encoding=UTF-8 
set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=4
set mouse=a

call plug#begin()
 Plug 'vim-airline/vim-airline'
 Plug 'pgdouyon/vim-alayas'
 Plug 'ryanoasis/vim-devicons'
 Plug 'scrooloose/nerdtree'
 Plug 'mhinz/vim-startify'
 Plug 'neoclide/coc.nvim' 
 Plug 'tc50cal/vim-terminal'
 Plug 'sheerun/vim-polyglot'
 Plug 'terryma/vim-multiple-cursors'
 Plug 'prettier/prettier'
 Plug 'w0rp/ale'
 " Languages 
 Plug 'pangloss/vim-javascript'
 Plug 'elzr/vim-json'
 Plug 'mxw/vim-jsx' 
 Plug 'MaxMEllon/vim-jsx-pretty'
 Plug 'leafgarland/typescript-vim' 
call plug#end()

:colorscheme nord

set completeopt-=preview 

nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"


inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"
