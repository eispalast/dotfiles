-- moving lines keymaps
vim.keymap.set('i', '<A-Down>', '<ESC> ddpi')
vim.keymap.set('n','<A-Down>', 'ddp')
vim.keymap.set('i','<A-Up>', '<ESC> kddpki')
vim.keymap.set('n','<A-Up>','kddpk')

-- copy lines up/down
vim.keymap.set('i', '<A-S-Down>', '<ESC> yypi')
vim.keymap.set('i', '<A-S-j>', '<ESC> yypi')
vim.keymap.set('n', '<A-S-Down>', 'yyp')
vim.keymap.set('n', '<A-S-j>', 'yyp')
vim.keymap.set('i', '<A-S-Up>', '<ESC> yypki')
vim.keymap.set('i', '<A-S-k>', '<ESC> yypki')
vim.keymap.set('n', '<A-S-Up>', 'yypk')
vim.keymap.set('n', '<A-S-k>', 'yypk')


-- work with splits
vim.keymap.set({'i','n'},'<A-v>', '<ESC>:vsplit<CR> :wincmd l <CR>',{ silent=true})
vim.keymap.set({'i','n'},'<A-s>', '<ESC>:split<CR> :wincmd j <CR>',{ silent=true})
vim.keymap.set({'i','n'},'<A-h>', '<ESC>:wincmd h<CR>',{ silent=true})
vim.keymap.set({'i','n'},'<A-l>', '<ESC>:wincmd l<CR>',{ silent=true})
vim.keymap.set({'i','n'},'<A-j>', '<ESC>:wincmd j<CR>',{ silent=true})
vim.keymap.set({'i','n'},'<A-k>', '<ESC>:wincmd k<CR>',{ silent=true})

-- switching tabs
vim.keymap.set({'i','n'},'<C-ü>','gt')
vim.keymap.set({'i','n'},'<C-ä>','gT')

-- git diff view
vim.keymap.set('n','<leader>gi',function () vim.cmd('DiffviewFileHistory') end,{silent=true})
vim.keymap.set('n','<leader>gx',function () vim.cmd('DiffviewClose') end,{silent=true})


-- quickly scroll and center view
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

-- center when searching words
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
