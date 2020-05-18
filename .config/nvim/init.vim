"  set the runtime path to include Vundle and initialize
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')


" install with :PluginInstall
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

"-------------------=== Code/Project navigation ===-------------
Plugin 'scrooloose/nerdtree'                " Project and file navigation
Plugin 'Xuyuanp/nerdtree-git-plugin'        " NerdTree git functionality
Plugin 'airblade/vim-gitgutter'             " Show git changes in gutter
Plugin 'majutsushi/tagbar'                  " Class/module browser
Plugin 'vim-airline/vim-airline'            " Lean & mean status/tabline for vim
Plugin 'vim-airline/vim-airline-themes'     " Themes for airline
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " requires fzf and the_silver_searcher (ag)
Plugin 'junegunn/fzf.vim'
Plugin 'tpope/vim-commentary'               " Comment lines
Plugin 'tpope/vim-fugitive'

"-------------------=== Other ===-------------------------------
Plugin 'jiangmiao/auto-pairs'
Plugin 'flazz/vim-colorschemes'             " Colorschemes
Plugin 'chrisbra/Colorizer'                 " Colorize colornames and codes
Plugin 'guns/xterm-color-table.vim'			" Display a color table
Plugin 'dylanaraps/wal.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-sensible'
Plugin 'ntpeters/vim-better-whitespace'

"---------------=== Code completion ===---------------------------
Plugin 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

"-------------------=== Language Support ===--------------------
" Plugin 'scrooloose/syntastic'
Plugin 'w0rp/ale'

"---------------------=== Fish ===-----------------------------
Plugin 'dag/vim-fish'

"-------------------=== Python ===-----------------------------
Plugin 'jmcantrell/vim-virtualenv', { 'for': 'python'  }
Plugin 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plugin 'davidhalter/jedi-vim', { 'for': 'python'  }
Plugin 'zchee/deoplete-jedi', { 'for': 'python'  }
Plugin 'fisadev/vim-isort'
" Plugin 'vim-vdebug/vdebug'

"-------------------=== Cypher ===-----------------------------
Plugin 'neo4j-contrib/cypher-vim-syntax', { 'for': 'cypher' }

"-------------------=== JSON ===-------------------------------
Plugin 'elzr/vim-json'

"------------------=== Markdown ===----------------------------
Plugin 'tpope/vim-markdown'
Plugin 'vim-scripts/SyntaxRange'

" All of your Plugins must be added before the following line
call vundle#end()            " required


filetype on
filetype plugin on


"=====================================================
"" General settings
"=====================================================
set nocompatible                            " required
filetype off                                " required
set hidden
set showtabline=0
let mapleader=" "

set encoding=utf-8
colorscheme zenburn
" set background=dark

set t_Co=256                                " 256 colors
set shell=/bin/bash
set number                                  " show line numbers
set ruler
set ttyfast                                 " terminal acceleration

set tabstop=4                               " 4 whitespaces for tabs visual presentation
set shiftwidth=4                            " shift lines by 4 spaces
set expandtab                               " expand tabs into spaces
set colorcolumn=121

set showmatch                               " shows matching part of bracket pairs (), [], {}

set nobackup 	                            " no backup files
set nowritebackup                           " only in case you don't want a backup file while editing
set noswapfile 	                            " no swap files


set scrolloff=20                            " let 10 lines before/after cursor during scroll

set clipboard=unnamedplus                   " use system clipboard

set exrc                                    " enable usage of additional .vimrc files from working directory
set secure                                  " prohibit .vimrc files to execute shell, create files, etc...
set nocursorline                            " shows line under the cursor's line

set lazyredraw                              " do not redraw screen in the middle of a macro
set smartcase
set ignorecase
set undofile
set inccommand=nosplit

"=====================================================
"" Deactivate arrows
"=====================================================

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

inoremap <Left> <Nop>
inoremap <Right> <Nop>

"=====================================================
"" Tabs / Buffers settings
"=====================================================
tab sball
set switchbuf=useopen
set laststatus=2
nmap <leader>o <C-o>
nmap <leader>i <C-i>
nmap <leader>b :bprev<CR>
nmap <leader>f :bnext<CR>
nmap <silent> <leader>q :bp <BAR> bd #<CR>
nnoremap <silent> <C-w><C-h> :vertical resize -5<cr>
nnoremap <silent> <C-w><C-j> :resize +5<cr>
nnoremap <silent> <C-w><C-k> :resize -5<cr>
nnoremap <silent> <C-w><C-l> :vertical resize +5<cr>


"=====================================================
"" Relative Numbering
"=====================================================
nnoremap <F4> :set relativenumber!<CR>


"=====================================================
"" Search settings
"=====================================================
set hlsearch	                            " highlight search results
" clear search highlight
nnoremap <silent> <leader>h :nohlsearch<CR>
" replace word under cursor
" nnoremap <leader>r :%s/\<<C-r><C-w>\>/


