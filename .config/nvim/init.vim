call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
call plug#end()
" keybindings 

" toggle nerdtree
inoremap <C-t> <ESC>:NERDTreeToggle<CR>
nnoremap <C-t> <ESC>:NERDTreeToggle<CR>

" move line 
inoremap <A-Down> <ESC> ddpi
inoremap <A-j> <ESC> ddpi
nnoremap <A-Down> ddp
inoremap <A-Up> <ESC> kddpki
inoremap <A-k> <ESC> kddpki
nnoremap <A-Up> kddpk

" copy line up/down
inoremap <A-S-Down> <ESC> yypi
inoremap <A-S-j> <ESC> yypi
nnoremap <A-S-Down> yyp
nnoremap <A-S-j> yyp
inoremap <A-S-Up> <ESC> yypki
inoremap <A-S-k> <ESC> yypki
nnoremap <A-S-Up> yypk
nnoremap <A-S-k> yypk

" quicksave
inoremap <C-s> <ESC>:w<CR>
nnoremap <C-s> <ESC>:w<CR>

" quick exit
inoremap <C-q> <ESC>:q<CR>
nnoremap <C-q> <ESC>:q<CR>

"autoclose


:set nu
:set rnu
:set tabstop=4
