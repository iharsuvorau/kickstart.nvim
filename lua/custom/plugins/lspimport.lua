return {
  'stevanmilic/nvim-lspimport',
  config = function()
    vim.api.nvim_set_keymap('n', '<leader>pi', ':lua require("lspimport").import()<CR>', { noremap = true })
  end,
}
