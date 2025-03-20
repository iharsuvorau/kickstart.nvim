return {
  'stevanmilic/nvim-lspimport',
  config = function()
    vim.api.nvim_set_keymap('n', '<leader>i', ':lua require("lspimport").import()<CR>', { desc = 'Resolve import errors', noremap = true })
  end,
}
