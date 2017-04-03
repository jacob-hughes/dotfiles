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
Plugin 'scrooloose/syntastic'
Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-surround'
Plugin 'jlanzarotta/bufexplorer'
call vundle#end()            " required
filetype plugin indent on    " required
syntax on
set nu

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
colorscheme gruvbox
set background=dark

set t_Co=256
set hidden
let g:airline_powerline_fonts = 1

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

" strip whitespace at the end of a line upon write
if !exists("autocommands_loaded")
      let autocommands_loaded = 1
        autocmd BufRead,BufNewFile *.php setlocal dict+=~/.vim/bundle/vim-php-dictionary/dict/PHP.dict
          autocmd BufWritePre * :%s/\s\+$//e
      endif
