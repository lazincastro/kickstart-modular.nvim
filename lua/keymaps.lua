-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit insert mode with jj
vim.keymap.set('i', 'jj', '<esc>', { desc = 'Exit insert mode with jj' })

-- Keep window centered when navigating with n and N (zzzv)
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Keybinds for buffers navigation
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev buffer' })
vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next buffer' })

-- Function to open terminal in normal mode insert mode
function OpenTerminal()
  local number_enabled = vim.wo.number
  vim.wo.number = false
  vim.cmd 'split term://$SHELL'
  vim.cmd 'startinsert'
  -- Create an autocommand to re-enable the 'number' option when leaving the terminal buffer
  vim.cmd('autocmd! TermClose * lua vim.wo.number = ' .. tostring(number_enabled))
end

-- Call the function to open terminal
vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>lua OpenTerminal()<cr>', { noremap = true, silent = true, desc = 'Open terminal' })

-- Exit terminal with <esc>
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>:bd!<CR>', { noremap = true, silent = true, desc = 'Exit terminal with <esc>' })

-- Function to toggle line numbers, relative line numbers, and listchars
function ToggleOptions()
  local wo = vim.wo
  if wo.number then
    -- wo.list = false
    wo.number = false
    -- wo.relativenumber = false
    wo.cursorline = false
    wo.cursorcolumn = false
  else
    -- wo.list = true
    wo.number = true
    -- wo.relativenumber = true
    wo.cursorline = true
    wo.cursorcolumn = true
  end
end

-- Map the toggle function to <leader>o
vim.api.nvim_set_keymap(
  'n',
  '<leader>o',
  '<cmd>lua ToggleOptions()<cr>',
  { noremap = true, silent = true, desc = 'Toggle line numbers, relative line numbers, and listchars' }
)

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
