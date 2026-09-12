-- Func to set key map
local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

-- Toggle expandtab
map('n', '<leader><Tab>', function ()
  vim.o.expandtab = not vim.o.expandtab
end, 'Toggle expandtab')

-- Center screen when jumping
map('n', 'n', 'nzzzv', 'Next search result (centered)')
map('n', 'N', 'Nzzzv', 'Previous search result (centered)')
map('n', '<C-d>', '<C-d>zz', 'Half page down (centered)')
map('n', '<C-u>', '<C-u>zz', 'Half page up (centered)')

-- Buffer navigation
map('n', '<S-l>', ':bnext<CR>', 'Next buffer')
map('n', '<S-h>', ':bprevious<CR>', 'Previous buffer')

-- Better window navigation
map('n', '<C-h>', '<C-w>h', 'Move to left window')
map('n', '<C-j>', '<C-w>j', 'Move to bottom window')
map('n', '<C-k>', '<C-w>k', 'Move to top window')
map('n', '<C-l>', '<C-w>l', 'Move to right window')
map('n', '<leader>q', '<Cmd>close<CR>', 'Close current window')

-- Better terminal navigation
map('t', '<C-h>', '<C-\\><C-N><C-w>h', 'Move to left window')
map('t', '<C-j>', '<C-\\><C-N><C-w>j', 'Move to bottom window')
map('t', '<C-k>', '<C-\\><C-N><C-w>k', 'Move to top window')
map('t', '<C-l>', '<C-\\><C-N><C-w>l', 'Move to right window')

-- Splitting & Resizing
map('n', '<leader>sv', '<Cmd>vsplit<CR>', 'Split window vertically')
map('n', '<leader>sh', '<Cmd>split<CR>', 'Split window horizontally')
map('n', '<C-Up>', '<Cmd>resize +2<CR>', 'Increase window height')
map('n', '<C-Down>', '<Cmd>resize -2<CR>', 'Decrease window height')
map('n', '<C-Left>', '<Cmd>vertical resize -2<CR>', 'Decrease window width')
map('n', '<C-Right>', '<Cmd>vertical resize +2<CR>', 'Increase window width')

-- Better indenting in visual mode
map('v', '<', '<gv', 'Indent left and reselect')
map('v', '>', '>gv', 'Indent right and reselect')

-- Join line below cursor placement
map('n', 'J', 'mzJ`z', 'Join lines below and keep cursor position')

-- Move selected text up down
map('v', '<A-j>', ':m .+1<CR>==', '')
map('v', '<A-k>', ':m .-2<CR>==', '')
map('v', 'p', '"_dP', 'Do not discard old yank when paste')

map('x', '<A-j>', ":move '>+1<CR>gv=gv", 'Move selection up')
map('x', '<A-k>', ":move '<-2<CR>gv=gv", 'Move selection down')
map('x', 'p', '"_dP', 'Do not discard old yank when paste')
