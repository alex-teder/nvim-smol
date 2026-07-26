local opt = vim.opt

opt.nu = true
opt.rnu = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.wrap = false

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

opt.scrolloff = 8
opt.termguicolors = true
opt.signcolumn = "yes"

opt.swapfile = false
opt.writebackup = false

opt.foldmethod = "indent"
opt.foldenable = false
opt.foldlevelstart = 99

vim.o.winborder = "rounded"

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.hl.hl_op() end,
})

vim.g.omni_sql_default_compl_type = "syntax"

vim.cmd('colorscheme catppuccin')

-- require("vim._core.ui2").enable()
