vim.keymap.set('i', 'jk', '<ESC>')

--quick save
vim.keymap.set({ 'n', 'i' }, '<C-s>', '<ESC>:w<CR>')



-- put parentheses around stuff
vim.keymap.set('v', '<leader>}', 's{<ESC>pa}<ESC>')
vim.keymap.set('v', '<leader>)', 's(<ESC>pa)<ESC>')
vim.keymap.set('v', '<leader>]', 's[<ESC>pa]<ESC>')
vim.keymap.set('v', '<leader>"', 's"<ESC>pa"<ESC>')
vim.keymap.set('v', '<leader>\'', 's\'<ESC>pa\'<ESC>')

-- quickly toggle wrap
function Toggle_wrap()
  vim.o.wrap = not vim.o.wrap
end

vim.keymap.set('n', '<A-z>', ':lua Toggle_wrap()<CR>', { silent = true, noremap = true })


-- Working with terminal
-- open existing terminal, if it exists

-- find buffers that hold a terminal. Return its ID or nil if none was found
local function findTerminal()
  local buffIds = vim.api.nvim_list_bufs()
  for i, x in pairs(buffIds) do
    if string.find(vim.api.nvim_buf_get_name(x), "term:") then
      return x
    end
  end
  return nil
end

-- return the window id (can be a split) of a window that holds a specific `bufNum` or nil if none was found
local function findCorrespondingWindow(bufNum)
  local currentWindows = vim.api.nvim_list_wins()
  for _,winID in ipairs(currentWindows) do
    if vim.api.nvim_win_get_buf(winID) == bufNum then
      return winID
    end
  end
  return nil
end

local function openTerminal()
  local currentTerminal = findTerminal()
  if currentTerminal ~= nil then
    local currentWindow = findCorrespondingWindow(currentTerminal)
    if currentWindow == nil then
      vim.cmd("vsplit")
      vim.cmd("wincmd l")
      vim.cmd("buf " .. currentTerminal)
    else
      vim.api.nvim_set_current_win(currentWindow)
    end
    -- print("terminal found"..currentTerminal)
  else
    vim.cmd("vsplit")
    vim.cmd("wincmd l")
    -- print("no terminal found")
    vim.cmd("term")
  end
  vim.cmd("startinsert")
end

vim.keymap.set('n', '<A-t>', openTerminal)
vim.keymap.set({ 't' }, '<C-q>', '<C-\\><C-n>')   -- quit Terminal mode, but leave the terminal window open and go to normal mode
vim.keymap.set('t', '<A-t>', '<C-\\><C-n>:q<CR>') -- quit the terminal window

-- quickly change the capitalization of the current word. I often miss the shift key. Oppsi
vim.keymap.set('i', '~~~', '<ESC>b~ea')

-- quickly correct spelling mistakes.
-- Let's break it down, shall we?
-- First of all, I go to normal mode, save that position in a mark
-- Then I Jump to the previous error ([s) and correct that word with the first suggestion (1z=).
-- Then I jump back to the marked position
vim.keymap.set('i', 'öö', '<ESC>ma[s1z=`aa')

-- format python files
vim.keymap.set('n', '<leader>fb', function()
  local fileName = vim.api.nvim_buf_get_name(0)
  vim.cmd(":w")
  vim.cmd("silent :!black " .. fileName)
end)
