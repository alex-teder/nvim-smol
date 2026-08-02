local opt = vim.opt

opt.nu = true
opt.rnu = true

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.wrap = false
opt.smartindent = true
opt.inccommand = "split"

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

opt.scrolloff = 8
opt.termguicolors = true
opt.signcolumn = "yes"

opt.swapfile = false
opt.writebackup = false

opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undodir"

opt.foldmethod = "indent"
opt.foldenable = false
opt.foldlevelstart = 99

vim.o.winborder = "rounded"

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    if vim.hl.hl_op then
      vim.hl.hl_op()
    else
      vim.highlight.on_yank()
    end
  end,
})

vim.g.omni_sql_default_compl_type = "syntax"

vim.cmd('colorscheme catppuccin')

-- require("vim._core.ui2").enable()
