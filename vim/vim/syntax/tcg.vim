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
syntax match tcgComment "\v//.*$"
highlight link tcgComment Comment

let b:current_syntax = "tcg"
