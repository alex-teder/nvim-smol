vim.diagnostic.config({ virtual_text = true, severity_sort = true })

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
