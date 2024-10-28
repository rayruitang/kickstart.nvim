return {
  {
    lazy = false,
    'ellisonleao/gruvbox.nvim',
    priotity = 1000,
    config = function()
      require('gruvbox').setup {
        overrides = {
          -- THIS BLOCK
          SignColumn = { bg = '#282828' },
          -- NvimTreeCutHL = { fg = '#fb4934', bg = '#282828' },
          -- NvimTreeCopiedHL = { fg = '#b8bb26', bg = '#282828' },
          DiagnosticSignError = { fg = '#fb4934', bg = '#282828' },
          DiagnosticSignWarn = { fg = '#fabd2f', bg = '#282828' },
          DiagnosticSignHint = { fg = '#8ec07c', bg = '#282828' },
          DiagnosticSignInfo = { fg = '#d3869b', bg = '#282828' },
          -- OR THIS BLOCK
          -- NvimTreeCutHL = { fg="#fb4934", bg="#3c3836" },
          -- NvimTreeCopiedHL = { fg="#b8bb26", bg="#3c3836" }
          -- END
        },
      }
      vim.cmd.colorscheme 'gruvbox'
      -- vim.cmd.hi 'Comment gui=none'
    end,
  },
  -- {
  --   'catppuccin/nvim',
  --   name = 'catppuccin',
  -- },
  -- { 'rose-pine/neovim', name = 'rose-pine' },
  -- 'folke/tokyonight.nvim',
}
-- vim: ts=2 sts=2 sw=2 et
