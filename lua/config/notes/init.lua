local M = {}

-- Default configuration
local default_config = {
  root_dir = vim.fn.expand '~/notes',
  assets_dir = vim.fn.expand '~/notes/assets',
  -- Default keymaps
  keymaps = {
    open_notes = '<leader>nn',
    daily_note = '<leader>nd',
    search_notes = '<leader>nf',
    grep_notes = '<leader>ng',
    paste_image = '<leader>np',
    screenshot = '<leader>ns',
    import_file = '<leader>ni',
    recent_notes = '<leader>nr',
    new_note = '<leader>nc',
  },
  -- Asset configuration
  assets = {
    -- Supported file types
    types = {
      images = { 'png', 'jpg', 'jpeg', 'gif', 'webp' },
      pdfs = { 'pdf' },
      attachments = { 'zip', 'doc', 'docx', 'xls', 'xlsx' },
    },
    -- Screenshots
    screenshot_cmd = vim.fn.has 'mac' == 1 and 'screencapture -i' or 'maim -s',
    -- Clipboard
    clipboard_cmd = vim.fn.has 'mac' == 1 and 'pngpaste' or 'xclip -selection clipboard -t image/png -o',
  },
}

-- Utility functions
local utils = {
  -- Generate timestamp-based filename
  generate_filename = function(extension)
    return os.date '%Y%m%d_%H%M%S' .. '.' .. extension
  end,

  -- Get year-month folder path
  get_date_folder = function()
    return os.date '%Y-%m'
  end,

  -- Ensure directory exists
  ensure_dir = function(dir)
    local expanded = vim.fn.expand(dir)
    if vim.fn.isdirectory(expanded) == 0 then
      vim.fn.mkdir(expanded, 'p')
    end
    return expanded
  end,

  -- Get asset type from file extension
  get_asset_type = function(file, config)
    local ext = string.lower(file:match '^.+%.(.+)$' or '')
    for type, extensions in pairs(config.assets.types) do
      for _, valid_ext in ipairs(extensions) do
        if ext == valid_ext then
          return type
        end
      end
    end
    return 'attachments'
  end,
}

-- Core functionality
local function create_directories(config)
  local dirs = {
    config.root_dir,
    config.root_dir .. '/daily',
    config.root_dir .. '/projects',
    config.root_dir .. '/areas',
    config.root_dir .. '/reference',
    config.root_dir .. '/archive',
    config.root_dir .. '/templates',
    config.assets_dir,
    config.assets_dir .. '/images',
    config.assets_dir .. '/images/screenshots',
    config.assets_dir .. '/pdfs',
    config.assets_dir .. '/attachments',
  }

  for _, dir in ipairs(dirs) do
    utils.ensure_dir(dir)
  end
end

local function save_asset(source_path, config)
  local asset_type = utils.get_asset_type(source_path, config)
  local date_folder = utils.get_date_folder()
  local target_dir = string.format('%s/%s/%s', config.assets_dir, asset_type, date_folder)

  utils.ensure_dir(target_dir)

  local ext = source_path:match '^.+%.(.+)$'
  local new_filename = utils.generate_filename(ext)
  local target_path = string.format('%s/%s', target_dir, new_filename)

  vim.fn.system(string.format('cp "%s" "%s"', source_path, target_path))

  return string.format('../assets/%s/%s/%s', asset_type, date_folder, new_filename)
end

