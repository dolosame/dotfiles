local o = vim.opt

-- Basic settings
o.number = true -- Line number
o.relativenumber = true -- Relative line number
o.cursorline = true -- Highlight current cursor placement
o.scrolloff = 10 -- Keep x line above/below when scrolling
o.sidescrolloff = 8 -- Keep x columns characters on left
o.wrap = false -- Don't wrap line
o.cmdheight = 0 -- Display command height (0 to not show it when not in use)
o.laststatus = 3 -- Only global status line appear even when split window
o.spelllang = { 'en' } -- Set language for spellchecking

-- Tab / Indentation
o.tabstop = 2 -- Tab width
o.softtabstop = 2 -- How many space act as a tab
o.expandtab = true -- Use space instead of tab
o.shiftwidth = 2 -- Indent width

-- Grep
o.grepformat = '%f:%l:%c:%m' -- File name, line number, column, content

-- Visual settings
o.list = true -- Always render characters
o.listchars = { tab = '󰌒 ', trail = '·', nbsp = '␣' }
o.signcolumn = 'yes' -- Always show sign column
o.colorcolumn = '100' -- Show column of x characters

-- File operations
o.swapfile = false -- No swap files
o.undofile = true -- Persistent undo
o.updatetime = 300 -- Time to trigger CursorHold
o.timeoutlen = 500 -- Time to wait for mapped sequence
o.diffopt:append({ 'vertical', 'algorithm:patience', 'linematch:60' })

-- Set undo directory and ensure it exists
local user = vim.env.USER or os.getenv('USER') or 'nvim'
local undodir = '/tmp/nvim.' .. user .. '/undodir' -- Undo directory path
o.undodir = vim.fn.expand(undodir) -- Expand to full path
local undodir_path = vim.fn.expand(undodir)
if vim.fn.isdirectory(undodir_path) == 0 then
  vim.fn.mkdir(undodir_path, 'p') -- Create if not exists
end

-- Behavior Settings
o.iskeyword:append('-') -- Treat dash as part of a word
o.path:append('**') -- Search into subfolders with `gf`
o.clipboard:append('unnamedplus') -- Use system clipboard
o.wildignorecase = true -- Case-insensitive tab completion in commands
