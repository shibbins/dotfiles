" config file for either nvim or vim

" Load Plugins with vim-plug
call plug#begin('.vim/plugged')

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'
Plug 'fatih/vim-go'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-signify'
Plug 'Raimondi/delimitMate'
Plug 'sbdchd/neoformat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'zchee/deoplete-jedi'

Plug 'ryanoasis/vim-devicons'

call plug#end()


""""""""""""""""""""""
"      Settings      "
""""""""""""""""""""""

set nocompatible                " Enables us Vim specific features
filetype off                    " Reset filetype detection first ...
filetype plugin indent on       " ... and enable filetype detection

set autoindent                  " Enabile Autoindent
set autoread                    " Automatically read changed files
set autowrite                   " Automatically save before :next, :make etc.
set backspace=indent,eol,start  " Makes backspace key more powerful.
set completeopt=menu,menuone    " Show popup menu, even if there is one entry
set encoding=utf-8              " Set default encoding to UTF-8
set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats
set hidden                      " Buffer should still exist if window is closed
set hlsearch                    " Highlight found searches
set ignorecase                  " Search case insensitive
set incsearch                   " Shows the match while typing
set laststatus=2                " Show status line always
set lazyredraw                  " Wait to redraw
set noerrorbells                " No beeps
set nobackup                    " Don't create annoying backup files
set nocursorcolumn              " Do not highlight column (speeds up highlighting)
set nocursorline                " Do not highlight cursor (speeds up highlighting)
set nonumber                    " Do not show line numbers
set noshowmatch                 " Do not show matching brackets by flickering
set noshowmode                  " We show the mode with airline or lightline
set noswapfile                  " Don't use swapfile
set pumheight=10                " Completion window max size
set showcmd                     " Show me what I'm typing
set smartcase                   " Don't be case insensitive when search begins with upper case
set splitright                  " Vertical windows should be split to right
set splitbelow                  " Horizontal windows should split to bottom
set ttyfast                     " Indicate fast terminal conn for faster redraw
set viminfo='1000               " Set oldfiles to 1000 last recently opened files

if !has('nvim')
  set ttymouse=xterm2           " Indicate terminal type for mouse codes
  set ttyscroll=3               " Speedup scrolling
endif

" This enables us to undo files even if you exit Vim.
if has('persistent_undo')
  set undofile
  set undodir=~/.vim/tmp/undo/
endif


" Colorscheme
set background=dark
set termguicolors
colorscheme solarized8


""""""""""""""""""""""
"      Mappings      "
""""""""""""""""""""""

let mapleader = ' '
nnoremap ; :
inoremap jk <Esc>
nnoremap <Leader>ag :Ag <C-R><C-W><CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader><Enter> :Buffers<CR>

" Move between splits
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

" Create new splits
nnoremap <silent><leader>v- <C-w>S
nnoremap <silent><leader>vv <C-w>v

" Disable Arrow keys in Escape mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Disable Arrow keys in Insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>


""""""""""""""""""""""
"  Plugin settings   "
""""""""""""""""""""""

" Enable fzf for fuzzy finding
set rtp+=~/.fzf
let $FZF_DEFAULT_COMMAND='ag -g ""'

let g:ale_lint_on_text_changed = 'never'
let g:ale_linters = {
\   'go': ['golint', 'govet'],
\   'python': ['pycodestyle'],
\   'proto': ['protoc-gen-lint']
\}
let g:ale_linters_explicit = 1
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'

let g:deoplete#enable_at_startup = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

let g:deoplete#sources#go#unimported_packages = 1

let g:go_fmt_command = "goimports"
let g:go_highlight_types = 0
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 0
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

let g:signify_vcs_list = [ 'git', 'hg' ]

let g:tmuxline_theme = 'lightline_insert'


""""""""""""""""""""""
"   Auto commands    "
""""""""""""""""""""""

augroup autoformat
  autocmd!
  " Autoformat c and c++ files on write.
  autocmd BufWritePre *.c,*.cc,*.h undojoin | Neoformat
  " Autoformat go files on write.
  autocmd BufWritePre *.json undojoin | Neoformat
  " Autoformat proto files on write.
  autocmd BufWritePre *.proto undojoin | Neoformat
  " Autoformat rust files on write.
  autocmd BufWritePre *.rs undojoin | Neoformat
  " Autoformat shell files on write.
  autocmd BufWritePre *.sh undojoin | Neoformat
augroup END

augroup json
  autocmd!
  " Use 4 spaces for tabs
  autocmd Filetype json set autoindent expandtab tabstop=4 shiftwidth=4 
augroup END

augroup go
  autocmd!
  " Make tabs 1/2 size in Go files.
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab shiftwidth=4 tabstop=4 
  " :GoBuild
  autocmd FileType go nmap <leader>b <Plug>(go-build)
  " :GoTest
  autocmd FileType go nmap <leader>t  <Plug>(go-test)
  " :GoRun
  autocmd FileType go nmap <leader>r  <Plug>(go-run)
  " :GoDoc
  autocmd FileType go nmap <Leader>d <Plug>(go-doc)
  " :GoCoverageToggle
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
  " :GoInfo
  autocmd FileType go nmap <Leader>i <Plug>(go-info)
  " :GoMetaLinter
  autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)
  " :GoDef but opens in a vertical split
  autocmd FileType go nmap <Leader>dv <Plug>(go-def-vertical)
  " :GoDef but opens in a horizontal split
  autocmd FileType go nmap <Leader>ds <Plug>(go-def-split)
augroup END

augroup python
  autocmd!
  " Settings for Python files.
  autocmd FileType python setlocal autoindent expandtab shiftwidth=4 tabstop=4 cinwords=if,elif,else,for,while,try,except,finally,def,class,with
  " Highlight columns 81 and onwards 
  autocmd Filetype python let colorcolumn=join(range(81,999),",") 
  " Remove traling whitespace on exit
  autocmd BufWritePre *.py :%s/\s\+$//e                                    
augroup END


""""""""""""""""""""""
"     Lightline      "
""""""""""""""""""""""

let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'filetype': 'MyFiletype',
      \   'fileformat': 'MyFileformat',
      \   'filepath': 'MyFilepath',
      \ }
      \ }

function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
    return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! MyFilepath()
    return expand('%:p:h')
endfunction
