" First use baseline vim config
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

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

" ripgrep
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  set grepformat=%f:%l:%c:%m
endif

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
nnoremap <Leader>. :set list!<CR>

" Auto-select regexp engine for syntax highlighting
" Fixes long hangs for TypeScript files
set regexpengine=0

" Status line
" %-0{minwid}.{maxwid}{item}
set statusline=%<%f\ %h%w%q%m%r%=%-15.([%l:%c/%L][%p%%]%)%y
set showcmd " Show typed keys in status line

" Buffer navigation
nnoremap <Leader>] :bnext<CR>
nnoremap <Leader>[ :bprevious<CR>

" fzf
if executable('fzf')
  set runtimepath+=/Users/swazzan/.nix-profile/share/vim-plugins/fzf/
  " Use :FZF! for fullscreen
  nnoremap <Leader>f :FZF<CR>

  command! -bang FZFB
    \ call fzf#run(
      \ fzf#wrap({
        \ 'source': map(getbufinfo({'buflisted': 1}), {_, buf -> buf.name != "" ? buf.name : buf.bufnr }),
        \ 'sink': 'b'
      \ }, <bang>0)
    \ )

  " Use :FZFB! for fullscreen
  nnoremap <Leader>b :FZFB<CR>
endif

" ALE
" These need to be defined before loading plugins
" let g:ale_completion_enabled=1
" set omnifunc=ale#completion#OmniFunc

" Plugin loading
" packloadall
" packadd! vimspector
" silent! helptags ALL

" if exists(":ALEInfo")
"   nnoremap <Leader>ag :ALEGoToDefinition<CR>
"   nnoremap <Leader>ar :ALEFindReferences -quickfix<CR>
"   nnoremap <Leader>af :ALEFirst<CR>
"   nnoremap <Leader>an :ALENext<CR>
" 
"   let g:ale_fixers = {
"   \ 'typescript': [
"   \   'eslint',
"   \   'prettier',
"   \ ],
"   \ }
" endif

call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'github/copilot.vim'

call plug#end()

" Vimspector setup
" let g:vimspector_enable_mappings = 'HUMAN'
let g:vimspector_base_dir='~/.vim/pack/vimspector/opt/vimspector'
nnoremap <Leader>dl :call vimspector#Launch()<CR>
nnoremap <Leader>dr :call vimspector#Reset()<CR>
nnoremap <Leader>dc :call vimspector#Continue()<CR>
nnoremap <Leader>db :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dB :call vimspector#ClearBreakpoints()<CR>
nnoremap <Leader>di <Plug>VimspectorStepInto
nnoremap <Leader>do <Plug>VimspectorStepOut
nnoremap <Leader>ds <Plug>VimspectorStepOver

" Make a new scratch buffer
function! MakeScratch()
  let ft = input("File type: ", "sql")
  try
    enew
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile

    let &l:filetype = ft
  endtry
endfunction

nnoremap <Leader>sc :call MakeScratch()<CR>

" Source local project settings if available
if filereadable('./saeid/project.vim')
  source ./saeid/project.vim
endif

" Time logging
let s:timelog = '~/time/2023.timedot'

function! OpenTimeLog()
  exe "50vsplit " .. s:timelog
endfunction

if filereadable(expand(s:timelog))
  nnoremap <Leader>t :call OpenTimeLog()<CR>
endif

source ~/.vim/coc-mappings.vim
source ~/.vim/kitty.vim
