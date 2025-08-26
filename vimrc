set nocompatible

" Settings for coc.nvim
set encoding=utf-8
set updatetime=300
set nobackup
set nowritebackup

" Persistent Undo and setting the undo directory to the tmp folder
set undofile
set undodir^=$HOME/.vim/tmp//

" Will let us change buffers without saving
set hidden
" Will save the swap file to a separate temp folder instead of leaving them all
" over the place
set directory^=$HOME/.vim/tmp//

set relativenumber
set number
set showcmd

set showmatch
set nohlsearch
set smartcase
set ignorecase
set incsearch

set expandtab
set smartindent
set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=4

set termguicolors
" colorscheme murphy
" colorscheme zaibatsu
" highlight Normal ctermbg=NONE guibg=NONE
" highlight CursorLine ctermbg=BLACK guibg=BLACK ctermfg=WHITE guifg=WHITE
" highlight EndOfBuffer ctermbg=NONE guibg=NONE
" highlight LineNr ctermbg=None guibg=None ctermfg=White guifg=White
" highlight CursorLineNr ctermbg=Black guibg=Black ctermfg=White guifg=White

set laststatus=2

au BufRead,BufNewFile *.md setlocal textwidth=80
au BufRead,BufNewFile *.tex setlocal textwidth=80

set wrap
set scrolloff=8

" syntax off
syntax on
filetype plugin indent on

" set clipboard=unnamed

set wildmode=longest,list,full

set ruler

set path+=**
set wildoptions=pum
set wildmenu

let g:netrw_banner=0
let g:netrw_liststyle=3

let mapleader=" "
nnoremap <Leader>e :Ex<cr>
" Started using fzf so no need for this anymore
" nnoremap <Leader>ff :find 
" nnoremap <Leader>v :!inlyne %<cr>

" Surround functions
vnoremap <Leader>s" c"<C-R>""<esc>
vnoremap <Leader>s' c'<C-R>"'<esc>
vnoremap <Leader>s* c*<C-R>"*<esc>
vnoremap <Leader>s$ c$<C-R>"$<esc>
vnoremap <Leader>sb c(<C-R>")<esc>
vnoremap <Leader>s( c(<C-R>")<esc>
vnoremap <Leader>sB c{<C-R>"}<esc>
vnoremap <Leader>s{ c{<C-R>"}<esc>
vnoremap <Leader>s[ c[<C-R>"]<esc>
vnoremap <Leader>s< c<<C-R>"><esc>

" Delete Surround functions
nnoremap <Leader>ds" F"xf"x
nnoremap <Leader>ds' F'xf'x
nnoremap <Leader>ds* F*xf*x
nnoremap <Leader>ds$ F$xf$x
nnoremap <Leader>dsb F(xf)x
nnoremap <Leader>ds( F(xf)x
nnoremap <Leader>dsB F{xf}x
nnoremap <Leader>ds{ F{xf}x
nnoremap <Leader>ds[ F[xf]x
nnoremap <Leader>ds< F<xf>x

inoremap <C-C> <esc>
vnoremap <C-C> <esc>

nnoremap <Leader>h mH
nnoremap <Leader>j mJ
nnoremap <Leader>k mK
nnoremap <Leader>l mL

nnoremap <C-H> 'H
nnoremap <C-J> 'J
nnoremap <C-K> 'K
nnoremap <C-L> 'L

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'morhetz/gruvbox'
Plug 'sainnhe/everforest'
Plug 'jnurmine/Zenburn'
Plug 'nanotech/jellybeans.vim'
Plug 'joshdick/onedark.vim'

call plug#end()

inoremap <silent><expr> <C-n>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<C-n>" :
      \ coc#refresh()
inoremap <expr><C-p> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<TAB>\<c-r>=coc#on_enter()\<cr>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent><nowait> [d <Plug>(coc-diagnostic-prev)
nmap <silent><nowait> ]d <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent><nowait> gd <Plug>(coc-definition)
nmap <silent><nowait> gy <Plug>(coc-type-definition)
nmap <silent><nowait> gi <Plug>(coc-implementation)
nmap <silent><nowait> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Fuzzy Finder
nnoremap <leader>ff :GFiles<cr>
nnoremap <leader>fg :Rg<cr>
nnoremap <leader>fb :Buffers<cr>

" Undo tree
nnoremap <leader>u :UndotreeToggle<cr>

let g:airline_powerline_fonts = 1
let g:airline_theme='jellybeans'

set bg=dark

" let g:everforest_background = 'hard'
" let g:everforest_better_performance = 1

" let g:gruvbox_contrast_dark = 'hard'

let g:jellybeans_background_color_256='NONE'

colorscheme jellybeans
set colorcolumn=80
set cursorline
" Uncomment these for color schemes other that jellybeans
" jellybeans use the bg variable for other stuff as well
highlight Normal ctermbg=NONE guibg=NONE
highlight EndOfBuffer ctermbg=NONE guibg=NONE
