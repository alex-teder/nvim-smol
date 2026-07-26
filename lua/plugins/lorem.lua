vim.pack.add { 'https://github.com/derektata/lorem.nvim' }

require('lorem').setup {
  sentence_length = "mixed",
  comma_chance = 0.3,
  max_commas = 2,
}
