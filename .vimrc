inoremap jk <ESC>

let mapleader = ","
let maplocalleader = "\\"

set nocompatible

filetype plugin indent on   " Load plugins according to detected filetype
syntax on                   " Enable syntax highlighting
set encoding=utf-8

set autoindent              " Indent according to previous line
set number                  " Show line number
set norelativenumber        " Disable relative line number
set expandtab               " Use spaces instead of tabs
set tabstop=4
set softtabstop=4           " Tab key indents by 4 spaces
set shiftwidth=4            " >> indents by 4 spaces
set shiftround              " >> indents to next multiple of 'shiftwidth'

set backspace       =indent,eol,start 
set hidden					" Switch between buffers without having to save first
set laststatus=2    		" Always show statusline
set display=lastline		" Show as much as possible of the last line

set showmode				" Show current mode in command-line
set showcmd					" Show already typed keys when more are expected

set incsearch				" Highlight while searching
set hlsearch				" Keep matches highlighed

set ttyfast					" Faster redrawing
set lazyredraw				" Only redraw when necessary

set splitbelow				" Open new windows below the current window
set splitright				" Open new windows right of the current window

set cursorline				" Find the current line quickly
set wrapscan				" Searches wrap around end-of-file
set report   =0				" Always report changed lines
set synmaxcol 	=200		" Only highlight the first 200 columns

" Put all temporary files under the same directory.
set backup
set backupdir       =$HOME/.vim/files/backup/
set backupext       =-vimbackup
set backupskip      =
set directory       =$HOME/.vim/files/swap//
set updatecount     =100
set undofile
set undodir         =$HOME/.vim/files/undo/
set viminfo         ='100,n$HOME/.vim/files/info/viminfo

set updatetime      =100    " Show git updates quicker

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
Plug 'ap/vim-css-color'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'preservim/tagbar'

call plug#end()

"colorscheme gruvbox
colorscheme dracula
let g:dracula_italic = 0

set bg=dark

" Opening and sourcing VIMRC
map <leader><leader>v :vsplit $MYVIMRC<cr>
map <leader><leader>s :source $MYVIMRC<cr>
" Automatically source vimrc after save
" autocmd bufwritepost .vimrc source $MYVIMRC

" Easy save when in insert mode
map <leader><leader>w jk:w<cr>

" Moving the current line up or down
nnoremap - ddp
nnoremap _ ddkp 

" Easier Navigation
nnoremap H 0
nnoremap L A<esc>l 

" Convert the current word to uppercase in different modes
inoremap <c-u> <ESC>viwUea
nnoremap <c-u> viwU

" Wrap current word in double quotes or single quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

nnoremap <leader>nh :nohl<cr>

" Copy the entire buffer to the clipboard
nnoremap <leader><leader><c-c> gg"*yG``

" Name abbreviation
iabbrev @@ ramtintjb@gmail.com

" CPP specifics
nnoremap <leader>t :TagbarToggle<CR>
augroup filetype_cpp
	autocmd!
	autocmd FileType cpp :inoremap <buffer> <localleader>s std::
    autocmd FileType cpp :inoremap <buffer> cstr std::string
augroup END

" Markdown specifics
augroup filetype_markdown
	autocmd FileType markdown :onoremap ih :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<cr>
	autocmd FileType markdown :onoremap ah :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rg_vk0"<cr>
augroup END

onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>

" COC Specifics
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)

" Quitting bad habits :)
inoremap <esc> <nop>
inoremap <down> <nop>
inoremap <up> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap <down> <nop>
nnoremap <up> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
