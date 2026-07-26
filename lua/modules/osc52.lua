local osc52 = require("vim.ui.clipboard.osc52")

vim.g.clipboard = {
  name = "osc52",
  copy = {
    ["+"] = osc52.copy("+"),
    ["*"] = osc52.copy("*"),
  },
  paste = {
    ["+"] = osc52.paste("+"),
    ["*"] = osc52.paste("+"),
  },
}

vim.keymap.set({ "n", "x", 'v' }, "<leader>yv", '"+y', { desc = "Yank to OSC 52" })
