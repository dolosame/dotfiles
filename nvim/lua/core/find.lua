local ignore_patterns = {
  'build',
  'dist',
  'node_modules',
  'target',
  '%.cache',
  '%.git',
  '%.log',
  '%.tmp',

  'chromium',
  'mozilla'
}

function _G.nvim_find(text, _)
  local files = vim.fn.glob('**/*', true, true)
  local result = {}

  for _, f in ipairs(files) do
    if vim.fn.isdirectory(f) == 0 then
      local skip = false

      for _, pat in ipairs(ignore_patterns) do
        if f:match(pat) then
          skip = true
          break
        end
      end

      if not skip then
        result[#result + 1] = f
      end

    end
  end

  return vim.fn.matchfuzzy(result, text)
end

vim.api.nvim_create_autocmd('CmdlineChanged', {
  pattern = ':',
  callback = function ()
    if vim.fn.getcmdline():match('^find%s') then
      vim.fn.wildtrigger()
    end
  end
})

vim.opt.wildmode = 'noselect'
vim.opt.wildignorecase = true
vim.opt.findfunc = 'v:lua.nvim_find'

-- Quick find keymap
vim.keymap.set('n', '<leader>f', ':find ', { silent = false })
