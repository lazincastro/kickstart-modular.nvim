return {
  'github/copilot.vim',
  config = function()
    vim.g.copilot_no_tab_map = true
    vim.api.nvim_set_keymap('i', '<C-J>', 'copilot#Accept("<CR>")', { silent = true, expr = true })
    vim.keymap.set('i', '<C-K>', '<Plug>(copilot-accept-line)')
  end,
}
