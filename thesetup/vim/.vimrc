"
" Shashank's vim settings
" http://shashankmehta.in
"
" Plugins:
" pathogen

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Initialize pathogen
execute pathogen#infect()

" Use UTF-8 as the default buffer encoding
set encoding=utf-8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Remember up to 100 'colon' commmands and search patterns
set history=100

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Allows scrolling and resizing via mouse
set mouse=a

let $VIMTMP = $HOME."/.vimtmp"

set backupdir=$VIMTMP
set directory=$VIMTMP

" For project specific .vimrc
set exrc
set secure

""
"" APPEARANCE
""

" Turn syntax highlighting on
syntax on
syntax enable

" Show line numbers
set number

" Colored column (to see line size violations)
" set colorcolumn=80
" highlight ColorColumn ctermbg=238

set background=dark
colorscheme slate

set cursorline
hi CursorLine cterm=none ctermbg=black

""
"" INDENTATION
""

" Set proper indentation width
set tabstop=2
set shiftwidth=2
autocmd FileType scss setlocal shiftwidth=2 tabstop=2
autocmd FileType rb setlocal shiftwidth=2 tabstop=2

" Round indent to multiple of 'shiftwidth' for > and < commands
set shiftround

" Use spaces for indentation
set expandtab

" Allow backspacing over everything
set backspace=indent,eol,start


""
"" RULER
""

" Show nice info in ruler
set ruler
set laststatus=2

" Show (partial) commands (or size of selection in Visual mode) in the status line
set showcmd

" Always show Show current mode at the bottom
set showmode


""
"" SPLITTING
""

" Better maneuvering
nnoremap <silent> <C-Right> <c-w>l
nnoremap <silent> <C-Left> <c-w>h
nnoremap <silent> <C-Up> <c-w>k
nnoremap <silent> <C-Down> <c-w>j

" Split right bottom, please
set splitbelow
set splitright

""
"" UTILITY
""

" Makes emmet more in line with sublime
let g:user_emmet_leader_key='<C-E>'

" Write with sudo ":w!!"
cnoremap w!! w !sudo tee % >/dev/null

" Strip trailing whitespaces. Ugly stuff they are.
" func! DeleteTrailingWS()
"     exe "normal mz"
"     %s/\s\+$//ge
"     exe "normal `z"
" endfunc
" autocmd BufWritePre * call DeleteTrailingWS()

" Use menu to show command-line completion (in 'full' case)
set wildmenu

" Set command-line completion mode:
"   - on first <Tab>, when more than one match, list all matches and complete
"     the longest common  string
"   - on second <Tab>, complete the next full match and show menu
set wildmode=list:longest,full

" Sets ignore directories
" Most useful for CtrlP
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,node_modules

" Ignore case when searching
set ic

" Search as you type
set incsearch

" If searched string contains uppercase make search case sensitive
set scs

filetype plugin on
filetype indent on


" Source .vimrc after saving .vimrc
autocmd bufwritepost .vimrc source $MYVIMRC

" Jump 5 lines when running out of the screen
set scrolljump=1

" Indicate jump out of the screen when 3 lines before end of the screen
set scrolloff=3

""
"" KEY MAPPING / SHORTCUTS
""

" Delete/Copy current word
" caw, yaw
" caW, yaW


" Delete/Copy between enclosures
" yi{, yi(, yi[, yi", yi'
" di{, di(, di[, di", di'


let mapleader = ","

" page down with <Space>
nmap <Space> <PageDown>

" page down with <Space>
" nmap <Space> <PageUp>

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Highlight current line in insert mode.
" autocmd InsertLeave * se nocul
autocmd InsertEnter * se cul


" highlight Pmenu ctermbg=238 gui=bold
" highlight PmenuSel ctermbg=001 gui=bold


let g:CommandTMaxHeight=20
let g:CommandTCancelMap='<Esc>'
let g:CommandTAcceptSelectionTabMap='t'

" vim-expand-region plugin
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" vim-github-comment
let g:github_user = 'shashankmehta'

" vim-airline
let g:airline_theme='powerlineish'
let g:airline_powerline_fonts=1

" vim show relative numbers. Requires vim 7.4
set relativenumber
set number
