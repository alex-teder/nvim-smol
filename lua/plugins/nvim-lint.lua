vim.pack.add({ "https://github.com/mfussenegger/nvim-lint" })

vim.env.ESLINT_D_PPID = vim.fn.getpid()

local lint = require("lint")

lint.linters_by_ft = {
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
}

-- lint.linters.eslint_d = require("lint.util").wrap(lint.linters.eslint_d, function(diagnostic)
--   if diagnostic.message:find("Error: Could not find config file") then
--     return nil
--   end
--   return diagnostic
-- end)

-- local package_json = vim.fs.find("package.json", {
-- 	path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
-- 	upward = true,
-- })[1]
-- if package_json then
-- 	lint.linters.eslint_d.cwd = vim.fs.dirname(package_json)
-- end

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})
