"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" syntax highlighting for TCG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

if exists("b:current_syntax")
   finish
endif

" define keywords

" define headers
syntax match topHeader "\v#.*$"        " Bash style comments
highlight link topHeader Comment
highlight Comment cterm=bold
syntax match rootCommand " #.*$"        " Bash style comments
syntax match terminalCommand "\v\$.*$"   " Terminal command
highlight link rootCommand Keyword
highlight link terminalCommand Keyword
highlight Keyword ctermfg=LightBlue
syntax match attention "\v!.*$"        " Terminal command
highlight link attention String

let b:current_syntax = "readme"
