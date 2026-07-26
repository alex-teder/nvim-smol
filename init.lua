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

require "modules.toggle-transparent-bg"
require "modules.osc52"

vim.cmd.packadd("nvim.undotree")

local lsps = {
  'vtsls',
  'lua-language-server',
  'prettierd',
  'oxfmt',
  'eslint_d',
  'oxlint'
}
for _, s in ipairs(lsps) do
  vim.lsp.enable(s)
end

require("mason-tool-installer").setup { ensure_installed = lsps, auto_update = true }
