return {
  'mattn/emmet-vim',
  config = function()
    vim.g.user_emmet_settings = {
      elixir = {
        extends = 'html',
      },
      heex = {
        extends = 'html',
      },
      eelixir = {
        extends = 'html',
      },
    }
    vim.g.user_emmet_mode = 'a'
    vim.g.user_emmet_leader_key = '<C-y>'
  end,
}
