"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Patch syntax highlighting for LaTex
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tex terminal commands highlight
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax region texterminal matchgroup=texBeginEnd start="\\begin{terminal}" 
                        \ matchgroup=texBeginEnd end="\\end{terminal}\|%stopzone\>" 
                        \ fold
                        \ contained
                        \ containedin=texDocZone
                        \ contains=@Spell

highlight texterminal cterm=bold

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tex CPP commands highlight
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax region texcpp      matchgroup=texBeginEnd start="\\begin{cpp}\(\[.*\]\)\?" 
                        \ matchgroup=texBeginEnd end="\\end{cpp}\|%stopzone\>" 
                        \ fold
                        \ containedin=texDocZone
                        \ contains=@Spell

highlight texcpp      cterm=bold
