return {
  {
    'mikesmithgh/gruvsquirrel.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd.colorscheme 'gruvsquirrel'
    end,
  },
}
