vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

local function pick_formatters(buf)
  local has_prettier = vim.fs.find(
    { ".prettierrc", ".prettierrc.json", ".prettierrc.yml", ".prettierrc.toml", "prettier.config.js" },
    { upward = true, path = vim.fs.dirname(vim.api.nvim_buf_get_name(buf)) }
  )[1] ~= nil

  local has_oxfmt = vim.fs.find(
    { ".oxfmtrc.json", ".oxfmtrc.jsonc", "oxfmt.config.ts", "oxfmt.config.ts" },
    { upward = true, path = vim.fs.dirname(vim.api.nvim_buf_get_name(buf)) }
  )[1] ~= nil

  if has_prettier then return { "prettierd" } end
  if has_oxfmt then return { "oxfmt" } end
  return { "prettierd", "oxfmt", stop_after_first = true } -- fallback
end

require("conform").setup {
  format_on_save = {
    timeout_ms = 2500,
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    javascript = pick_formatters,
    typescript = pick_formatters,
    javascriptreact = pick_formatters,
    typescriptreact = pick_formatters,
    css = pick_formatters,
    html = pick_formatters,
    json = pick_formatters,
    jsonc = pick_formatters,
    yaml = pick_formatters,
    markdown = pick_formatters,
  }
}
