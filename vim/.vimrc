" vim:set ft=vim et sw=2:

set nocompatible
filetype off

" Vundle!
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'bling/vim-airline'
Plugin 'chriskempson/base16-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-vinegar'
call vundle#end()

" Plugin Configuration
" Nothing here

" Default Tabbing
filetype plugin indent on

set autoindent
set smarttab

set expandtab
set shiftwidth=3
set softtabstop=3

" Status Line
set laststatus=2
set ruler
set showcmd

" Editor Display
set display+=lastline
set scrolloff=3

set colorcolumn=80

set listchars=tab:▸\ ,eol:¬,trail:⋅,nbsp:⋅

" Input Configuration
set ttimeout
set ttimeoutlen=100

set mouse=a
set backspace=2

" Insert Mode
set nrformats-=octal
set completeopt=menuone,longest

" Command Mode
set wildmenu
set wildmode=list:longest,full

" Vim Behaviour
set autoread
set history=1000
set undolevels=16384
set clipboard=unnamed

" netrw
let g:netrw_bufsettings='noma nomod nu relativenumber nowrap ro nobl'
let g:netrw_banner=0

" Color, Appearance and Syntax
set background=dark
colorscheme base16-default

syntax on
set number
set relativenumber

" Searching
set hlsearch
set incsearch

" Keybindings
nmap <space> <leader>
vmap <space> <leader>

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

noremap <silent> <leader>j :cn<CR>
noremap <silent> <leader>k :cp<CR>
noremap <silent> <leader>l :clist<CR>

nnoremap <silent> <leader>s :setlocal list!<CR>

nnoremap <silent> <leader>w :w<CR>
nnoremap <silent> <leader><CR> :nohlsearch<CR>

inoremap <C-u> <C-g>u<C-u>

nnoremap <silent> <leader>n :set relativenumber!<CR>

nnoremap <silent> <leader>b :CtrlPBuffer<CR>
nnoremap <silent> <leader>v :CtrlPMRU<CR>

" Filetype specific commands
autocmd FileType php setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType puppet setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType ruby setlocal expandtab shiftwidth=2 softtabstop=2
