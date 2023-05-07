vim.keymap.set('i','jk','<ESC>')

--quick save
vim.keymap.set({'n','i'},'<C-s>', '<ESC>:w<CR>')



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


-- Working with terminal
-- open existing terminal, if it exists
local function findTerminal()
  local buffIds = vim.api.nvim_list_bufs()
  for i, x in pairs(buffIds) do
    if string.find(vim.api.nvim_buf_get_name(x),"term") then
      return x
    end
  end
  return nil
end


local function openTerminal()
  vim.cmd("vsplit")
  vim.cmd("wincmd l")
  local currentTerminal = findTerminal()
  if currentTerminal~=nil then
    print("terminal found")
    vim.cmd("buf "..currentTerminal)
  else
    print("no terminal found")
    vim.cmd("term")
  end
  vim.cmd("startinsert")

end
vim.keymap.set('n','<A-t>',openTerminal)
vim.keymap.set({'t'},'<C-q>','<C-\\><C-n>') -- quit Terminal mode, but leave the terminal window open and go to normal mode
vim.keymap.set('t','<A-t>','<C-\\><C-n>:q<CR>') -- quit the terminal window

-- quickly change the capitalization of the current word. I often miss the shift key. Oppsi
vim.keymap.set('i','~~~','<ESC>b~ea')