"=====================================================
"" Ale
"=====================================================
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
let b:ale_warn_about_trailing_whitespace = 1
let g:ale_emit_conflict_warnings = 1
let g:ale_completion_enabled = 0
let g:syntastic_python_pylint_post_args="--max-line-length=120"
let g:ale_linters = {
\   'python': ['flake8', 'pep8'],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines'],
\   'python': ['isort', 'autopep8'],
\}
let g:ale_fix_on_save = 0
let g:ale_list_window_size = 15
let g:ale_echo_cursor = 1 " workaround for vim bug

nmap <silent> <leader>ef :ALEFix<cr>
nmap <silent> <leader>ej :ALENext<cr>
nmap <silent> <leader>ek :ALEPrevious<cr>
au FileType python setlocal formatprg=autopep8\ --max-line-length=120\ - " mapped to gq by default


"=====================================================
"" AirLine settings
"=====================================================
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail_improved'
let g:airline_theme='zenburn'             " set airline theme
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" let g:airline_left_sep = ''
" let g:airline_right_sep = ''
" let g:airline_symbols.notexists = ''


"=====================================================
"" TagBar settings
"=====================================================
let g:tagbar_autofocus=1
let g:tagbar_width=42
map <C-t> :TagbarToggle<CR>
" autocmd BufWinEnter *.py :call tagbar#autoopen(0)
autocmd BufWinLeave *.py :TagbarClose


"=====================================================
"" NERDTree settings
"=====================================================
let NERDTreeIgnore = ['\.pyc$', '\.pyo$', '__pycache__$', '\~$']     " Ignore files in NERDTree
let NERDTreeWinSize = 40
autocmd VimEnter * if !argc() | NERDTree | endif  " Load NERDTree only if vim is run without arguments
map <C-n> :NERDTreeToggle<CR>
nmap <leader>n :NERDTreeFind<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 1


"=====================================================
"" GitGutter
"=====================================================
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk
let g:updatetime = 250


"=====================================================
"" Indent Guides Settings
"=====================================================
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.


"=====================================================
"" Window Navigation
"=====================================================
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


"=====================================================
"" Deoplete
"=====================================================
let g:deoplete#enable_at_startup = 1
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'
call deoplete#custom#option('auto_complete_delay', 0)



"=====================================================
"" Vim Virtualenv
"=====================================================
let g:virtualenv_auto_activate = 1



"=====================================================
"" FZF
"=====================================================
"
nnoremap <C-f>f :Files<cr>
nnoremap <C-f>t :Ag<cr>
" Search current word
nnoremap <C-f>w :Ag <C-R><C-W><cr>
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""' " search in all hidden files but .git
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


"=====================================================
"" Auto Pairs
"=====================================================
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutFastWrap = '<C-s>'


""=====================================================
""" WhiteSpace Highlight
""=====================================================
let g:strip_whitespace_on_save=1


""=====================================================
""" iSort
""=====================================================
let g:vim_isort_map = '<C-I>'
let g:vim_isort_python_version = 'python3'



""=====================================================
""" Colorizer
""=====================================================
let g:colorizer_auto_color = 1
let g:colorizer_disable_bufleave = 1
let g:colorizer_skip_comments = 1
let g:colorizer_colornames = 0
autocmd BufNewFile,BufRead,BufEnter,BufWinEnter * call timer_start(100, { tid -> execute('ColorHighlight')})



""=====================================================
""" Semshi
""=====================================================
function MyCustomHighlights()
    hi semshiLocal           ctermfg=209 guifg=#ff875f
    hi semshiGlobal          ctermfg=214 guifg=#ffaf00
    hi semshiImported        ctermfg=214 guifg=#ffaf00 cterm=bold gui=bold
    hi semshiParameter       ctermfg=75  guifg=#5fafff
    hi semshiParameterUnused ctermfg=117 guifg=#87d7ff cterm=underline gui=underline
    hi semshiFree            ctermfg=218 guifg=#ffafd7
    hi semshiBuiltin         ctermfg=207 guifg=#ff5fff
    hi semshiAttribute       ctermfg=49  guifg=#00ffaf
    hi semshiSelf            ctermfg=249 guifg=#b2b2b2
    hi semshiUnresolved      ctermfg=226 guifg=#ffff00 cterm=underline gui=underline
    hi semshiSelected        ctermfg=231 guifg=#ffffff ctermbg=161 guibg=#d7005f

    hi semshiErrorSign       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
    hi semshiErrorChar       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
    sign define semshiError text=E> texthl=semshiErrorSign
endfunction

autocmd FileType python call MyCustomHighlights()
autocmd ColorScheme * call MyCustomHighlights()



"=====================================================
"" Jedi Vim
"=====================================================
let g:jedi#auto_initialization = 1 " disable jedi
let g:jedi#auto_vim_configuration = 1 " disable jedi
let g:jedi#completions_enabled = 0 " disable completions
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#usages_command = "<leader>u"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "2"
let g:jedi#popup_on_dot = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#use_tabs_not_buffers = 0
autocmd BufWinEnter '__doc__' setlocal bufhidden=delete " delete jedi docs

" Set the background transparent
hi Normal guibg=NONE ctermbg=NONE


"=====================================================
"" Others
"=====================================================
" Pretty format XML
com! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"
nnoremap = :FormatXML<Cr>
