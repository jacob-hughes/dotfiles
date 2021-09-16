" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'joshdick/onedark.vim'             " Onedark colorscheme
Plug 'scrooloose/nerdtree'              " Directory tree
Plug 'tpope/vim-fugitive'               " Git extras (e.g. branches)
Plug 'itchyny/lightline.vim'            " Lightline
Plug 'bling/vim-bufferline'             " Show the list of buffers in the command bar
Plug 'tpope/vim-commentary'             " Easy un/commenting
Plug 'mhinz/vim-signify'                " Show diff +/- signs on LHS of screen
Plug 'christoomey/vim-tmux-navigator'   " Hop between tmux and vim splits
Plug 'rust-lang/rust.vim'               " Needed for ALE
Plug 'ntpeters/vim-better-whitespace'   " Highlight whitespace at end of lines
Plug 'airblade/vim-rooter'              " Change wd inside vim to project root
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'                 " FZF vim plugin
Plug 'Chiel92/vim-autoformat'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'vimwiki/vimwiki'
call plug#end()

autocmd FileType tex ALEDisable


" General settings
set smartcase                      " Ignores case when all lowercase, cs if uppercase included.
set number                         " Show line numbers
set cursorline                     " Highlight current line
set nowrap                         " Don't wrap lines
set hidden                         " Hide buffers
set mouse+=a                       " Enable mouse
set ignorecase                     " Case insensitive search
set smartcase                      " Case sensitive when not lowercase
set autoread                       " Auto reload changed files
set expandtab                      " Use spaces
set tabstop=4                      " insert 4 spaces for tab
set softtabstop=3                  " show tab as 4 spaces
set shiftwidth=4                   " Indentation space
set autoindent                     " Copy indent from prev line
set textwidth=80
set signcolumn=yes                 " Always show the signcolumn, otherwise it would shift the text each time
                                   " diagnostics appear/become resolved.

let g:onedark_termcolors=16
colorscheme onedark
set colorcolumn=80

" Share Unix clipboard
set clipboard+=unnamedplus

" Automatically reload changed files
set autoread
au FocusGained * :checktime

" NERDTree
nnoremap <leader>df :NERDTreeFocus<CR>
nnoremap <leader>dt :NERDTreeToggle<CR>

" Rust
let g:rust_recommended_style = 0

" Lightline
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }

" Bufferline
let g:bufferline_echo = 0
let g:bufferline_rotate = 2
let g:bufferline_fname_mod = ':.'
nmap <C-Left> :bp!<CR>
imap <C-Left> <C-o>:bp!<CR>
nmap <C-Right> :bn!<CR>
imap <C-Right> <C-o>:bn!<CR>

" Ale settings
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
let g:ale_rust_cargo_check_all_targets = 1
let b:ale_linters = {'rust': ['rls']}
let g:ale_rust_rls_toolchain = 'nightly'
let g:ale_fixers = {'rust': ['rustfmt']}
let g:ale_completion_enabled = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
nmap <Leader>j <Plug>(ale_previous_wrap)
nmap <Leader>k <Plug>(ale_next_wrap)
highlight link ALEWarningSign String
highlight link ALEErrorSign Title

" GitGutter
let g:gitgutter_override_sign_column_highlight = 0

" FZF settings
" Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" Customise options used by 'git log'
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
" Command to generate tags file
let g:fzf_tags_command = 'ctags -R'
" --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'
let $FZF_DEFAULT_COMMAND = 'ag -g ""' " respect gitignore

" Prevent filenames from showing up in :Ag results
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

nmap <Leader>f :Files<CR>
nmap <Leader>/ :Lines<CR>
nmap <Leader>b :Buffers<CR>
nnoremap gs :Rg <C-R><C-W><Cr>

" Filetype settings
filetype indent plugin on           " Load plugin/indent files

" Latex specific settings
let g:tex_flavor='latex'
let s:extfname = expand("%:e")
if s:extfname ==? "tex"
    let g:LatexBox_split_type = "new"
    let g:ale_set_highlights = 0
    nmap <F8> :make! quick<CR>:!xdotool search --onlyvisible mupdf key "r"<CR>
    nmap <F9> :make!<CR>:!xdotool search mupdf key "r"<CR>
    nmap <F5> :LatexTOC<CR>
    setl noai nocin nosi inde=      " Disable auto indentation
endif

" Wiki settings
set nocompatible
filetype plugin on
syntax on
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0

" =========================== COC Settings ====================================

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Use tab for autocompletion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Formatting code
let g:python3_host_prog='/usr/bin/python'
noremap <F3> :Autoformat<CR>

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
