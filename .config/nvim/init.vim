call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'tomasiser/vim-code-dark'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'luochen1990/rainbow'
call plug#end()



let g:rainbow_active = 1
let g:rainbow_conf = {'guifgs': ['#da70d6', '#199eff', '#fcd603', '#cf7b57']}



" colorscheme codedark
" keybindings 
"
set termguicolors
colorscheme vsc
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

" work with splits
inoremap <A-v> <ESC>:vsplit<CR> :wincmd l <CR>
nnoremap <A-v> <ESC>:vsplit<CR> :wincmd l <CR>

inoremap <A-s> <ESC>:split<CR> :wincmd j <CR>
nnoremap <A-s> <ESC>:split<CR> :wincmd j <CR>

inoremap <A-h> <ESC>:wincmd h<CR>
nnoremap <A-h> <ESC>:wincmd h<CR>

inoremap <A-l> <ESC>:wincmd l<CR>
nnoremap <A-l> <ESC>:wincmd l<CR>

nnoremap <A-j> <ESC>:wincmd j<CR>
inoremap <A-j> <ESC>:wincmd j<CR>

inoremap <A-k> <ESC>:wincmd k<CR>
nnoremap <A-k> <ESC>:wincmd k<CR>

inoremap <A-p> <ESC>:echo synIDattr(synID(line("."), col("."), 1), "name")<CR>
nnoremap <A-p> <ESC>:echo synIDattr(synID(line("."), col("."), 1), "name")<CR>
:set nu
:set rnu
:set tabstop=4


autocmd FileType * let b:coc_pairs_disabled = ["<"]

" Open curly brackets in a smart way (I hope)
func GetBuch()
		let current = getline(".")[col(".")-2]
		if current == '{'
				if getline(".")[col(".")-1] == "}"
						return v:true
				endif
		endif
		return v:false
endfunc


inoremap <expr> <CR> GetBuch() ? "\<CR>\<ESC>O" : "\<CR>"
