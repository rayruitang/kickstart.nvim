return {
  {
    lazy = false,
    'catppuccin/nvim',
    name = 'catppuccin',
    priotity = 1000,
    config = function()
      vim.cmd.colorscheme 'catppuccin-frappe'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  { 'rose-pine/neovim', name = 'rose-pine' },
  'folke/tokyonight.nvim',
}
-- vim: ts=2 sts=2 sw=2 et
