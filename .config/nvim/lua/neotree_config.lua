--juggle neo-tree
vim.g.neotree_open=false
local function neo_tree_toggle()
    if vim.g.neotree_open then
        vim.cmd('Neotree close')
        vim.g.neotree_open = false
    else
        vim.cmd('Neotree reveal')
        vim.g.neotree_open = true
    end

end

local function mirror_neo_tree_status()
    if vim.g.neotree_open then
        vim.cmd('Neotree show')
    else
        vim.cmd('Neotree close')
    end
end


local function smart_close()
    if vim.g.neotree_open then
        vim.cmd('Neotree close')
    end
    vim.cmd('quit')
end

local function smart_close_buffer()
    vim.cmd('Neotree close')
    vim.cmd('bd')
    if vim.g.neotree_open then
        vim.cmd('Neotree show')
    end
        vim.cmd('wincmd l')
end

vim.api.nvim_create_autocmd({"TabNew"}, {
  callback = mirror_neo_tree_status,  -- Or myvimfun
})
vim.api.nvim_create_autocmd({"TabEnter"}, {
  callback = mirror_neo_tree_status,  -- Or myvimfun
})

vim.keymap.set({'i','n'},'<C-t>',neo_tree_toggle)
vim.keymap.set({'i','n'},'<C-q>',smart_close)
vim.keymap.set({'n'},'<leader>q',smart_close_buffer)
