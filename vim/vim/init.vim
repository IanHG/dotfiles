"--------------------------------------------------------------------
"
" VImRC file for setting up VIm / NVIm
"
"--------------------------------------------------------------------

"--------------------------------------------------------------------
" Some initalization
"--------------------------------------------------------------------
if !has("nvim")
   set nocompatible  " Do not be compatible with old Vi, so become iMproved ! :D
   set t_Co=256      " Set vim to use 256 colors
   set ttyfast
endif

if has('nvim')
   tnoremap <Esc> <C-\><C-n>
endif

"--------------------------------------------------------------------
" Vundle stuff... Should maybe think about removing (don't think I'm using it)
"--------------------------------------------------------------------
filetype off         " required for Vundle

"" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()  " begin loading plugins using vundle

Plugin 'VundleVim/Vundle.vim'     " let Vundle manage itself (Vundle-ception! :O )
Plugin 'jbnicolai/vim-AnsiEsc'
Plugin 'wikitopian/hardmode'
Plugin 'rust-lang/rust.vim'
"
"Plugin 'scrooloose/nerdtree'      " file manager
"Plugin 'scrooloose/syntastic'     " 
"Plugin 'scrooloose/nerdcommenter'
"Plugin 'jistr/vim-nerdtree-tabs'  " integrate filemanager with tabs.
"Plugin 'Valloric/YouCompleteMe'   " auto completion
""Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'} " powerbar^{TM}!!!
"Plugin 'vim-airline/vim-airline'        " bottom bar
"Plugin 'vim-airline/vim-airline-themes'
"Plugin 'tpope/vim-fugitive'       " use git in ViM
""Plugin 'SirVer/ultisnips'         " code snippets
"Plugin 'Shougo/vimproc.vim'  " vimproc (used by vimshell)
"Plugin 'Shougo/vimshell.vim' " vimshell (shell for vim!! :D)
"
call vundle#end()         " end reading in plugins using vundle

filetype plugin indent on " Let vim decide on highlighting based on filetype
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
"let g:nerdtree_tabs_open_on_console_startup=1
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
"set laststatus=2
"set noshowmode
"let g:airline_powerline_fonts = 1
"set showtabline=2

"--------------------------------------------------------------------
" Highlighting
"--------------------------------------------------------------------
set hlsearch " Highlight searches
syntax on    " Syntax highlighting turned on    

" Keyword highlighting
"highlight Normal ctermbg=black
highlight Search      ctermfg=Black ctermbg=yellow
highlight Comment     ctermfg=Blue
highlight Keyword     ctermfg=Yellow
highlight Statement   ctermfg=Yellow
"highlight Special     ctermfg=DarkCyan
highlight PreProc     ctermfg=Magenta
highlight Visual      ctermfg=black
highlight Pmenu       ctermbg=blue
highlight String      ctermfg=009
highlight Link        ctermfg=Magenta

" Cursor highligting
highlight LineNr       ctermbg=Black
highlight CursorLineNr ctermbg=yellow

" Cursor underline ?
"set cursorline
"highlight CursorLine   cterm=NONE

" line numbering
set number

"--------------------------------------------------------------------
" Save history and copy between file openings
"--------------------------------------------------------------------
set viminfo='20,\"50,:20,%,n~/.viminfo " 
set history=50
set bs=indent,eol,start

"--------------------------------------------------------------------
" Indentation
"--------------------------------------------------------------------
" Indentation settings
set autoindent
set smartindent

" Tabs
set expandtab
set et
set tabstop=3
set shiftwidth=3

"--------------------------------------------------------------------
" Misc
"--------------------------------------------------------------------
set showmatch
set showmode ruler " Show ruler at bottom of screen
set nowrap         " Do not wrap text (if wrapping is needed call ':set wrap')

" Code folding (can fold syntax/scopes with 'zo' (open) and 'zc' (close))
set foldenable
set foldmethod=syntax
set foldlevelstart=20
set foldlevel=99

" Set where to split for open in split mode
set splitbelow
set splitright

" Make y yank to OS clipboard
set clipboard+=unnamed

" Performance stuff
"set fillchars=diff:·
"set lazyredraw       " main performance boost

" Setup syntax for different non-standard extensions
au BufNewFile,BufRead *.tc set filetype=tcg
au BufNewFile,BufRead *.gdef set filetype=lua
au BufNewFile,BufRead *.gpack set filetype=lua

"--------------------------------------------------------------------
" Remember cursor position
"--------------------------------------------------------------------
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

"--------------------------------------------------------------------
" Hex mode
"--------------------------------------------------------------------
" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    silent :e " this will reload the file without trickeries 
              "(DOS line endings will be shown entirely )
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction


" autocmds to automatically enter hex mode and handle file writes properly
if has("autocmd")
  " vim -b : edit binary using xxd-format!
  augroup Binary
    au!

    " set binary option for all binary files before reading them
    au BufReadPre *.bin,*.hex setlocal binary

    " if on a fresh read the buffer variable is already set, it's wrong
    au BufReadPost *
          \ if exists('b:editHex') && b:editHex |
          \   let b:editHex = 0 |
          \ endif

    " convert to hex on startup for binary files automatically
    au BufReadPost *
          \ if &binary | Hexmode | endif

    " When the text is freed, the next time the buffer is made active it will
    " re-read the text and thus not match the correct mode, we will need to
    " convert it again if the buffer is again loaded.
    au BufUnload *
          \ if getbufvar(expand("<afile>"), 'editHex') == 1 |
          \   call setbufvar(expand("<afile>"), 'editHex', 0) |
          \ endif

    " before writing a file when editing in hex mode, convert back to non-hex
    au BufWritePre *
          \ if exists("b:editHex") && b:editHex && &binary |
          \  let oldro=&ro | let &ro=0 |
          \  let oldma=&ma | let &ma=1 |
          \  silent exe "%!xxd -r" |
          \  let &ma=oldma | let &ro=oldro |
          \  unlet oldma | unlet oldro |
          \ endif

    " after writing a binary file, if we're in hex mode, restore hex mode
    au BufWritePost *
          \ if exists("b:editHex") && b:editHex && &binary |
          \  let oldro=&ro | let &ro=0 |
          \  let oldma=&ma | let &ma=1 |
          \  silent exe "%!xxd" |
          \  exe "set nomod" |
          \  let &ma=oldma | let &ro=oldro |
          \  unlet oldma | unlet oldro |
          \ endif
  augroup END
endif

map <F9> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
