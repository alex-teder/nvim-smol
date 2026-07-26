local saved = {
  Normal       = vim.api.nvim_get_hl(0, { name = 'Normal',       link = false }),
  NormalNC     = vim.api.nvim_get_hl(0, { name = 'NormalNC',     link = false }),
  StatusLine   = vim.api.nvim_get_hl(0, { name = 'StatusLine',   link = false }),
  StatusLineNC = vim.api.nvim_get_hl(0, { name = 'StatusLineNC', link = false }),
}
local transparent = false

local function toggle_bg()
  transparent = not transparent
  if transparent then
    vim.api.nvim_set_hl(0, 'Normal',   { bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'NONE' })
  else
    vim.api.nvim_set_hl(0, 'Normal',   saved.Normal)
    vim.api.nvim_set_hl(0, 'NormalNC', saved.NormalNC)
    vim.api.nvim_set_hl(0, 'StatusLine',   saved.StatusLine)
    vim.api.nvim_set_hl(0, 'StatusLineNC', saved.StatusLineNC)
  end
end

vim.api.nvim_create_user_command('ToggleBg', toggle_bg, { desc = 'Toggle transparent background' })
vim.cmd("ToggleBg") -- set to transparent from the start
