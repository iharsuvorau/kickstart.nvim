local function is_deno_project()
  return vim.fn.glob 'deno.json' ~= '' or vim.fn.glob 'deno.jsonc' ~= ''
end

local function is_node_project()
  return vim.fn.glob 'package.json' ~= ''
end

return {
  'dense-analysis/ale',
  config = function()
    local g = vim.g

    -- g.ale_ruby_rubocop_auto_correct_all = 1

    -- g.ale_linters = {
    --   ruby = { 'rubocop', 'ruby' },
    --   lua = { 'lua_language_server' },
    -- }

    if is_deno_project() then
      vim.g.ale_linters = {
        javascript = { 'denols' },
        typescript = { 'denols' },
      }
    elseif is_node_project() then
      vim.g.ale_linters = {
        javascript = { 'ts_ls' },
        typescript = { 'ts_ls' },
      }
    else
      vim.g.ale_linters = {
        javascript = {},
        typescript = {},
      }
    end

    vim.g.markdown_fenced_languages = {
      'ts=typescript',
    }
  end,
}
