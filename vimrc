let mapleader=","
nnoremap <Leader>ev :50vsplit $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>

syntax on
set autoindent
set smartindent

set laststatus=2
set relativenumber
set colorcolumn=80

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set ignorecase
set smartcase
set hlsearch
set incsearch
nnoremap <Leader>n :nohlsearch<CR>

" %-0{minwid}.{maxwid}{item}
set statusline=%<%f\ %h%w%q%m%r%=%-15.([%l:%c/%L][%p%%]%)%y
