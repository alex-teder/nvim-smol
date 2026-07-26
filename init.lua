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

require "modules.toggle-transparent-bg"
require "modules.osc52"

vim.cmd.packadd("nvim.undotree")

vim.lsp.enable('vtsls')
vim.lsp.enable('lua-language-server')
