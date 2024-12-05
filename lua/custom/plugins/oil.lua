return {
  'stevearc/oil.nvim',
  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
    keymaps = {
      ['gd'] = function()
        require('oil').set_columns { 'icon', 'permissions', 'size', 'mtime' }
      end,
      ['<C-r>'] = 'refresh',
    },
  },
  keys = {
    { '-', '<cmd>Oil<cr>', desc = 'Open parent directory' },
  },
}
