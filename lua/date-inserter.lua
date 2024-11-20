local M = {}

function M.insert_date()
  local date = tostring(os.date '%Y-%m-%d')
  vim.api.nvim_put({ date }, 'c', true, true)
end

vim.api.nvim_create_user_command('InsertDate', M.insert_date, {})

return M
