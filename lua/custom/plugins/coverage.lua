return {
  'andythigpen/nvim-coverage',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
  },
  opts = {
    commands = true,
    auto_reload = true,
  },
  keys = {
    { '<leader>cc', '<cmd>Coverage<cr>', desc = 'Code coverage' },
  },
}
