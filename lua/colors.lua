local mocha = {
  rosewater = '#f5e0dc', flamingo = '#f2cdcd', pink = '#f5c2e7',
  mauve = '#cba6f7', red = '#f38ba8', maroon = '#eba0ac',
  peach = '#fab387', yellow = '#f9e2af', green = '#a6e3a1',
  teal = '#94e2d5', sky = '#89dceb', sapphire = '#74c7ec',
  blue = '#89b4fa', lavender = '#b4befe', text = '#cdd6f4',
  subtext1 = '#bac2de', subtext0 = '#a6adc8', overlay2 = '#9399b2',
  overlay1 = '#7f849c', overlay0 = '#6c7086', surface2 = '#585b70',
  surface1 = '#45475a', surface0 = '#313244', base = '#1e1e2e',
  mantle = '#181825', crust = '#11111b',
}

if vim.g.colors_name == 'catppuccin' then 
  vim.api.nvim_set_hl(0, '@variable', { fg = mocha.text })
  vim.api.nvim_set_hl(0, '@variable.parameter', { fg = mocha.red })
  vim.api.nvim_set_hl(0, '@variable.member', { fg = mocha.lavender })
  -- vim.api.nvim_set_hl(0, '@module',           { fg = mocha.lavender, italic = true })
  vim.api.nvim_set_hl(0, '@type.builtin',     { fg = mocha.yellow, italic = true })
  -- vim.api.nvim_set_hl(0, '@property',         { fg = mocha.lavender })
  vim.api.nvim_set_hl(0, '@constructor',      { fg = mocha.sapphire })
  -- vim.api.nvim_set_hl(0, '@keyword.operator', { link = 'Operator' })
  -- vim.api.nvim_set_hl(0, '@keyword.export',   { fg = mocha.blue })
  vim.api.nvim_set_hl(0, '@tag',              { fg = mocha.mauve })
  vim.api.nvim_set_hl(0, '@tag.builtin',      { fg = mocha.mauve })
  vim.api.nvim_set_hl(0, '@tag.attribute',    { fg = mocha.teal , italic = true })
  vim.api.nvim_set_hl(0, '@tag.delimiter',    { fg = mocha.blue })

  vim.api.nvim_set_hl(0, '@lsp.type.variable',  { fg = mocha.text })
  vim.api.nvim_set_hl(0, '@lsp.type.parameter', { fg = mocha.red })
  vim.api.nvim_set_hl(0, '@lsp.type.property',  { fg = mocha.blue })
  vim.api.nvim_set_hl(0, '@lsp.type',   { fg = mocha.yellow })

  for _, group in ipairs({
    'NvimTreeNormal',
    'NvimTreeNormalFloat',
    'NvimTreeNormalNC'
  }) do
    -- TODO: what is this hl?
    vim.api.nvim_set_hl(0, group, { fg = mocha.text })
  end

  vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = mocha.red })
  vim.api.nvim_set_hl(0, 'DiagnosticWarn',  { fg = mocha.yellow })
  vim.api.nvim_set_hl(0, 'DiagnosticInfo',  { fg = mocha.sky })
  vim.api.nvim_set_hl(0, 'DiagnosticHint',  { fg = mocha.teal })
end

vim.api.nvim_set_hl(0, 'GitSignsChange', { link = 'WarningMsg' })
vim.api.nvim_set_hl(0, 'NvimTreeGitDeletedIcon', { link = 'Removed' })
vim.api.nvim_set_hl(0, 'NvimTreeGitDirtyIcon', { link = 'WarningMsg' })
vim.api.nvim_set_hl(0, 'NvimTreeGitNewIcon', { link = 'Directory' })

vim.api.nvim_set_hl(0, 'NvimTreeFolderIcon', { link = 'Directory' })

vim.api.nvim_set_hl(0, 'FloatBorder', { link = 'FloatTitle' })
