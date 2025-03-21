vim.keymap.set('n', '<leader>l', '<cmd>Lazy<CR>', { desc = 'Lazy' })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Elixir keymaps for Neovim
vim.keymap.set('n', '<leader>ec', ':w<CR>:!elixirc %<CR>', { noremap = true, silent = true, desc = 'Compile the file' })
vim.keymap.set('n', '<leader>er', ':w<CR>:!elixir %<CR>', { noremap = true, silent = true, desc = 'Run the file' })
vim.keymap.set('n', '<leader>et', ':!mix test %<CR>', { noremap = true, silent = true, desc = 'Test the file' })
vim.keymap.set('n', '<leader>ea', ':!mix test<CR>', { noremap = true, silent = true, desc = 'Test all' })
vim.keymap.set('n', '<leader>ef', ':!mix format %<CR>', { noremap = true, silent = true, desc = 'Format the file' })
vim.keymap.set('n', '<leader>en', ':call search("^defp\\|^def\\|^defmodule")<CR>', { noremap = true, silent = true, desc = 'Next function' })
vim.keymap.set('n', '<leader>ep', ':call search("^defp\\|^def\\|^defmodule", "b")<CR>', { noremap = true, silent = true, desc = 'Previous function' })

-- Go
vim.keymap.set('n', '<space>td', function()
  require('dap-go').debug_test()
end, { buffer = 0 })
