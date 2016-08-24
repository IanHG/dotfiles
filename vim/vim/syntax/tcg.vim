"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" syntax highlighting for TCG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

if exists("b:current_syntax")
   finish
endif

" define keywords
syntax keyword tcgKeyword autogenerate
syntax keyword tcgKeyword function

highlight link tcgKeyword Keyword

" define comments
syntax match tcgComment "\v//.*$"        " CPP style comments
syntax match tcgComment "\v/\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+/"   " C   style comments
highlight link tcgComment Comment

let b:current_syntax = "tcg"
