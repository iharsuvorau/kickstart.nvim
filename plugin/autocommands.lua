--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- Run organize go imports on file save
local gofile_au_group = vim.api.nvim_create_augroup('goimports-on-write', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = gofile_au_group,
  pattern = '*.go',
  callback = function()
    vim.lsp.buf.code_action { context = { only = { 'source.organizeImports' } }, apply = true }
    --vim.lsp.buf.code_action { context = { only = { 'source.fixAll' } }, apply = true }
  end,
  desc = 'Organize Go imports on save',
})

-- Organize imports on save for Python
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('pythonimports-on-write', { clear = true }),
  pattern = '*.py',
  desc = 'Organize Python imports on save',
  callback = function()
    vim.lsp.buf.code_action { context = { only = { 'source.organizeImports' } }, apply = true }
  end,
})

-- Set file type for Jinja2 files
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = vim.api.nvim_create_augroup('jinja-on-open', { clear = true }),
  pattern = { '*.jinja', '*.jinja2', '*.j2' },
  command = 'set filetype=jinja',
})
