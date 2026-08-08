-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- Save files touched by an LSP rename.
--
-- Neovim applies workspace edits in memory only, so a rename spanning files
-- leaves the unopened ones as hidden modified buffers (neovim/neovim#12129).
-- Buffers already modified before the rename are left alone: writing those
-- would silently commit unrelated in-progress edits.

---@type table<string, table<integer, true>>
local dirty_before = {}

---@return table<integer, true>
local function modified_buffers()
  local dirty = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].modified then
      dirty[buf] = true
    end
  end
  return dirty
end

--- 'readonly' is rejected up front: with 'confirm' set (LazyVim's default)
--- `:write` opens a dialog instead of failing, and dismissing it returns
--- success without writing anything. Other unwritable buffers (nofile,
--- unnamed, acwrite) raise a catchable error instead.
---@param buf integer
---@return boolean ok, string? err
local function write_buf(buf)
  if vim.bo[buf].readonly then
    return false, "'readonly' is set"
  end
  return pcall(vim.api.nvim_buf_call, buf, function()
    vim.cmd.write({ mods = { noautocmd = true, silent = true } })
  end)
end

---@param skip table<integer, true>
---@return integer saved
local function save_touched(skip)
  local saved, failed = 0, {}
  for buf in pairs(modified_buffers()) do
    if not skip[buf] then
      local ok, err = write_buf(buf)
      if ok then
        saved = saved + 1
      else
        failed[#failed + 1] = ('%s (%s)'):format(
          vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ':.'),
          tostring(err):match('E%d+:[^\n]*') or tostring(err)
        )
      end
    end
  end
  if #failed > 0 then
    vim.notify(
      'Rename applied but not saved:\n' .. table.concat(failed, '\n'),
      vim.log.levels.ERROR
    )
  end
  return saved
end

vim.api.nvim_create_autocmd('LspRequest', {
  group = vim.api.nvim_create_augroup('lsp_rename_autosave', { clear = true }),
  desc = 'Write files changed by an LSP rename',
  callback = function(ev)
    local request = ev.data.request
    if request.method ~= 'textDocument/rename' then
      return
    end

    local key = ('%d:%d'):format(ev.data.client_id, ev.data.request_id)
    if request.type == 'pending' then
      dirty_before[key] = modified_buffers()
      return
    end

    -- Cleared for 'cancel' too, otherwise cancelled renames leak entries.
    local skip = dirty_before[key]
    dirty_before[key] = nil
    if request.type == 'complete' and skip then
      -- LspRequest fires before the handler applies the workspace edit.
      vim.schedule(function()
        local saved = save_touched(skip)
        if saved > 0 then
          vim.notify(('Rename: saved %d file(s)'):format(saved))
        end
      end)
    end
  end,
})
