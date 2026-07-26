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

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.hl.hl_op() end,
})

vim.g.omni_sql_default_compl_type = "syntax"

vim.cmd('colorscheme catppuccin')

require("vim._core.ui2").enable()

vim.diagnostic.config({ virtual_text = true, severity_sort = true })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		vim.keymap.set("n", "<leader><space>", function()
			vim.diagnostic.open_float({ source = true, border = "rounded" })
		end, { silent = true, buffer = ev.buf })

    vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end, { silent = true, buffer = true })

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true, buffer = ev.buf })
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { silent = true, buffer = ev.buf })
	end,
})
