vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

vim.opt.mouse = ""
vim.keymap.set('n', '<Left>',  '<Nop>')
vim.keymap.set('n', '<Right>', '<Nop>')
vim.keymap.set('n', '<Up>',    '<Nop>')
vim.keymap.set('n', '<Down>',  '<Nop>')

require('config.options')
require('config.keymaps')
require('config.autocmds')

require('core.lazy')
require('core.lsp')
require('core.stline')
