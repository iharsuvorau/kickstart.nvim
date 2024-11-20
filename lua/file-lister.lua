local M = {}

-- Create a buffer for file listing
local function create_file_buffer()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(buf, 'swapfile', false)
  return buf
end

-- List files in a directory
function M.list_files(path)
  local files = vim.fn.readdir(path)
  return files
end

-- Render files in buffer
function M.render_file_list(path)
  local buf = create_file_buffer()
  local files = M.list_files(path)

  -- Set buffer contents
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, files)

  -- Open buffer in a new window
  vim.api.nvim_command 'split'
  vim.api.nvim_win_set_buf(0, buf)
end

-- Create command to trigger file listing
vim.api.nvim_create_user_command('ListFiles', function()
  M.render_file_list '.' -- List files in current directory
end, {})

return M
