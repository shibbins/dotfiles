" config file for either nvim or vim
set nocompatible                " Enable Vim specific features

" Only load plugins when not running as root
if $USER != "root"
  " Load Plugins with vim-plug
  if has("nvim")
    call plug#begin('~/.config/nvim/plugged')
    Plug 'nvim-lualine/lualine.nvim'
  else
    call plug#begin('~/.vim/plugged')
    Plug 'itchyny/lightline.vim'
  endif

  Plug 'christoomey/vim-tmux-navigator'
  Plug 'edkolev/tmuxline.vim'
  Plug 'fatih/vim-go'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'mhinz/vim-signify'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'sbdchd/neoformat'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'vimwiki/vimwiki'

  Plug 'ryanoasis/vim-devicons'

  call plug#end()
  " Install CoC extensions if not present
  let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-rust-analyzer',
    \ 'coc-snippets',
    \ ]
endif


""""""""""""""""""""""
"      Settings      "
""""""""""""""""""""""

set autoindent                  " Enable Autoindent
set autoread                    " Automatically read changed files
set autowrite                   " Automatically save before :next, :make etc.
set backspace=indent,eol,start  " Makes backspace key more powerful.
set cmdheight=2                 " Better display for messages
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
set nowritebackup               " Some language servers have issues with backup files
set pumheight=10                " Completion window max size
set showcmd                     " Show me what I'm typing
set shortmess+=c                " Don't give |ins-completion-menu| messages
set signcolumn=yes              " Always show the sign column
set smartcase                   " Don't be case insensitive when search begins with upper case
set splitright                  " Vertical windows should be split to right
set splitbelow                  " Horizontal windows should split to bottom
set ttyfast                     " Indicate fast terminal conn for faster redraw
set updatetime=300              " You will have a bad experience with diagnostic messages when it's default (4000)
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
set background=light
set termguicolors
colorscheme solarized8


""""""""""""""""""""""
"      Mappings      "
""""""""""""""""""""""

let mapleader = ' '
nnoremap ; :
inoremap jk <Esc>
nnoremap <CR> :noh<CR>
nnoremap <Leader>ag :Ag <C-R><C-W><CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>h :History<CR>
nnoremap <Leader>rg :Rg <C-R><C-W><CR>
nnoremap <Leader><Enter> :Buffers<CR>

" Move between splits
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

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

" COC vim gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

""""""""""""""""""""""
"  Plugin settings   "
""""""""""""""""""""""

" Coc settings

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by another plugin.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Navigate snippet placeholders using tab
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

" Use enter to accept snippet expansion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"

" Enable fzf for fuzzy finding
set rtp+=~/.fzf
let $FZF_DEFAULT_COMMAND='rg --files --hidden --follow --smart-case --glob "!{.git,.hg}"'

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
  autocmd FileType go nmap <leader>gb <Plug>(go-build)
  " :GoTest
  autocmd FileType go nmap <leader>gt  <Plug>(go-test)
  " :GoRun
  autocmd FileType go nmap <leader>gr  <Plug>(go-run)
  " :GoDoc
  autocmd FileType go nmap <Leader>gd <Plug>(go-doc)
  " :GoCoverageToggle
  autocmd FileType go nmap <Leader>gc <Plug>(go-coverage-toggle)
  " :GoInfo
  autocmd FileType go nmap <Leader>gi <Plug>(go-info)
  " :GoMetaLinter
  autocmd FileType go nmap <Leader>gl <Plug>(go-metalinter)
  " :GoDef but opens in a vertical split
  autocmd FileType go nmap <Leader>gdv <Plug>(go-def-vertical)
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
"     Statusline     "
""""""""""""""""""""""

if has("nvim")
lua << EOF
require'lualine'.setup {
  options = {
    theme = 'solarized_light',
    component_separators = {left = '|', right = '|'},
  },
  sections = {
    lualine_x = {'fileformat', 'encoding', 'filetype'},
  },
}
EOF
else
  let g:lightline = {
        \ 'colorscheme': 'solarized',
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
endif

if filereadable(expand('~/.vimrc_local'))
    source ~/.vimrc_local
endif

