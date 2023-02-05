vim.keymap.set('i','jk','<ESC>')

--quick save
vim.keymap.set({'n','i'},'<C-s>', '<ESC>:w<CR>')

-- Increase and decrese numbers
function count(updown)
    local current_word = vim.call('expand','<cword>')
    local as_num = tonumber(current_word)
    if as_num then
        if updown == '+' then
            as_num = as_num+1
        elseif updown == '-' then
            as_num = as_num-1
        else
            return
        end
        return "<ESC>diwa" .. as_num .. "<ESC>"
    else
        print("no number")
    end
end
vim.keymap.set('n','+', function() return count("+") end,{ expr=true })
vim.keymap.set('n','-', function() return count("-") end,{ expr=true })

--Debugging
vim.keymap.set('n', '<leader>dd', ':call vimspector#Launch()<CR>',{ silent=true})
vim.keymap.set('n', '<leader>db', ':make<CR> :call vimspector#Launch()<CR>',{ silent=true})
vim.keymap.set('n', '<F29>' ,':make<CR> :call vimspector#Launch()<CR> " F29= CTRL+F5',{ silent=true})
vim.keymap.set('n', '<leader>dx', ':VimspectorReset<CR>',{ silent=true})
vim.keymap.set('n', '<leader>de', ':VimspectorEval',{ silent=true})
vim.keymap.set('n', '<leader>dw' ,':VimspectorWatch',{ silent=true})
vim.keymap.set('n', '<leader>do' ,':VimspectorShowOutput',{ silent=true})


