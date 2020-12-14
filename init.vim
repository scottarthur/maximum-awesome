" To install vim-plug...
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" PLUGINS
call plug#begin()

" colors
Plug 'altercation/vim-colors-solarized'

" statusline
"Plug 'airblade/vim-gitgutter'
Plug 'edkolev/tmuxline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" language support
Plug 'chrisbra/Colorizer'                 " terminal colors
Plug 'fatih/vim-go'                       " golang
Plug 'neovim/nvim-lspconfig'              " LSP support
Plug 'sebdah/vim-delve'                   " golang debugger
Plug 'buoto/gotests-vim'                  " golang test templates
Plug 'hashivim/vim-terraform'             " terraform
Plug 'google/vim-jsonnet'                 " jsonnet
Plug 'JamshedVesuna/vim-markdown-preview' " markdown preview

" IDE features
Plug 'ctrlpvim/ctrlp.vim'                 " file open search
Plug 'rking/ag.vim'                       " find in files
Plug 'scrooloose/nerdtree'                " project browser
Plug 'junegunn/vim-easy-align'            " Markdown align
Plug 'editorconfig/editorconfig-vim'      " Editor config sync
Plug 'tpope/vim-fugitive'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'

" control extensions
Plug 'tpope/vim-commentary'               " toggle comments with command
Plug 'tpope/vim-surround'                 " commands for changing surrounding chars
Plug 'tpope/vim-unimpaired'               " various niceties
Plug 'qpkorr/vim-bufkill'                 " close buffer without closing split
Plug 'vim-scripts/Align'                  " Align text on stuff
Plug 'vim-scripts/Rename'                 " Rename files
call plug#end()

" UI SETTINGS
" Colors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

""""""" SOLARIZED COLORSCHEME """"""""
colorscheme solarized
set background=light
"set background=dark
"let g:solarized_visibility = "high"
"let g:solarized_contrast = "high"

