vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })

local theme = require('lualine.themes.auto')
theme.normal.c.bg = 'NONE'
theme.insert.c.bg = 'NONE'
theme.visual.c.bg = 'NONE'
theme.replace.c.bg = 'NONE'
theme.command.c.bg = 'NONE'
theme.inactive.c.bg = 'NONE'

require('lualine').setup {
  options = {
    section_separators = '',
    component_separators = '',
    globalstatus = true,
    theme = theme,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      {
        -- 'branch',
        -- fmt = function(name)
        --   return #name > 20 and name:sub(1, 19) .. '…' or name
        -- end,
      },
    },
    lualine_c = {
      { "diff",        color = { bg = 'NONE' }, },
      { "diagnostics", color = { bg = 'NONE' } },
      { 'filename', file_status = true,
        symbols = { modified = "●" }, path = 0, color = { bg = 'NONE' } },
    },
    lualine_x = {
      {
        "lsp_status",
        color = { bg = 'NONE' },
        icon = '🔧',
        symbols = { spinner = { "💭" }, done = "👍" },
        ignore_lsp = { "Augment Server", "copilot" },
        on_click = function() vim.cmd("checkhealth lsp") end,
      },
      {
        function()
          local authenticated = require('copilot.auth').is_authenticated()
          if not authenticated then
            return ""
          end
          local enabled = not require('copilot.client').is_disabled()
          return enabled and "🤖" or "💀"
        end,
        cond = function()
          return vim.bo.filetype ~= "NvimTree" and vim.bo.filetype ~= "fugitive"
        end,
        color = { bg = 'NONE' },
        padding = "none",
        on_click = function()
          local enabled = not require('copilot.client').is_disabled()
          if enabled then
            vim.cmd("Copilot disable")
          else
            vim.cmd("Copilot enable")
          end
        end
      }
    },
    lualine_y = {
      -- 'filetype'
    },
    lualine_z = {
      -- 'location'
    },
  },
}
