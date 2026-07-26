vim.pack.add({ "https://github.com/nvim-telescope/telescope.nvim", "https://github.com/nvim-lua/plenary.nvim" })
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
      local obj = vim.system({ 'make' }, { cwd = ev.data.path }):wait()
      if obj.code ~= 0 then
        vim.notify('Build failed: ' .. obj.stderr, vim.log.levels.ERROR)
      end
    end
  end,
})
vim.pack.add({ "https://github.com/nvim-telescope/telescope-fzf-native.nvim" })

require("telescope").setup {
  defaults = {
    mappings = {
      i = { ["<C-p>"] = require("telescope.actions.layout").toggle_preview, ["<C-c>"] = false },
      n = { ["<C-p>"] = require("telescope.actions.layout").toggle_preview },
    },
    path_display = { "truncate" },
    buffer_previewer_maker = function(filepath, bufnr, opts)
      local f = vim.fn.expand(filepath)
      if f:match("%.env$") then
        return false
      end

      local stat = vim.loop.fs_stat(f)
      if stat and stat.size > 200 * 1024 then -- 200KB
        return false
      end

      require("telescope.previewers").buffer_previewer_maker(filepath, bufnr, opts)
    end,
    selection_caret = "  ",
    prompt_prefix = "󱞩 ",
  },

  pickers = {
    registers = { initial_mode = "normal" },
    git_files = { theme = "ivy", preview = { hide_on_startup = true } },
    live_grep = {
      theme = "ivy",
      disable_coordinates = true,
      additional_args = { "--hidden", "--glob", "!.git/**" },
    },
    git_branches = { theme = "ivy", previewer = false },
    help_tags = { theme = "ivy" },
    lsp_type_definitions = {
      theme = "ivy",
      initial_mode = "normal",
      show_line = false,
    },
    lsp_references = {
      theme = "ivy",
      initial_mode = "normal",
      show_line = false,
    },
    buffers = {
      theme = "ivy",
      show_all_buffers = true,
      sort_lastused = true,
      path_display = { "tail" },
      mappings = {
        n = {
          ["dd"] = "delete_buffer",
        },
      },
    },
    colorscheme = {
      selection_caret = "> ",
      enable_preview = true,
    },
  },
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt",
  callback = function(args)
    vim.bo[args.buf].autocomplete = false
  end,
})

local C = require("modules.palette")
local builtin = require("telescope.builtin")

vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "NONE" })

local default_color = { fg = C.blue }
local colors = {
  registers = { fg = C.pink },
  git_files = { fg = C.yellow },
  live_grep = { fg = C.green },
  help_tags = { fg = C.teal },
  git_branches = { fg = C.mauve },
}

local function handle_open(picker_name)
  return function()
    local color = colors[picker_name]
    vim.api.nvim_set_hl(0, "TelescopeBorder", color or default_color)
    builtin[picker_name]()
  end
end

vim.keymap.set("n", "<leader>ff", handle_open("git_files"), { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fg", handle_open("live_grep"), { noremap = true, silent = true })
vim.keymap.set("n", "<leader>w", handle_open("buffers"), { noremap = true, silent = true })
vim.keymap.set("n", "<leader>gb", handle_open("git_branches"), { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fh", handle_open("help_tags"), { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fr", handle_open("lsp_references"), { noremap = true, silent = true })
vim.keymap.set("n", "<leader>cb", handle_open("registers"), { noremap = true, silent = true })
vim.keymap.set("n", "<leader>re", builtin.resume, { noremap = true, silent = true })

require('telescope').load_extension('fzf')
