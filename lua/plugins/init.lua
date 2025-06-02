return {
  {
    dir = vim.fn.stdpath 'config' .. '/lua/local/github-opener',
    config = function()
      vim.keymap.set('n', '<leader>gh', ':OpenGitHub<cr>', { noremap = true, silent = true, desc = 'Open GitHub' })
      vim.keymap.set('n', '<leader>gf', ':OpenGitHubFile<cr>', { noremap = true, silent = true, desc = 'Open file in GitHub' })
    end,
    opts = {},
  },
}
