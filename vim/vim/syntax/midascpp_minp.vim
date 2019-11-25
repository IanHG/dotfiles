" Vim syntax file
" Language: MidasCpp input file (minp)
" Maintainer: Mads Boettger Hansen
" Latest Revision: 05 November 2015

"If already read in, skip the rest.
if exists("b:current_syntax")
  finish
endif

"Keywords

"Matches
syn match midascpp_input_comment "\!.*$"  " Midas style comments
syn match midascpp_input_comment "//.*$"  " CPP   style comments
syn match midascpp_input_keyword "^ *#.*$" contains=midascpp_input_comment skipwhite " Keywords

"Regions
" C Style comments
syn region c_comment start="/\*" end="\*/" 

let b:current_syntax = "midascpp_input"

hi def link midascpp_input_keyword  Keyword
hi def link midascpp_input_comment  Comment
hi def link c_comment               Comment