-- Setup keymaps and commands
local function setup_keymaps(config)
  -- Basic note navigation
  vim.keymap.set('n', config.keymaps.open_notes, function()
    vim.cmd('e ' .. config.root_dir)
  end, { desc = 'Open notes directory' })

  vim.keymap.set('n', config.keymaps.daily_note, function()
    local path = string.format('%s/daily/%s.md', config.root_dir, os.date '%Y-%m-%d')
    vim.cmd('e ' .. path)
  end, { desc = 'Create/open daily note' })

  -- Telescope integration
  vim.keymap.set('n', config.keymaps.search_notes, function()
    require('telescope.builtin').find_files {
      prompt_title = 'Notes',
      cwd = config.root_dir,
      hidden = true,
    }
  end, { desc = 'Search notes' })

  vim.keymap.set('n', config.keymaps.grep_notes, function()
    require('telescope.builtin').live_grep {
      prompt_title = 'Search Notes Content',
      cwd = config.root_dir,
    }
  end, { desc = 'Grep notes content' })

  vim.keymap.set('n', config.keymaps.recent_notes, function()
    require('telescope.builtin').oldfiles {
      cwd = config.root_dir,
      prompt_title = 'Recent Notes',
    }
  end, { desc = 'Recent notes' })

  -- Asset management
  vim.keymap.set('n', config.keymaps.paste_image, function()
    local temp_file = '/tmp/clipboard_image.png'
    vim.fn.system(string.format('%s > "%s"', config.assets.clipboard_cmd, temp_file))

    if vim.fn.filereadable(temp_file) == 1 then
      local relative_path = save_asset(temp_file, config)
      local markdown_link = string.format('![image](%s)', relative_path)
      vim.api.nvim_put({ markdown_link }, 'l', true, true)
      os.remove(temp_file)
    end
  end, { desc = 'Paste clipboard image' })

  vim.keymap.set('n', config.keymaps.screenshot, function()
    local timestamp = os.date '%Y%m%d_%H%M%S'
    local filename = string.format('screenshot_%s.png', timestamp)
    local target_dir = utils.ensure_dir(config.assets_dir .. '/images/screenshots')
    local target_path = string.format('%s/%s', target_dir, filename)

    vim.fn.system(string.format('%s "%s"', config.assets.screenshot_cmd, target_path))

    if vim.fn.filereadable(target_path) == 1 then
      local markdown_link = string.format('![screenshot](../assets/images/screenshots/%s)', filename)
      vim.api.nvim_put({ markdown_link }, 'l', true, true)
    end
  end, { desc = 'Take screenshot' })

  vim.keymap.set('n', config.keymaps.import_file, function()
    vim.ui.input({ prompt = 'Path to file: ' }, function(input)
      if input then
        local relative_path = save_asset(input, config)
        local filename = input:match '([^/]+)$'
        local markdown_link

        if utils.get_asset_type(input, config) == 'images' then
          markdown_link = string.format('![%s](%s)', filename, relative_path)
        else
          markdown_link = string.format('[%s](%s)', filename, relative_path)
        end

        vim.api.nvim_put({ markdown_link }, 'l', true, true)
      end
    end)
  end, { desc = 'Import file as asset' })

  -- Create new note
  vim.keymap.set('n', config.keymaps.new_note, function()
    vim.ui.input({ prompt = 'Note name: ' }, function(input)
      if input and input ~= '' then
        local path = string.format('%s/%s.md', config.root_dir, input)
        vim.cmd('e ' .. path)
        local template = {
          '# ' .. input,
          '',
          'Created: ' .. os.date '%Y-%m-%d',
          'Tags: ',
          '',
          '## Content',
          '',
          '## Related',
          '- ',
        }
        vim.api.nvim_buf_set_lines(0, 0, 0, false, template)
      end
    end)
  end, { desc = 'Create new note' })
end

local function setup_commands(config)
  vim.api.nvim_create_user_command('NotesNew', function(opts)
    local name = opts.args
    if name and name ~= '' then
      local path = string.format('%s/%s.md', config.root_dir, name)
      vim.cmd('e ' .. path)
    else
      vim.cmd(string.format('lua vim.keymap.set("%s")', config.keymaps.new_note))
    end
  end, { nargs = '?', desc = 'Create new note' })

  vim.api.nvim_create_user_command('NotesDaily', function()
    vim.cmd(string.format('lua vim.keymap.set("%s")', config.keymaps.daily_note))
  end, { desc = 'Open daily note' })

  vim.api.nvim_create_user_command('NotesFind', function()
    vim.cmd(string.format('lua vim.keymap.set("%s")', config.keymaps.search_notes))
  end, { desc = 'Find notes' })

  vim.api.nvim_create_user_command('NotesGrep', function()
    vim.cmd(string.format('lua vim.keymap.set("%s")', config.keymaps.grep_notes))
  end, { desc = 'Search notes content' })
end

-- Main setup function
function M.setup(opts)
  local config = vim.tbl_deep_extend('force', default_config, opts or {})

  -- Ensure all directories exist
  create_directories(config)

  -- Setup keymaps and commands
  setup_keymaps(config)
  setup_commands(config)
end

return M
