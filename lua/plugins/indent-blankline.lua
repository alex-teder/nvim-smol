vim.pack.add({
  "https://github.com/lukas-reineke/indent-blankline.nvim",
})

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "IblIndent", { link = "NonText" })
  end,
})

require("ibl").setup({
  indent = { char = "┊" },
  scope = { enabled = false },
})
