return {
  dir = vim.fn.stdpath 'config' .. '/lua/config/notes',
  event = 'VeryLazy',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  keys = {
    { '<leader>nn', desc = 'Open notes directory' },
    { '<leader>nd', desc = 'Create/open daily note' },
    { '<leader>nf', desc = 'Search notes' },
    { '<leader>ng', desc = 'Grep notes content' },
    { '<leader>np', desc = 'Paste clipboard image' },
    { '<leader>ns', desc = 'Take screenshot' },
    { '<leader>ni', desc = 'Import file as asset' },
    { '<leader>nr', desc = 'Recent notes' },
    { '<leader>nc', desc = 'Create new note' },
  },
  cmd = {
    'NotesNew',
    'NotesDaily',
    'NotesFind',
    'NotesGrep',
  },
  config = function()
    require('config.notes').setup()
  end,
}
