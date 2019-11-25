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
syn match midascpp_output_header  "^ *\$.*$" skipwhite
syn match midascpp_output_summary "^ *#.*$" skipwhite
syn match midascpp_output_notice  "^ *!.*$" skipwhite
syn match midascpp_output_notice  "^ *\[WARNING:\].*$" skipwhite

"Regions

let b:current_syntax = "midascpp_output"

hi def link midascpp_output_header  Type
hi def link midascpp_output_summary Keyword
hi def link midascpp_output_notice  String
