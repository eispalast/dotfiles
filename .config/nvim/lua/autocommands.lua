local autocmd = vim.api.nvim_create_autocmd


autocmd({ "TermOpen", "TermEnter" }, {
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.cmd "startinsert!"
  end,
  desc = "Terminal options",
})

-- prevent luasnip from jumping around
autocmd('ModeChanged', {
  pattern = '*',
  callback = function()
    if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
        and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
        and not require('luasnip').session.jump_active
    then
      require('luasnip').unlink_current()
    end
  end
})

autocmd('FileType', {
  pattern = 'tex',
  callback = function()
    vim.o.wrap = true
    vim.o.spell = true
  end
})
