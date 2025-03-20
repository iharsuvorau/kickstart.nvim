return {
  -- {
  --   'rafi/awesome-vim-colorschemes',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme 'tender'
  --   end,
  -- },
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
