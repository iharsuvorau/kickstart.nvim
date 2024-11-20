local function is_arch_linux()
  local os_info = vim.loop.os_uname()
  return os_info.sysname == 'Linux' and os_info.release:match 'arch'
end

if is_arch_linux() then
  -- Issue when copying in nvim via SSH
  -- https://github.com/neovim/neovim/issues/6695#issuecomment-586665923
  vim.cmd 'set clipboard+=unnamedplus'
  -- Wayland system clipboard
  vim.g.clipboard = {
    name = 'myClipboard',
    copy = {
      ['+'] = 'wl-copy',
      ['*'] = 'wl-copy',
    },
    paste = {
      ['+'] = 'wl-paste -n',
      ['*'] = 'wl-paste -n',
    },
    cache_enabled = 0,
  }
end
