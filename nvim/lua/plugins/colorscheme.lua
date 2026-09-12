return {
  'savq/melange-nvim',
  lazy = false,
  priority = 1000,
  config = function()
    if vim.env.TERM == 'linux' then
      return
    end

    vim.cmd.colorscheme('melange')
  end
}
