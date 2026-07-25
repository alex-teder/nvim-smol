vim.pack.add({
  "https://github.com/lewis6991/gitsigns.nvim"
})

require("gitsigns").setup({
  signs_staged_enable = false,
})

vim.keymap.set("n", "<leader>gn", ":Gitsigns next_hunk<CR>zz", { silent = true })
vim.keymap.set("n", "<leader>gN", ":Gitsigns prev_hunk<CR>zz", { silent = true })
vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { silent = true })
vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { silent = true })
vim.keymap.set("n", "<leader>gR", ":Gitsigns reset_buffer<CR>", { silent = true })
vim.keymap.set("n", "<leader>gs", ":Gitsigns stage_hunk<CR>", { silent = true })
vim.keymap.set("n", "<leader>gS", ":Gitsigns stage_buffer<CR>", { silent = true })
