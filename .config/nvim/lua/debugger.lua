--Debugging
vim.keymap.set('n', '<leader>dd', ':call vimspector#Launch()<CR>',{ silent=true})
vim.keymap.set('n', '<leader>db', ':VimspectorBreakpoints<CR>',{ silent=true})
vim.keymap.set('n', '<F29>' ,':make<CR> :call vimspector#Launch()<CR> " F29= CTRL+F5',{ silent=true})
vim.keymap.set('n', '<leader>dx', ':VimspectorReset<CR>',{ silent=true})
vim.keymap.set('n', '<leader>de', ':VimspectorEval',{ silent=true})
vim.keymap.set('n', '<leader>dw' ,':VimspectorWatch',{ silent=true})
vim.keymap.set('n', '<leader>do' ,':VimspectorShowOutput',{ silent=true})

-- Default keybinds
-- Set breakpoints              F9
-- set conditional breakpoint   <leader>F9
-- Continue/Run                 F5
-- Next                         F10
-- Step                         F11

