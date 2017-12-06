set nocompatible              " be iMproved, required
filetype off                  " required

" proper vim spacing
set ai
set ts=4
set sts=4
set et
set sw=4
set encoding=utf-8

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'w0rp/ale'
Plugin 'morhetz/gruvbox'
Plugin 'itchyny/lightline.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'racer-rust/vim-racer'
Plugin 'tpope/vim-commentary'
Plugin 'tomasr/molokai'
Plugin 'tpope/vim-surround'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'junegunn/fzf.vim'
Plugin 'airblade/vim-rooter'
call vundle#end()            " required
filetype plugin indent on    " required
syntax on
set nu

" Signs column (gutter) background colour
"let g:gitgutter_override_sign_column_highlight = 0
"highlight SignColumn ctermbg=None

" Quickly open fuzzy finding in fzf
nmap ; :Buffers<CR>
nmap <Leader>f :Files<CR>
nmap <Leader>r :Tags<CR>

" Allow backspace for more than current insert
set backspace=indent,eol,start

" Autocomplete longest match
set wildmenu
set wildmode=list:longest

" Code folding
set foldmethod=indent

" NERDTree
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" Open and focus mappings for NERDTree
nnoremap <leader>df :NERDTreeFocus<CR>
nnoremap <leader>dt :NERDTreeToggle<CR>

let g:molokai_original=1
let g:rehash256=1
colorscheme molokai
set t_Co=256

" GitGutter and Ale styling
let g:gitgutter_override_sign_column_highlight = 0
hi clear SignColumn
hi LineNr ctermbg=None
hi GitGutterAdd ctermbg=None ctermfg=green
hi GitGutterChange ctermbg=None ctermfg=yellow
hi GitGutterDelete ctermbg=None ctermfg=red

" Remove black bg from vsplit bar
hi VertSplit ctermbg=None

set hidden

" Custom backup / swap / undo dirs

if !isdirectory($HOME.'/.vim/var/backup/')
    call mkdir($HOME.'/.vim/var/backup/', 'p')
endif
if !isdirectory($HOME.'/.vim/var/swap/')
    call mkdir($HOME.'/.vim/var/swap/', 'p')
endif
if !isdirectory($HOME.'/.vim/var/undo/')
    call mkdir($HOME.'/.vim/var/undo/', 'p')
endif

set backupdir=~/.vim/var/backup//
set directory=~/.vim/var/swap//
set undodir=~/.vim/var/undo//

" pep8 line margin display

if exists('+colorcolumn')
    set colorcolumn=80
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Turn off linewise keys. Normally, the `j' and `k' keys move the cursor down one entire line. with
" line wrapping on, this can cause the cursor to actually skip a few lines on the screen because
" it's moving from line N to line N+1 in the file.
nmap j gj
nmap k gk

" Ale
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
highlight link ALEWarningSign String
highlight link ALEErrorSign Title

" strip whitespace at the end of a line upon write
if !exists("autocommands_loaded")
      let autocommands_loaded = 1
        autocmd BufRead,BufNewFile *.php setlocal dict+=~/.vim/bundle/vim-php-dictionary/dict/PHP.dict
          autocmd BufWritePre * :%s/\s\+$//e
      endif
