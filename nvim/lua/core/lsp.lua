-- Enable a lsp server, add lang config at nvim/lsp/ dir
vim.lsp.enable({
  'bash_lang',
  'lua_lang',
  'rust_lang',
})

-- Global diagnostic config
vim.diagnostic.config({
  underline = true,
  update_in_insert = false,

  virtual_text = {
    prefix = '',
    format = function(diagnostic)
      local maxlen = 80
      if #diagnostic.message > maxlen then
        return string.sub(diagnostic.message, 1, maxlen) .. '...'
      end
      return diagnostic.message
    end
  },

  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '⨯',
      [vim.diagnostic.severity.WARN]  = '▲',
      [vim.diagnostic.severity.INFO]  = 'ℹ',
      [vim.diagnostic.severity.HINT]  = '⚑',
    },
  },

  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = true,
    scope = 'cursor',
    close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
  },
})

-- Show diagnostic on cursor
vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    vim.diagnostic.open_float()
  end
})

-- Show diagnostic list
vim.keymap.set('n', '<leader>d', function()
  vim.diagnostic.setqflist()
  vim.cmd('copen')
end, { silent = true })

-- LSP attach keymaps (good compatible with blink.nvim)
-- local lsp_highlight_group = vim.api.nvim_create_augroup('lsp-highlight', { clear = true })

--[[
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then return end

    -- Local helper for buffer-specific keymaps
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- Keymaps
    map('gl', vim.diagnostic.open_float, 'Open Diagnostic Float')
    map('K', vim.lsp.buf.hover, 'Hover Documentation')
    map('gs', vim.lsp.buf.signature_help, 'Signature Documentation')
    map('gD', vim.lsp.buf.declaration, 'Goto Declaration')
    map('<leader>la', vim.lsp.buf.code_action, 'Code Action')
    -- map('<leader>lr', vim.lsp.buf.rename, 'Rename all references')
    map('<leader>lr', function() Snacks.rename.rename_file() end, 'Rename file & references')
    map('<leader>lf', vim.lsp.buf.format, 'Format')
    map('<leader>v', '<cmd>vsplit | lua vim.lsp.buf.definition()<cr>', 'Goto Definition in Vertical Split')

    --[[ Document Highlight handling (Neovim 0.12 clean API)
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = lsp_highlight_group,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = lsp_highlight_group,
        callback = vim.lsp.buf.clear_references,
      })

      -- When this specific LSP detaches, clean up its local autocmds
      vim.api.nvim_create_autocmd('LspDetach', {
        buffer = event.buf,
        callback = function(detach_event)
          if detach_event.data.client_id == client.id then
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = lsp_highlight_group, buffer = detach_event.buf }
          end
        end,
      })
    end
    --]]
  --end,
--})
