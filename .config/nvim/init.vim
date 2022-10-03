let g:vimspector_enable_mappings = 'HUMAN'
call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'tomasiser/vim-code-dark'
Plug 'luochen1990/rainbow'
Plug 'puremourning/vimspector'
Plug 'ryanoasis/vim-devicons'
call plug#end()

let mapleader = "," " map leader to comma


" Rainbow parentheses
let g:rainbow_active = 1
let g:rainbow_conf = 	{
							\'guifgs': ['#da70d6', '#199eff', '#fcd603', '#cf7b57'],
							\'separately':{
								\'nerdtree':0
							\}
						\}


nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" colorscheme
set termguicolors
colorscheme vsc

" keybindings 

" extended NERDTreeFeatures
" Open the existing NERDTree on each new tab.


autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif
let n_tree_open = 0
let n_tree_active = 0
func NT_toggle()
		call feedkeys("\<ESC>:NERDTreeToggle\<CR>")
		if g:n_tree_open == 1
				let g:n_tree_open = 0
		else
				let g:n_tree_open = 1 
		endif
			
endfunc
func NT_smart_tab_switch()
		if g:n_tree_open ==1
				call feedkeys("\<ESC> gt :NERDTreeFind\<CR> :wincmd l \<CR>")
		else
				call feedkeys("\<ESC>gt :NERDTreeClose\<CR> ")
				
		endif

endfunc

func Smart_exit()
		if g:n_tree_open == 1
				call feedkeys("\<ESC>:NERDTreeClose\<CR> :q \<CR> ")
		else
				call feedkeys("\<ESC>:q\<CR>")
		endif

endfunc		
inoremap <expr> <C-t> NT_toggle() 
nnoremap <expr> <C-t> NT_toggle() 

nnoremap <expr> <C-ü> NT_smart_tab_switch() 

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
inoremap <expr> <C-q> Smart_exit()
nnoremap <expr> <C-q> Smart_exit()

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
:set shiftwidth=4
set nowrap
set ignorecase
set smartcase
inoremap jk <ESC>

" Debugging

nmap <leader>dd :call vimspector#Launch()<CR>
nmap <leader>db :make<CR> :call vimspector#Launch()<CR>
nmap <F29> :make<CR> :call vimspector#Launch()<CR> " F29= CTRL+F5
nmap <leader>dx :VimspectorReset<CR>
nmap <leader>de :VimspectorEval
nmap <leader>dw :VimspectorWatch
nmap <leader>do :VimspectorShowOutput

" Working with pairs 
autocmd FileType * let b:coc_pairs_disabled = ["<"]

" Open curly brackets in a smart way (I hope)
func Between_curly()
		let current = getline(".")[col(".")-2]
		if current == '{'
				if getline(".")[col(".")-1] == "}"
						return v:true
				endif
		endif
		return v:false
endfunc


inoremap <expr> <CR> Between_curly() ? "\<CR>\<ESC>O" : "\<CR>"

func Increase_num()
	let current = getline(".")[col(".")-1]
	if current >= '0' && current <= '9'
		if current == '9'
			let new = '0'
		else
			let new = current+1
		endif
		call feedkeys("r")
		call feedkeys (new)
	endif
endfunc


func Decrease_num()
	let current = getline(".")[col(".")-1]
	if current >= '0' && current <= '9'
		if current == '0'
			let new = '9'
		else
			let new = current-1
		endif
		call feedkeys("r")
		call feedkeys (new)
	endif
endfunc


nnoremap + <ESC>:call Increase_num()<CR>
nnoremap - :call Decrease_num()<CR>
