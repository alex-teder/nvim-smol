vim.pack.add({
  { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" }
})

local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>a", function()
  harpoon:list():add()
  vim.notify("-- file added! --")
end)
-- vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

for i = 1, 5 do
  vim.keymap.set("n", "<leader>" .. i, function()
    harpoon:list():select(i)
    vim.notify(string.format("-- jump to %s --", i))
  end)
end

-- basic telescope configuration
local conf = require("telescope.config").values
local themes = require("telescope.themes")
local telescope_state = require("telescope.actions.state")
local finders = require("telescope.finders")
local C = require("modules.palette")

local make_finder = function()
  local paths = {}
  for i, item in ipairs(harpoon:list().items) do
    table.insert(paths, {
      value = item.value,
      display = i .. ". " .. item.value,
      ordinal = item.value,
    })
  end
  return finders.new_table({
    results = paths,
    entry_maker = function(entry)
      return {
        value = entry.value,
        display = entry.display,
        ordinal = entry.ordinal,
      }
    end,
  })
end

local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers").new(themes.get_ivy({
    initial_mode = "normal",
  }), {
    prompt_title = "Harpoon",
    finder = make_finder(),
    previewer = conf.file_previewer({}),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_buffer_number, map)
      map("n", "dd", function()
        local selected_entry = telescope_state.get_selected_entry()
        local current_picker = telescope_state.get_current_picker(prompt_buffer_number)
        table.remove(harpoon:list().items, selected_entry.index) -- hack?
        current_picker:refresh(make_finder())
      end)
      vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = C.red })
      return true
    end,
  }):find()
end

vim.keymap.set("n", "<leader>e", function() toggle_telescope(harpoon:list()) end,
  { desc = "Open harpoon window" })
