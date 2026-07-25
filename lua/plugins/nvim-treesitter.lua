vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter"
})

require('nvim-treesitter').setup({})

require('nvim-treesitter').install { 
  "json",
  "javascript",
  "typescript",
  "tsx",
  "yaml",
  "html",
  "css",
  "markdown",
  "markdown_inline",
  "bash",
  "lua",
  "vim",
  "dockerfile",
  "gitignore",
  "query",
  "vimdoc",
  "c",
  "python",
}

vim.api.nvim_create_autocmd('FileType', {
  callback = function() pcall(vim.treesitter.start) end,
})
