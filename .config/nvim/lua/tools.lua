vim.keymap.set('i','jk','<ESC>')

--quick save
vim.keymap.set({'n','i'},'<C-s>', '<ESC>:w<CR>')

--Debugging
vim.keymap.set('n', '<leader>dd', ':call vimspector#Launch()<CR>',{ silent=true})
vim.keymap.set('n', '<leader>db', ':make<CR> :call vimspector#Launch()<CR>',{ silent=true})
vim.keymap.set('n', '<F29>' ,':make<CR> :call vimspector#Launch()<CR> " F29= CTRL+F5',{ silent=true})
vim.keymap.set('n', '<leader>dx', ':VimspectorReset<CR>',{ silent=true})
vim.keymap.set('n', '<leader>de', ':VimspectorEval',{ silent=true})
vim.keymap.set('n', '<leader>dw' ,':VimspectorWatch',{ silent=true})
vim.keymap.set('n', '<leader>do' ,':VimspectorShowOutput',{ silent=true})

-- put parentheses around stuff
vim.keymap.set('v','<leader>}','s{<ESC>pa}<ESC>')
vim.keymap.set('v','<leader>)','s(<ESC>pa)<ESC>')
vim.keymap.set('v','<leader>]','s[<ESC>pa]<ESC>')
vim.keymap.set('v','<leader>"','s"<ESC>pa"<ESC>')
vim.keymap.set('v','<leader>\'','s\'<ESC>pa\'<ESC>')

-- quickly toggle wrap
function Toggle_wrap()
    vim.o.wrap = not vim.o.wrap
end

vim.keymap.set('n','<A-z>',':lua Toggle_wrap()<CR>',{silent=true,noremap=true})

