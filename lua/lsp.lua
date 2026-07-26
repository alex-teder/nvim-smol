vim.diagnostic.config({ virtual_text = true, severity_sort = true })

local signs = {
  [vim.diagnostic.severity.ERROR] = "󰅚 ",
  [vim.diagnostic.severity.WARN]  = " ",
  [vim.diagnostic.severity.HINT]  = " ",
  [vim.diagnostic.severity.INFO]  = " ",
}

local hl_map = {
  [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
  [vim.diagnostic.severity.WARN]  = 'DiagnosticSignWarn',
  [vim.diagnostic.severity.HINT]  = 'DiagnosticSignHint',
  [vim.diagnostic.severity.INFO]  = 'DiagnosticSignInfo',
}

vim.diagnostic.config({
  signs = {
    text = signs,
  },
  status = {
    format = function(severity_counts)
      local items = {}
      for severity in ipairs(vim.diagnostic.severity) do
        local count = severity_counts[severity] or 0
        if count ~= 0 then
          table.insert(items, ("%%#%s#[%s%s]"):format(hl_map[severity], signs[severity], count))
        end
      end
      return table.concat(items)
    end
  }
})

vim.o.autocomplete = true
vim.o.complete = 'o,.,w,b,u'
vim.o.completeopt = 'menu,menuone,popup,noinsert,noselect'

vim.o.pumheight = 10
vim.o.pumborder = "rounded"

local _open_floating_preview = vim.lsp.util.open_floating_preview
vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
  opts            = opts or {}
  opts.border     = opts.border or 'rounded'
  opts.max_width  = opts.max_width or 90
  opts.max_height = opts.max_height or 12
  return _open_floating_preview(contents, syntax, opts, ...)
end

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

    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, {
        autotrigger = true,
        convert = function(item)
          local abbr = item.label
          abbr = abbr:gsub("%b()", ""):gsub("%b{}", "")
          abbr = abbr:match("[%w_.]+.*") or abbr
          abbr = #abbr > 30 and abbr:sub(1, 29) .. "…" or abbr

          local menu = item.detail or ""
          menu = #menu > 30 and menu:sub(1, 29) .. "…" or menu

          return { abbr = abbr, menu = menu }
        end,
      })
    end
  end,
})

require "modules.lsp-sig-auto"
