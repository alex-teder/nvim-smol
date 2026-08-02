vim.pack.add({ "https://github.com/zbirenbaum/copilot.lua" }, { load = true })

require("copilot").setup({
  suggestion = {
    enabled = true,
    auto_trigger = true,
    keymap = {
      accept = "<tab>",
    },
  },
  panel = { enabled = false },
  nes = { enabled = false },
  filetypes = {
    gitcommit = true,
  },
})
