let mapleader=","
nnoremap <Leader>ev :50vsplit $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>

" Backup and swap directories
set backupdir=~/.vim/backup,.
set directory=~/.vim/swap,.

" Usual tab settings
" set tabstop=4
" set shiftwidth=4
" set softtabstop=4
" set expandtab

" Useful for long lines
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set nowrap

syntax on
set autoindent
set smartindent

set incsearch
set ignorecase
set smartcase
set hlsearch
nnoremap <Leader><Leader> :nohlsearch<CR>

set number
set relativenumber
" set textwidth=79
set textwidth=0
set colorcolumn=+1

set laststatus=2
set visualbell

" Don't try to fix the last line of the file by adding a newline
set noendofline
set nofixendofline

" For use with :set list
set listchars=eol:$,tab:>-

" Auto-select regexp engine for syntax highlighting
" Fixes long hangs for TypeScript files
set regexpengine=0

" Status line
" %-0{minwid}.{maxwid}{item}
set statusline=%<%f\ %h%w%q%m%r%=%-15.([%l:%c/%L][%p%%]%)%y

" fzf
if isdirectory('/usr/local/opt/fzf')
  set runtimepath+=/usr/local/opt/fzf
  nnoremap <Leader>f :FZF!<CR>

  command! -bang FZFB
    \ call fzf#run(
      \ fzf#wrap({
        \ 'source': map(getbufinfo({'buflisted': 1}), {_, buf -> buf.name }),
        \ 'sink': 'b'
      \ }, <bang>0)
    \ )
  nnoremap <Leader>b :FZFB!<CR>
endif

" Source local project settings if available
if filereadable('./saeid/project.vim')
  source ./saeid/project.vim
endif
