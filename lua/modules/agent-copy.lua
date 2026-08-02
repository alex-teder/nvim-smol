local function agent_copy()
  local mode = vim.fn.mode()
  local start_pos
  local end_pos

  if mode == "v" or mode == "V" or mode == "\22" then
    local anchor = vim.fn.getpos("v")
    local cursor = vim.fn.getpos(".")
    start_pos = { anchor[2], anchor[3] - 1 }
    end_pos = { cursor[2], cursor[3] - 1 }
  else
    mode = vim.fn.visualmode()
    start_pos = vim.api.nvim_buf_get_mark(0, "<")
    end_pos = vim.api.nvim_buf_get_mark(0, ">")
  end

  if start_pos[1] == 0 or end_pos[1] == 0 then
    vim.notify("AgentCopy requires a visual selection", vim.log.levels.WARN)
    return
  end

  if mode == "\22" then
    start_pos, end_pos =
        { math.min(start_pos[1], end_pos[1]), math.min(start_pos[2], end_pos[2]) },
        { math.max(start_pos[1], end_pos[1]), math.max(start_pos[2], end_pos[2]) }
  elseif start_pos[1] > end_pos[1] or (start_pos[1] == end_pos[1] and start_pos[2] > end_pos[2]) then
    start_pos, end_pos = end_pos, start_pos
  end

  local lines

  if mode == "V" then
    lines = vim.api.nvim_buf_get_lines(0, start_pos[1] - 1, end_pos[1], false)
  elseif mode == "\22" then
    lines = vim.api.nvim_buf_get_lines(0, start_pos[1] - 1, end_pos[1], false)
    for index, line in ipairs(lines) do
      lines[index] = line:sub(start_pos[2] + 1, end_pos[2] + 1)
    end
  else
    lines = vim.api.nvim_buf_get_text(
      0,
      start_pos[1] - 1,
      start_pos[2],
      end_pos[1] - 1,
      end_pos[2] + 1,
      {}
    )
  end
  local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
  local anchor = start_pos[1] == end_pos[1] and string.format("#L%d", start_pos[1])
    or string.format("#L%d-%d", start_pos[1], end_pos[1])
  local context = string.format(
    "@%s%s\n<file-context>\n%s\n</file-context>", path, anchor, table.concat(lines, "\n")
  )

  -- Let Neovim emit its normal yank feedback before replacing the register contents.
  vim.cmd.normal({ args = { '"+y' }, bang = true })
  vim.fn.setreg("+", context)
end

vim.api.nvim_create_user_command("AgentCopy", agent_copy, {
  desc = "Copy the visual selection together with its file path",
  range = true,
})

vim.keymap.set("x", "<leader>ya", agent_copy, {
  desc = "Copy selection with file path",
})
