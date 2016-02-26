set nocompatible     " do not be compatible with old Vi, so become iMproved ! :D
filetype off         " required for Vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()  " begin loading plugins using vundle

Plugin 'VundleVim/Vundle.vim'     " let Vundle manage itself (Vundle-ception! :O )

Plugin 'scrooloose/nerdtree'      " file manager
Plugin 'scrooloose/syntastic'     " 
Plugin 'scrooloose/nerdcommenter'
Plugin 'jistr/vim-nerdtree-tabs'  " integrate filemanager with tabs.
Plugin 'Valloric/YouCompleteMe'   " auto completion
"Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'} " powerbar^{TM}!!!
Plugin 'vim-airline/vim-airline'        " bottom bar
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'       " use git in ViM
"Plugin 'SirVer/ultisnips'         " code snippets
Plugin 'Shougo/vimproc.vim'  " vimproc (used by vimshell)
Plugin 'Shougo/vimshell.vim' " vimshell (shell for vim!! :D)

call vundle#end()         " end reading in plugins using vundle
filetype plugin indent on " required ?
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"" open nerd tree on vim startup
let g:nerdtree_tabs_open_on_console_startup=1
"" tex-9 stuff
"let g:tex_flavor = 'latex'
"" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger="<c-x>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"
"" " If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" set airline stuff
set laststatus=2
set t_Co=256 " set vim to use 256 colors
set noshowmode
"let g:airline_powerline_fonts = 1
set showtabline=2

syntax on
" save history and copy between file openings
set viminfo='20,\"50,:20,%,n~/.viminfo " 
set history=50
set bs=indent,eol,start

" performance stuff
set fillchars=diff:·
set ttyfast
set lazyredraw       " main performance boost

" indentation
set autoindent
set cindent

" tab
set expandtab
set tabstop=3
set shiftwidth=3

"other stuff
set showmode ruler " show ruler at bottom of screen
set hlsearch       " highlight searches
set nowrap         " do not wrap text (looks ugly!)

"" code folding
set foldenable
set foldmethod=syntax
set foldlevelstart=20
set foldlevel=99

"" line numbering
set number
highlight LineNr ctermbg=Black

" set where to split for open in split mode
set splitbelow
set splitright


"//////////////////////////////////
" remember cursor position
"//////////////////////////////////
function! ResCur()
   if line("'\"") <= line("$")
      normal! g`"
      return 1
   endif
endfunction

augroup resCur
   autocmd!
   autocmd BufWinEnter * call ResCur()
augroup END
