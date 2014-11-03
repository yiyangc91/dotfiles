" vim:set ft=vim et sw=2:

execute pathogen#infect()
set nocompatible
filetype off

call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'bling/vim-airline'
Plugin 'chriskempson/base16-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
call vundle#end()

" Plugin Configuration
let g:airline#extensions#tabline#enabled = 1

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

set listchars=tab:▸\ ,eol:¬,trail:x

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

" Color, Appearance and Syntax
set background=dark
colorscheme base16-default

syntax on
set number

" Searching
set hlsearch
set incsearch

" Keybindings
nmap <space> <leader>

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

noremap <leader>n :cn<CR>
noremap <leader>p :cp<CR>

nnoremap <silent> <leader>l :setlocal list!<CR>

nnoremap <leader>w :w<CR>
nnoremap <silent> <leader><CR> :nohlsearch<CR>

inoremap <C-u> <C-g>u<C-u>

" Filetype specific commands
autocmd FileType php setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType puppet setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType ruby setlocal expandtab shiftwidth=2 softtabstop=2
