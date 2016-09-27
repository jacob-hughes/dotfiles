set nocompatible              " be iMproved, required
filetype off                  " required
set encoding=utf-8

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-surround'
Plugin 'wincent/command-t'
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
set t_Co=256
set hidden
let g:airline_powerline_fonts = 1


set backupdir=~/.vim/var/backup//
set directory=~/.vim/var/swap//
set undodir=~/.vim/var/undo//

