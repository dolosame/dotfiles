-- Restore last cursor position when reopening a file
local last_cursor_group = vim.api.nvim_create_augroup('LastCursorGroup', {})
vim.api.nvim_create_autocmd('BufReadPost', {
  group = last_cursor_group,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Highlight the yanked text
local highlight_yank_group = vim.api.nvim_create_augroup('HighlightYank', {})
vim.api.nvim_create_autocmd('TextYankPost', {
  group = highlight_yank_group,
  pattern = '*',
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Don't contiue to add comments when press o/O or enter down a line
vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('FormatOptions', { clear = true }),
  pattern = '*',
  callback = function ()
    vim.opt_local.formatoptions:remove({ 'r', 'o' })
  end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  command = '%s/\\s\\+$//e',
})
