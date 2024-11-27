-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    dir = vim.fn.stdpath 'config' .. 'lua/github-opener',
    name = 'github-opener',
    config = function()
      require 'github-opener'
      vim.keymap.set('n', '<leader>gh', ':OpenGitHub<cr>', { noremap = true, silent = true, desc = 'Open GitHub' })
      vim.keymap.set('n', '<leader>gf', ':OpenGitHubFile<cr>', { noremap = true, silent = true, desc = 'Open file in GitHub' })
    end,
    opts = {},
  },
}
