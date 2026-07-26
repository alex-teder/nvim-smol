local M = {}

M.opts = {
  debounce_ms = 50,
  ignore_injections = false,  -- detect calls in injected languages too
  max_ancestor_depth = 20,
  -- override/extend per-language arglist node types, e.g.:
  -- node_type_overrides = { python = { 'arguments' } },
  node_type_overrides = {},
}

-- candidate arglist node type names (covers most languages)
local ARGLIST_CANDIDATES = { 'arguments', 'argument_list' }

-- cache: lang -> arglist type (or nil if none found)
local arglist_cache = {}

local function resolve_arglist_type(lang)
  if M.opts.node_type_overrides[lang] then
    return M.opts.node_type_overrides[lang][1]
  end
  if arglist_cache[lang] ~= nil then return arglist_cache[lang] end
  local ok, info = pcall(vim.treesitter.language.inspect, lang)
  local result
  if ok and info and info.symbols then
    for _, name in ipairs(ARGLIST_CANDIDATES) do
      if info.symbols[name] == true then  -- named node
        result = name
        break
      end
    end
  end
  arglist_cache[lang] = result or false
  return result
end

function M.in_call_args(buf)
  buf = buf or 0
  local ft = vim.bo[buf].filetype
  if ft == '' then return false end
  local lang = vim.treesitter.language.get_lang(ft)
  if not lang then return false end
  local arglist_type = resolve_arglist_type(lang)
  if not arglist_type then return false end

  local parser = vim.treesitter.get_parser(buf, lang)
  if not parser then return false end

  -- ensure the cursor line is parsed (3ms budget per slice)
  local row = vim.api.nvim_win_get_cursor(0)[1] - 1
  pcall(parser.parse, parser, { row, row })

  local node = vim.treesitter.get_node({
    bufnr = buf,
    ignore_injections = M.opts.ignore_injections,
  })
  if not node then return false end

  local depth = 0
  while node and depth < M.opts.max_ancestor_depth do
    if node:type() == arglist_type then return true end
    node = node:parent()
    depth = depth + 1
  end
  return false
end

function M.close_float()
  for _, w in ipairs(vim.api.nvim_list_wins()) do
    if vim.w[w]['textDocument/signatureHelp'] then
      pcall(vim.api.nvim_win_close, w, true)
    end
  end
end

local timer = nil

function M.show()
  if timer then timer:close() end
  timer = vim.defer_fn(function()
    timer = nil
    vim.lsp.buf.signature_help({
      silent = true,
      close_events = {},  -- manage lifecycle via TS
      focus = false,
      anchor_bias = 'above'
    })
  end, M.opts.debounce_ms)
end

function M.on_cursor_moved_i()
  if M.in_call_args(0) then
    M.show()
  else
    if timer then timer:close(); timer = nil end
    M.close_float()
  end
end

function M.setup(opts)
  M.opts = vim.tbl_deep_extend('force', M.opts, opts or {})
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('LspSigAuto', {}),
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if not client
        or not client.server_capabilities.signatureHelpProvider
      then return end

      vim.api.nvim_create_autocmd({ 'CursorMovedI', 'InsertEnter' }, {
        buffer = ev.buf,
        callback = function() M.on_cursor_moved_i() end,
      })
      vim.api.nvim_create_autocmd(
        { 'InsertLeave', 'BufLeave', 'WinLeave' },
        { buffer = ev.buf, callback = M.close_float }
      )
    end,
  })
end

M.setup()
return M
