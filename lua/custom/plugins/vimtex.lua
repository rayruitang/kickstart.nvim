return {
  'lervag/vimtex',
  init = function()
    -- vim.g['vimtex_view_method'] = 'zathura'     -- main variant with xdotool (requires X11; not compatible with wayland)
    vim.g['vimtex_view_method'] = 'skim' -- for variant without xdotool to avoid errors in wayland
    vim.g['vimtex_quickfix_mode'] = 0 -- suppress error reporting on save and build
    vim.g['vimtex_mappings_enabled'] = 0 -- Ignore mappings
    vim.g['vimtex_indent_enabled'] = 0 -- Auto Indent
    vim.g['tex_flavor'] = 'latex' -- how to read tex files
    vim.g['tex_indent_items'] = 0 -- turn off enumerate indent
    vim.g['tex_indent_brace'] = 0 -- turn off brace indent
    vim.g['vimtex_log_ignore'] = { -- Error suppression:
      'Underfull',
      'Overfull',
      'specifier changed to',
      'Token not allowed in a PDF string',
    }
  end,
  config = function()
    vim.keymap.set('n', '<leader>vb', '<cmd>VimtexCompile<CR>', { desc = '[V]imtex [B]uild' })
    vim.keymap.set('n', '<leader>vi', '<cmd>VimtexTocOpen<CR>', { desc = '[V]imtex [I]ndex' })
    vim.keymap.set('n', '<leader>vv', '<cmd>VimtexView<CR>', { desc = '[V]imtex [V]iew' })
    vim.keymap.set('n', '<leader>vc', '<cmd>:VimtexClearCache All<CR>', { desc = '[V]imtex [C]lear Cache' })
    vim.keymap.set('n', '<leader>vC', '<cmd>VimtexClean<CR>', { desc = '[V]imtex [C]lean Aux' })
    vim.keymap.set('n', '<leader>ve', '<cmd>VimtexErrors<CR>', { desc = '[V]imtex [E]rrors' })
    vim.keymap.set('n', '<leader>vm', '<plug>(vimtex-context-menu)', { desc = '[V]imtex [M]enu' })
    vim.keymap.set('n', '<leader>vw', '<cmd>VimtexCountWords!<CR>', { desc = '[V]imtex Count [W]ords' })
  end,
}
-- vim: ts=2 sts=2 sw=2 et
