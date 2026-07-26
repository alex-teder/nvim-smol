vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

local formatters = { "oxfmt", "prettierd", stop_after_first = true }

require("conform").setup {
  format_on_save = {
    timeout_ms = 2500,
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = formatters,
    typescript = formatters,
    javascriptreact = formatters,
    typescriptreact = formatters,
    css = formatters,
    html = formatters,
    json = formatters,
    jsonc = formatters,
    yaml = formatters,
    markdown = formatters,
  }
}
