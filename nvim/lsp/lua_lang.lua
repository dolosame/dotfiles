return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_makers = { '.luarc.json', '.git' },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { 'vim' }, },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
    },
  },
}