""""""""" GRUVBOX COLORSCHEME """""","
"set termguicolors
"colorscheme gruvbox
"
"""""""""" MOLOKAI """""""""""
"colorscheme molokai

"""""" AIRLINE """"""""""
" Airline
let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Misc {{{
set autowrite                   " automatically save files
set autoread                    " reload files when changed on disk, i.e. via `git checkout`
set backspace=indent,eol,start  " Fix broken backspace in some setups
set clipboard=unnamed           " yank and paste with the system clipboard
set directory-=.                " don't store swapfiles in the current directory
set encoding=utf-8              " it's the 21st century bro
set textwidth=90                " Set gq comment wrapping to 90 chars
set formatoptions-=t            " Set gq comment wrapping to 90 chars (also needed I guess)
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>
" }}}
" Spaces & Tabs {{{
filetype indent on
filetype plugin on
set autoindent          " indent stuff
set smartindent         " ident stuff as a smart person would
set tabstop=4           " 4 space tab
set expandtab           " use spaces for tabs
set softtabstop=4       " 4 space tab
set shiftwidth=4
set modelines=1
" }}}
" UI Layout {{{
set cursorline                                               " highlight current line
set fillchars+=vert:┃
set lazyredraw
set list                                                     " show trailing whitespace
set listchars=tab:\ \ ,trail:▫                               " show tabs as spaces, trailing white space as mr. boxy
set mouse=a" Enable basic mouse behavior such as resizing buffers.
set noshowmode          " airline shows mode
set number              " show line numbers
set scrolloff=3         " show context above/below cursorline
set showcmd             " show command in bottom bar
set showmatch           " higlight matching parenthesis
set wildmenu
set wildignore=log*,target/**,tmp/**,*.rbc                   " ignore files for opening editor
set wildmode=longest,list,full
" }}}
" Searching {{{
set ignorecase          " ignore case when searching
set smartcase                                                " case-sensitive search if any caps
set incsearch           " search as characters are entered
set hlsearch            " highlight all matches
" }}}
" Folding {{{
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
set foldmethod=syntax
nnoremap <space> za
" }}}

" KEYBOARD SHORTCUTS
inoremap jk <esc>
let mapleader = ','
" move vertically by visual line
nnoremap j gj
nnoremap k gk
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
nmap <C-g><C-o> <Plug>window:quickfix:loop
noremap <leader>l :Align
nnoremap <leader>a :Ag<space>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <leader>s :mksession<CR>
nnoremap <leader>t :CtrlP<CR>
nnoremap <leader>T :CtrlPClearCache<CR>:CtrlP<CR>
nnoremap <leader>g :GitGutterToggle<CR>
nnoremap <leader><space> :nohlsearch<CR>
nnoremap <leader>VE :vsp ~/.config/nvim/init.vim<CR>
noremap <silent> <leader>V :source ~/.config/nvim/init.vim<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
  "
" Language config
" Terraform
let g:terraform_fmt_on_save=1    " Format TF files on save
let g:terraform_align=1          " Override indentations
let g:terraform_fold_sections=1  " Allow folding of TF sections
let g:terraform_remap_spacebar=1 " Map folding of sections to spacebar

" Jsonnet
let g:jsonnet_fmt_on_save = 0 "Don't auto-format jsonnet on save

" Markdown
let vim_markdown_preview_github=0

" MISC
let g:NERDSpaceDelims=1
" Don't copy the contents of an overwritten selection.
vnoremap p "_dP

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
" AutoGroups {{{
augroup configgroup
  autocmd!
  autocmd VimEnter * highlight clear SignColumn
  autocmd BufEnter Makefile setlocal noexpandtab
  autocmd BufEnter *.sh setlocal tabstop=2
  autocmd BufEnter *.sh setlocal shiftwidth=2
  autocmd BufEnter *.sh setlocal softtabstop=2
  autocmd BufEnter *.py setlocal tabstop=4
  autocmd BufEnter *.md setlocal ft=markdown
  autocmd BufEnter *.go setlocal noexpandtab
  autocmd BufEnter *.fish set filetype=conf
  " Markdown spellcheck, no line wrapping
  autocmd BufEnter *.md set filetype=markdown
  autocmd BufEnter *.md set spell
  autocmd BufEnter *.md set formatoptions+=t
  autocmd BufEnter *.md set textwidth=99999
  " Use LSP omni-completion in Python files.
  autocmd Filetype go setlocal omnifunc=v:lua.vim.lsp.omnifunc
augroup END
" }}}
" COC CONFIG

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
"set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
"set signcolumn=yes

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Remap keys for gotos
nmap <silent> ga :GoAlternate<CR>
nmap <silent> gt :GoTest<CR>
nmap <silent> gcv :GoCoverageToggle<CR>
nmap <silent> gtf :GoTestFunc<CR>
nmap <silent> gdb :DlvTest<CR>


let g:go_fmt_command = "goimports"
" Use golines to format with a line width of 120
"let g:go_fmt_command = "golines"
"let g:go_fmt_options = {
"    \ 'golines': '-m 120',
"    \ }
"
" Open Delve in full window
let g:delve_new_command = "enew"


set completeopt=menuone,noinsert

" LSP support
lua << EOF
local on_attach_vim = function(client)
  require'completion'.on_attach(client)
  require'diagnostic'.on_attach(client)
end
require'nvim_lsp'.gopls.setup{on_attach=on_attach_vim}
EOF

let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_enable_underline = 0
let g:diagnostic_auto_popup_while_jump = 1
let g:diagnostic_insert_delay = 1

nnoremap <silent> ge <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-S> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
"  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"
"inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
"  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" References
" https://jdhao.github.io/2019/11/20/neovim_builtin_lsp_hands_on/
" https://devhints.io/vimscript
" http://vimdoc.sourceforge.net/htmldoc/quickref.html#Q_op
" https://dougblack.io/words/a-good-vimrc.html
" https://octetz.com/posts/vim-as-go-ide
"
" Troubleshooting!
" If you upgrade _something_ and go CoC breaks, run :CocInstall coc-go
