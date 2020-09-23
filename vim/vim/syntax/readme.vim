"--------------------------------------------------------------------
" syntax highlighting for 'readme' files
"--------------------------------------------------------------------

" Check if current syntax has been loaded
if exists("b:current_syntax")
   finish
endif

" define keywords

"--------------------------------------------------------------------
" Define headers
"--------------------------------------------------------------------
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

"--------------------------------------------------------------------
"  Enable code snippets to be highlighed using '```' (three-backticks).
"
"  TextEnableCodeSnip(...) function is defined in file 'plugin/utils.vim'.
"
"  TODO: Have it check for language dynamically (if it can be done)
"  
"  Enabled languages:
"     cpp
"
"--------------------------------------------------------------------
call TextEnableCodeSnip('cpp', '```\s*cpp', '```', 'SpecialComment')


" Define current_syntax
let b:current_syntax = "readme"
