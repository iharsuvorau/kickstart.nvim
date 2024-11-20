-- [[ Linux specific settings ]]
local function is_arch_linux()
  local os_info = vim.loop.os_uname()
  return os_info.sysname == 'Linux' and os_info.release:match 'arch'
end

if is_arch_linux() then
  -- Issue when copying in nvim via SSH
  -- https://github.com/neovim/neovim/issues/6695#issuecomment-586665923
  vim.cmd 'set clipboard+=unnamedplus'
  -- Wayland system clipboard
  vim.g.clipboard = {
    name = 'myClipboard',
    copy = {
      ['+'] = 'wl-copy',
      ['*'] = 'wl-copy',
    },
    paste = {
      ['+'] = 'wl-paste -n',
      ['*'] = 'wl-paste -n',
    },
    cache_enabled = 0,
  }
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- [[ Setting alias commands ]]
-- These are frequent typos
vim.cmd 'command! W w'
vim.cmd 'command! Wa wa'
vim.cmd 'command! Q q'
vim.cmd 'command! Qa qa'

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
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

-- Compile the current file
vim.keymap.set('n', '<leader>ec', ':w<CR>:!elixirc %<CR>', { noremap = true, silent = true, desc = 'Compile the file' })
-- Run the current file
vim.keymap.set('n', '<leader>er', ':w<CR>:!elixir %<CR>', { noremap = true, silent = true, desc = 'Run the file' })
-- Run tests in the current file
vim.keymap.set('n', '<leader>et', ':!mix test %<CR>', { noremap = true, silent = true, desc = 'Test the file' })
-- Run all tests
vim.keymap.set('n', '<leader>ea', ':!mix test<CR>', { noremap = true, silent = true, desc = 'Test all' })
-- Format the current file
vim.keymap.set('n', '<leader>ef', ':!mix format %<CR>', { noremap = true, silent = true, desc = 'Format the file' })
-- Navigate to the next function
vim.keymap.set('n', '<leader>en', ':call search("^defp\\|^def\\|^defmodule")<CR>', { noremap = true, silent = true, desc = 'Next function' })
-- Navigate to the previous function
vim.keymap.set('n', '<leader>ep', ':call search("^defp\\|^def\\|^defmodule", "b")<CR>', { noremap = true, silent = true, desc = 'Previous function' })

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

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('filetype-specific-settings', { clear = true }),
  pattern = { 'norg' },
  callback = function()
    vim.opt_local.textwidth = 80
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- Run organize go imports on file save
local gofile_au_group = vim.api.nvim_create_augroup('goimports-on-write', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = gofile_au_group,
  pattern = '*.go',
  callback = function()
    vim.lsp.buf.code_action { context = { only = { 'source.organizeImports' } }, apply = true }
    --vim.lsp.buf.code_action { context = { only = { 'source.fixAll' } }, apply = true }
  end,
  desc = 'Organize go imports on save',
})

-- Set file type for Jinja2 files
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = vim.api.nvim_create_augroup('jinja-on-open', { clear = true }),
  pattern = { '*.jinja', '*.jinja2', '*.j2' },
  command = 'set filetype=jinja',
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

vim.keymap.set('n', '<leader>l', '<cmd>Lazy<CR>', { desc = 'Lazy' })

require('lazy').setup({ import = 'custom/plugins' }, {
  change_detection = {
    notify = false,
  },
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

--require 'colors.lush_template'
