" vim:set ft=vim et sw=2:

execute pathogen#infect()
set nocompatible

" Tabbing
filetype plugin indent on

set autoindent
set smarttab

set expandtab
set shiftwidth=3
set softtabstop=3

autocmd FileType php setlocal expandtab shiftwidth=4 softtabstop=4

" General Vim Behavior
set scrolloff=3

set ttimeout
set ttimeoutlen=100

set laststatus=2
set ruler
set showcmd
set wildmenu

set display+=lastline

set completeopt=menuone,longest

set mouse=a

" Color, Appearance and Syntax
set background=dark
colorscheme base16-default

syntax on
set number

" Searching
set hlsearch
set incsearch

" Command Mode Keybindings
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" Insert Mode Keybindings
inoremap <C-u> <C-g>u<C-u>

