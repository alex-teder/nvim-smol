local C = require("modules.palette")

if vim.g.colors_name == 'catppuccin' then
  vim.api.nvim_set_hl(0, '@variable', { fg = C.text })
  vim.api.nvim_set_hl(0, '@variable.parameter', { fg = C.red })
  vim.api.nvim_set_hl(0, '@variable.member', { fg = C.lavender })
  -- vim.api.nvim_set_hl(0, '@module',           { fg = C.lavender, italic = true })
  vim.api.nvim_set_hl(0, '@variable.builtin', { fg = C.peach, italic = true })
  -- vim.api.nvim_set_hl(0, '@property',         { fg = C.lavender })
  vim.api.nvim_set_hl(0, '@constructor', { fg = C.sapphire })
  -- vim.api.nvim_set_hl(0, '@keyword.operator', { link = 'Operator' })
  -- vim.api.nvim_set_hl(0, '@keyword.export',   { fg = C.blue })
  vim.api.nvim_set_hl(0, '@tag', { fg = C.mauve })
  vim.api.nvim_set_hl(0, '@tag.builtin', { fg = C.mauve })
  vim.api.nvim_set_hl(0, '@tag.attribute', { fg = C.teal, italic = true })
  vim.api.nvim_set_hl(0, '@tag.delimiter', { fg = C.blue })

  vim.api.nvim_set_hl(0, '@lsp.type.variable', { fg = C.text })
  vim.api.nvim_set_hl(0, '@lsp.type.parameter', { fg = C.red })
  vim.api.nvim_set_hl(0, '@lsp.type.property', { fg = C.blue })
  vim.api.nvim_set_hl(0, '@lsp.type', { fg = C.yellow })

  for _, group in ipairs({
    'NvimTreeNormal',
    'NvimTreeNormalFloat',
    'NvimTreeNormalNC'
  }) do
    -- TODO: what is this hl?
    vim.api.nvim_set_hl(0, group, { fg = C.text })
  end

  vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = C.red })
  vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = C.yellow })
  vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = C.sky })
  vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = C.teal })
end

vim.api.nvim_set_hl(0, 'GitSignsChange', { link = 'WarningMsg' })
vim.api.nvim_set_hl(0, 'NvimTreeGitDeletedIcon', { link = 'Removed' })
vim.api.nvim_set_hl(0, 'NvimTreeGitDirtyIcon', { link = 'WarningMsg' })
vim.api.nvim_set_hl(0, 'NvimTreeGitNewIcon', { link = 'Directory' })

vim.api.nvim_set_hl(0, 'NvimTreeFolderIcon', { link = 'Directory' })

vim.api.nvim_set_hl(0, 'FloatBorder', { link = 'FloatTitle' })
