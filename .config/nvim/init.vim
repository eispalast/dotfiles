let g:vimspector_enable_mappings = 'HUMAN'
call plug#begin()
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'tomasiser/vim-code-dark'
"Plug 'luochen1990/rainbow'
Plug 'puremourning/vimspector'
Plug 'ryanoasis/vim-devicons'
Plug 'https://github.com/vim-python/python-syntax'
Plug 'kmonad/kmonad-vim'
call plug#end()


lua << EOF
-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  }

  use { -- Autocompletion
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  }

  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }

  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  -- Git related plugins
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'lewis6991/gitsigns.nvim'

  use 'navarasu/onedark.nvim' -- Theme inspired by Atom
  use 'nvim-lualine/lualine.nvim' -- Fancier statusline
  use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically

  -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  use {
	"windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
}
  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  local has_plugins, plugins = pcall(require, 'custom.plugins')
  if has_plugins then
    plugins(use)
  end

  if is_bootstrap then
    require('packer').sync()
  end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true
--vim.cmd [[colorscheme onedark]]
require('onedark').setup{
  style = 'darker',
  colors = {
    bg0='#041828',
    purple='#C587C0',
    cyan='#50C9B0',
    fg='#9DDBFE',
    orange='#CD9279',
    green='#6A9957'
  },
  highlights = {
    ["@function"]={fg='#DBDBAA'},
    ["@type.builtin"]={fg='$blue'},
    ["@type"]={fg='$cyan'},
    ["@parameter"]={fg='$fg'},
    ["@string"]={fg='$orange'},
    ["@comment"]={fg='$green'},
      }
}
require ('onedark').load()



-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'onedark',
    component_separators = '|',
    section_separators = '',
  },
}

-- Enable Comment.nvim
require('Comment').setup()

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = false,
}

-- Gitsigns
-- See `:help gitsigns.txt`
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'help', 'vim' },

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},

  sumneko_lua = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()
--
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- Turn on lsp status information
require('fidget').setup()

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
EOF



let mapleader = " " "map leader to comma


"Coc options

"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
"nnoremap <silent> K :call ShowDocumentation()<CR>

"function! ShowDocumentation()
  "if CocAction('hasProvider', 'hover')
    "call CocActionAsync('doHover')
  "else
    "call feedkeys('K', 'in')
  "endif
"endfunction

" colorscheme
"set termguicolors
"colorscheme vsc

" Rainbow parentheses
let g:rainbow_active = 1
let g:rainbow_conf = 	{
							\'guifgs': ['#fcd603','#da70d6', '#199eff','#cf7b57'  ],
							\'separately':{
								\'nerdtree':0
							\}
						\}
" keybindings 

" extended NERDTreeFeatures
" Open the existing NERDTree on each new tab.

" Python highlight options
let g:python_highlight_builtins = 1
let g:python_highlight_func_calls = 1
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

vnoremap <C-7> <ESC>:call nerdcommenter#Comment('x','toggle')<CR>

set nu
set rnu
set tabstop=4
set shiftwidth=4
set nowrap
set ignorecase
set smartcase
set scrolloff=5
inoremap jk <ESC>
filetype plugin on
" Debugging

nmap <leader>dd :call vimspector#Launch()<CR>
nmap <leader>db :make<CR> :call vimspector#Launch()<CR>
nmap <F29> :make<CR> :call vimspector#Launch()<CR> " F29= CTRL+F5
nmap <leader>dx :VimspectorReset<CR>
nmap <leader>de :VimspectorEval
nmap <leader>dw :VimspectorWatch
nmap <leader>do :VimspectorShowOutput

" Working with pairs 
"autocmd FileType * let b:coc_pairs_disabled = ["<"]



" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
"inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm(): "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" Open curly brackets in a smart way (I hope)
func Between_brackets()
		let current = getline(".")[col(".")-2]
		if current == '{'
				if getline(".")[col(".")-1] == "}"
						return v:true
				endif
		endif
		if current == '('
				if getline(".")[col(".")-1] == ")"
						return v:true
				endif
		endif
		if current == '['
				if getline(".")[col(".")-1] == "]"
						return v:true
				endif
		endif
		return v:false
endfunc

inoremap <expr> <CR> Between_brackets() ? "\<CR>\<ESC>O" : "\<CR>"

"Pairing opening and closing brackets
" returns true if the next symbol is a closing normal bracket: )
func Before_closing_round()
  if getline(".")[col(".")-1] == ")"
    return v:true
  endif
  return v:false
endfunc

func Before_closing_square()
  if getline(".")[col(".")-1] == "]"
    return v:true
  endif
  return v:false
endfunc

func Before_closing_curly()
  if getline(".")[col(".")-1] == "}"
    return v:true
  endif
  return v:false
endfunc

inoremap ( ()<ESC>i
inoremap <expr> ) Before_closing_round() ? "\<ESC>la" : ")"

inoremap [ []<ESC>i
inoremap <expr> ] Before_closing_square() ? "\<ESC>la" : "]"

inoremap { {}<ESC>i
inoremap <expr> } Before_closing_curly() ? "\<ESC>la" : "}"

"deleting brackets pairwise
inoremap <expr> <BS> Between_brackets() ? "\<BS>\<Del>" : "\<BS>"

" Increase and decrease numbers
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

command! Scratch lua require'tools'.makeScratch()
