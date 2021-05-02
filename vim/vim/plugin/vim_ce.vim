"--------------------------------------------------------------------
"
" Simple local 'Compiler-Explorer' plugin for VIm
"
" Draws inspiration from this talk from Matt Godbolt on https://www.godbolt.org/:
"    https://www.youtube.com/watch?v=kIoZDUd5DKw
"
"--------------------------------------------------------------------
"--------------------------------------------------------------------
" Check if we already loaded plugin 
"--------------------------------------------------------------------
if exists('g:loaded_vimce')
   finish
else
   let g:loaded_vimce = 1
endif

"--------------------------------------------------------------------
" Some plugin variables
"--------------------------------------------------------------------
" Default options (can be overwritten in source file)
let s:ce_options_default = {
   \ 'ce_compiler_cmd'     : ['g++ -masm=intel -O2'],
   \ 'ce_cflags'           : [],
   \ 'ce_llvm_mca_options' : [],
\ }

" Main window
let s:src_buf = 0
let s:src_win = 0

" Asm window
let s:asm_init = 0
let s:asm_buf  = 0
let s:asm_win  = 0

"--------------------------------------------------------------------
" Init ASM view
"--------------------------------------------------------------------
function s:InitAsmView()
   if s:asm_init
      return s:ams_buf
   else
      let s:asm_init = 1
   endif
   
   " Save SRC window
   let s:src_buf = bufnr('%')
   let s:src_win = bufwinid(s:src_buf)
   
   " Create ASM window
   vertical rightb split [AsmView]
   setlocal readonly nowrap syn=asm ft=asm
   setlocal buftype=nofile noswapfile bufhidden=delete

   " Switch back to the old window
   let s:asm_buf = bufnr('%')
   let s:asm_win = bufwinid(s:asm_buf)
   
   call assert_false(s:src_win == s:asm_win)
   call win_gotoid  (s:src_win)
   
   " Return ASM buffer
   return s:asm_buf
endfunction

"--------------------------------------------------------------------
" Kill ASM view
"--------------------------------------------------------------------
function s:KillAsmView()
   exe s:asm_buf . "wincmd q"

   let s:asm_buf  = 0
   let s:asm_win  = 0
   let s:asm_init = 0
endfunction

"--------------------------------------------------------------------
" Check for extra compiler flags in source file
"--------------------------------------------------------------------
function s:ReadOptions(source)
   let l:options = {}
   
   for l:line in a:source
      for [key, value] in items(s:ce_options_default)
         let matches = matchlist(l:line, '!\@<!' . key . '\s*=\(.*\)$')
         if !empty(matches)
            if !has_key(l:options, key)
               let l:options[key] = []
            endif
            for l:splt in split(matches[1], " ")
               call add(l:options[key], l:splt)
            endfor
         endif
      endfor
   endfor 

   for [key, value] in items(s:ce_options_default)
      if !has_key(l:options, key)
         let l:options[key] = s:ce_options_default[key]
      endif
   endfor

   return l:options
endfunction

"--------------------------------------------------------------------
" Add to command from options
"--------------------------------------------------------------------
function s:AddOptions(cmd, options, str)
   let l:cmd = a:cmd
   for value in a:options[a:str]
      let l:cmd = l:cmd . ' ' . value
   endfor
   return l:cmd
endfunction

"--------------------------------------------------------------------
" Create compiler command
"--------------------------------------------------------------------
function s:CompilerCommand(options, src_file)
   " Create compiler command
   let l:compiler_cmd = ""
   let l:compiler_cmd = s:AddOptions(l:compiler_cmd, a:options, 'ce_compiler_cmd')
   let l:compiler_cmd = s:AddOptions(l:compiler_cmd, a:options, 'ce_cflags')

   let l:compiler_cmd = l:compiler_cmd . ' -S -c -o - ' . a:src_file
   
   " Return compiler command
   return l:compiler_cmd
endfunction

"--------------------------------------------------------------------
" Filter for ASM output
"--------------------------------------------------------------------
function s:AsmFilter(options)
   let l:filter = 'c++filt | grep -vE "\s+\."'
   return l:filter
endfunction

"--------------------------------------------------------------------
" Filter for LLVM-MCA (Machine Code Analyser) output
"--------------------------------------------------------------------
function s:LlvmMcaFilter(options)
   let l:filter = 'llvm-mca'
   let l:filter = s:AddOptions(l:filter, a:options, 'ce_llvm_mca_options')
   return l:filter
endfunction

"--------------------------------------------------------------------
" Compile ASM
"--------------------------------------------------------------------
function s:CompileAsm(type)
   let l:cwd  = getcwd()
   let l:file = expand("%:r") 
   let l:src_file = join([cwd, file . '.cpp'], '/')
   "let l:asm_file = join([cwd, file . '.o']  , '/')
   
   let l:source       = getline('^', '$')
   let l:options      = s:ReadOptions(l:source)
   
   " Choose command
   if a:type == "mca"
      let l:compiler_cmd = s:CompilerCommand(l:options, src_file) . ' | ' . s:LlvmMcaFilter(l:options)
   else
      " Default is ASM
      let l:compiler_cmd = s:CompilerCommand(l:options, src_file) . ' | ' . s:AsmFilter(l:options)
   endif
   
   " Write file and run command
   exe 'silent write ' . src_file
   let l:asm_content = systemlist(l:compiler_cmd)
   " v:shell_error holds exit status
   
   " Update window
   let  l:asm_view = winsaveview()
   call win_gotoid(s:asm_win)
   setlocal modifiable noreadonly
   call execute(':%delete _')
   call setline(1, l:asm_content)
   setlocal nomodifiable readonly
   call win_gotoid(s:src_win)
   call winrestview(l:asm_view)
endfunction

"--------------------------------------------------------------------
" Define interface
"--------------------------------------------------------------------
command! Init       :call s:InitAsmView()
command! Kill       :call s:KillAsmView()
command! CompileAsm :call s:CompileAsm("asm")
command! CompileMca :call s:CompileAsm("mca")

map <f1> :Init<CR>
map <f2> :Kill<CR>
map <f3> :CompileAsm<CR>
map <f4> :CompileMca<CR>
