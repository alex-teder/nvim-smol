vim.pack.add({ "https://github.com/nvim-tree/nvim-tree.lua" })

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  on_attach = function(bufnr)
    local api = require("nvim-tree.api")
    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.del("n", "<C-e>", { buffer = bufnr })

    vim.keymap.set(
      "n",
      "<Esc>",
      api.tree.close,
      { buffer = bufnr, noremap = true, silent = true, nowait = true }
    )

    -- vim.keymap.set("n", "<leader>fg", function()
    --   local node = api.tree.get_node_under_cursor()
    --   local dir_path
    --
    --   if node.type == "directory" then
    --     dir_path = node.absolute_path
    --   else
    --     -- If it's a file, get its parent directory
    --     dir_path = vim.fn.fnamemodify(node.absolute_path, ":h")
    --   end
    --
    --   -- Open Telescope live_grep in the selected directory
    --   vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = C.green })
    --   require("telescope.builtin").live_grep({
    --     cwd = dir_path,
    --     prompt_title = "grep: " .. dir_path .. "/",
    --   })
    -- end, { buffer = bufnr, noremap = true, silent = true })
  end,

  view = {
    signcolumn = "yes",
    float = {
      enable = true,
      open_win_config = function()
        local height = math.floor(vim.o.lines * 0.75)
        local width = math.floor(vim.o.columns * 0.7)
        return {
          title = "nvim-tree",
          title_pos = "center",
          relative = "editor",
          border = "rounded",
          height = height,
          width = width,
          row = math.floor((vim.o.lines - height - 2) / 2),
          col = math.floor((vim.o.columns - width - 2) / 2),
        }
      end,
    },
  },

  renderer = { icons = { diagnostics_placement = "before" } },

  diagnostics = {
    enable = true,
    show_on_dirs = true,
    debounce_delay = 500,
    severity = { min = vim.diagnostic.severity.ERROR },
    icons = { hint = "H", info = "I", warning = "W", error = "!" },
  },

  update_focused_file = { enable = true },

  filters = { custom = { "^.git$" } },

  git = { enable = true, ignore = false, timeout = 2000 },
})

vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>", { silent = true })
