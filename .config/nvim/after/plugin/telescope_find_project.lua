local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local sorters = require('telescope.sorters')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local function get_directories()
  local cmd = [[
    find ~/Documents -maxdepth 2 -type d -not -path '*/\.*' && \
    find ~/Downloads -maxdepth 2 -type d -not -path '*/\.*' && \
    find ~/Desktop -maxdepth 2 -type d -not -path '*/\.*' && \
    find ~/.dotfiles -maxdepth 2 -type d -not -path '*/\.git*'
  ]]
  local handle = io.popen(cmd)

  if not handle then
    print("Error: Failed to run shell command.")
    return {}
  end

  local result = handle:read("*a")
  handle:close()

  local directories = {}
  for dir in result:gmatch("[^\n]+") do
    table.insert(directories, dir)
  end

  return directories
end

local function open_directory_in_netrw(prompt_bufnr)
  local selection = action_state.get_selected_entry()
  actions.close(prompt_bufnr)
  vim.cmd('Explore ' .. selection.value)
end

local function directory_picker()
  local directories = get_directories()

  pickers.new({}, {
    prompt_title = 'Custom Directories',
    finder = finders.new_table {
      results = directories,
      entry_maker = function(entry)
        local home = os.getenv("HOME")
        local display_entry = entry:gsub("^" .. home, "~")
        return {
          value = entry,
          display = display_entry,
          ordinal = display_entry,
        }
      end,
    },
    sorter = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(_, map)
      map('i', '<CR>', open_directory_in_netrw)
      map('n', '<CR>', open_directory_in_netrw)
      return true
    end,
  }):find()
end

_G.directory_picker = directory_picker
vim.cmd('command! FindProject lua _G.directory_picker()')
vim.keymap.set("n", "<leader>fp", "<cmd>FindProject<cr>")
