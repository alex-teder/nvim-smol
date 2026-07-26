require "keymaps"
require "sets"
require "colors"
require "lsp"

require "plugins.vim-fugitive"
require "plugins.gitsigns"
require "plugins.indent-blankline"
require "plugins.nvim-treesitter"
require "plugins.nvim-tree"
require "plugins.mason"
require "plugins.cloak"
require "plugins.conform"
require "plugins.nvim-lint"
require "plugins.lualine"
require "plugins.telescope"
require "plugins.lorem"
-- TODO: harpoon, AI, markdown, more lsps

require "modules.toggle-transparent-bg"
require "modules.osc52"

vim.cmd.packadd("nvim.undotree")

local lsps = {
  'vtsls',
  'lua-language-server',
  'oxlint'
}

local tools = {
  'prettierd',
  'oxfmt',
  'eslint_d',
}

for _, s in ipairs(lsps) do
  vim.lsp.enable(s)
end

require("mason-tool-installer").setup {
  ensure_installed =
      vim.list_extend(lsps, tools)
  ,
  auto_update = true
}
