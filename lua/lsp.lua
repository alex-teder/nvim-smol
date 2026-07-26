vim.diagnostic.config({ virtual_text = true, severity_sort = true })

vim.o.autocomplete = true
vim.o.complete = 'o,.,w,b,u'
vim.o.completeopt = 'menu,menuone,popup,noinsert,noselect'

vim.o.pumheight = 20

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

require "lsp-sig-auto"

-- vim.api.nvim_create_autocmd('LspAttach', {
--   group = vim.api.nvim_create_augroup('LspSigAuto', {}),
--   callback = function(ev)
--     local client = vim.lsp.get_client_by_id(ev.data.client_id)
--     local provider = client
--       and client.server_capabilities.signatureHelpProvider
--     if not provider then return end
--
--     local triggers = {}
--     for _, c in ipairs(provider.triggerCharacters or {}) do triggers[c] = true end
--     for _, c in ipairs(provider.retriggerCharacters or {}) do triggers[c] = true end
--
--     vim.api.nvim_create_autocmd('InsertCharPre', {
--       buffer = ev.buf,
--       callback = function()
--         if triggers[vim.v.char] then
--           vim.schedule(function()
--             vim.lsp.buf.signature_help({ 
--               silent = true,
--               anchor_bias = 'above'
--             })
--           end)
--         end
--       end,
--     })
--
--     vim.api.nvim_create_autocmd('InsertLeave', {
--       buffer = ev.buf,
--       callback = function()
--         for _, w in ipairs(vim.api.nvim_list_wins()) do
--           if vim.w[w]['textDocument/signatureHelp'] then
--             pcall(vim.api.nvim_win_close, w, true)
--           end
--         end
--       end,
--     })
--   end,
-- })

-- vim.api.nvim_create_autocmd('LspAttach', {
--   group = vim.api.nvim_create_augroup('LspSigAuto', {}),
--   callback = function(ev)
--     local client = vim.lsp.get_client_by_id(ev.data.client_id)
--     local provider = client
--       and client.server_capabilities.signatureHelpProvider
--     if not provider then return end
--
--     local triggers = {}
--     for _, c in ipairs(provider.triggerCharacters or {})  do triggers[c] = true end
--     for _, c in ipairs(provider.retriggerCharacters or {}) do triggers[c] = true end
--     triggers[')'] = true  -- close on closing paren
--
--     local function close_sig_float()
--       for _, w in ipairs(vim.api.nvim_list_wins()) do
--         if vim.w[w]['textDocument/signatureHelp'] then
--           pcall(vim.api.nvim_win_close, w, true)
--         end
--       end
--     end
--
--     vim.api.nvim_create_autocmd('InsertCharPre', {
--       buffer = ev.buf,
--       callback = function()
--         local ch = vim.v.char
--         if not triggers[ch] then return end
--         if ch == ')' then
--           close_sig_float()
--         else
--           vim.schedule(function()
--             vim.lsp.buf.signature_help({
--               silent = true,
--               close_events = {},  -- don't dismiss on typing
--             })
--           end)
--         end
--       end,
--     })
--
--     vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufLeave', 'WinLeave' }, {
--       buffer = ev.buf,
--       callback = close_sig_float,
--     })
--   end,
-- })
