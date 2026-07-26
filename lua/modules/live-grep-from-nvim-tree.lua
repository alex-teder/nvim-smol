local api = require("nvim-tree.api")
local C = require("modules.palette")

local function live_grep_from_nvim_tree()
  local node = api.tree.get_node_under_cursor()
  local dir_path

  if node.type == "directory" then
    dir_path = node.absolute_path
  else
    -- If it's a file, get its parent directory
    dir_path = vim.fn.fnamemodify(node.absolute_path, ":h")
  end

  -- Open Telescope live_grep in the selected directory
  vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = C.green })
  require("telescope.builtin").live_grep({
    cwd = dir_path,
    prompt_title = "grep: " .. dir_path .. "/",
  })
end

return live_grep_from_nvim_tree
