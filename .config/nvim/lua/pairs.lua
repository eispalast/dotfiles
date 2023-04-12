-- return the symbol under the cursor
-- when in insert mode call with offset = -1 to get symbol in front of cursor
-- and offset = 0 to get symbol after cursor
local function current_symbol(offset)
    local win = vim.api.nvim_get_current_win()
    local col = vim.api.nvim_win_get_cursor(win)[2]
    local line = vim.api.nvim_get_current_line()
  return(line:sub(col+1+offset,col+1+offset))
end

-- returns true if the symbol after the cursor is the symbol given as argument
local function match_next(symbol)
    return current_symbol(0)==symbol
end

local function between_pair(one_pair)
    return current_symbol(-1) == one_pair[1] and current_symbol(0)==one_pair[2]
end

local function between_pairs(all_pairs)
    for i,p in ipairs(all_pairs) do
        if between_pair(p) then
            return true
        end
    end
    return false
end

local function smart_return(pairs)
    if between_pairs(pairs) then
        return '<CR><ESC>O'
    else
        return '<CR>'
    end
end
-- inserts a symbol or moves to right, if the next symbol is the same symbol
-- exception: "" and '' are only inserted twice if there is no next symbol or a )
local function insert_or_skip(symbol)
    if match_next(symbol) then
        return '<ESC>la'
    else
        -- extra handling for string symbols
        if symbol == '\'' or symbol == '"' then
            if current_symbol(0)=="" or current_symbol(0)==')' then
                return symbol..symbol..'<ESC>i'
            else
                return symbol
            end
        end
        return symbol
    end
end

-- insert as pairs
local pairs = {{'(',')'},{'[',']'},{'\"','\"'},{'\'','\''},{'{','}'}}
for i,v in ipairs(pairs) do
  vim.keymap.set('i',v[1],v[1]..v[2]..'<ESC>i')
  vim.keymap.set('i',v[2],function() return insert_or_skip(v[2]) end,{ expr=true})
end

vim.keymap.set('i','<CR>',function() return smart_return(pairs) end, { expr=true} )

vim.keymap.set('i', '<BS>', function() if between_pairs(pairs) then return '<BS><Del>' else return '<BS>' end end, { expr=true})


