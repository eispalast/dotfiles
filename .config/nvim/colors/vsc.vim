:hi generalPink guifg=#c587c0
:hi darkPink guifg=#da70d6

:hi Normal guifg=#9ddbfe

:hi Statement guifg=#569cd6 gui=None
:hi LineNr guifg=#848586
:hi NonText guifg=#232323
:hi Identifier guifg=#dbdbaa
:hi Type guifg=#50c9b0 gui=NONE
:hi String guifg=#cd9279
:hi Number guifg=#b5cda9
:hi PreProc guifg=#dbdbaa
:hi Comment guifg=#6a9957 gui=italic

:hi Title guifg=#9ddbfe gui=bold

:hi link Conditional generalPink
:hi link Repeat Conditional

:hi Macro guifg=#dbdbaa

:hi Folded guibg=#585A70 guifg=NONE
" C
:hi cPink guifg=#c587c0
:hi link cStatement cPink
:hi link cInclude cPink
:hi cType guifg=#579cd5
:hi link cConstant Number
:hi link cCustomFunc Function 
:hi cCustomOperator guifg=#d3d4d4
:hi link cFormat Normal
:hi link cSpecial Function
:hi link cDefine cInclude

" Pmenu
:hi Pmenu guifg=#d3d4d4 guibg=#363636
:hi PmenuSel guifg=#d3d4d4 guibg=#4a4a4a gui=bold


" Rust
:hi link rustCommentLineDoc Comment
:hi link rustModPath Type
:hi link rustIdentifier rustModPath 

" Filesystem
:hi Directory guifg=#50c9b0
:hi NERDTreeExecFile guifg=#da70d6
":hi Title gui=bold

" Python
:hi link PythonImport generalPink
