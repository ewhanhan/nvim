-- Fix: LazyVim extra hardcodes chezmoi#source_dir_path, bypassing
-- .chezmoiroot and custom sourceDir. Resolve source directory via
-- `chezmoi source-path` with file-read fallback.
local source_dir = (function()
  local out = vim.fn.system('chezmoi source-path')
  if vim.v.shell_error == 0 then
    return vim.trim(out)
  end
  local base = vim.fs.normalize(vim.env.HOME .. '/.local/share/chezmoi')
  local f = io.open(base .. '/.chezmoiroot', 'r')
  if f then
    local root = f:read('*l')
    f:close()
    if root then
      root = vim.fs.normalize(vim.trim(root), { expand_env = false })
      if root ~= '' and not root:find('..', 1, true) then
        return vim.fs.joinpath(base, root)
      end
    end
  end
  return base
end)()

return {
  {
    'alker0/chezmoi.vim',
    init = function()
      vim.g['chezmoi#use_tmp_buffer'] = 1
      vim.g['chezmoi#source_dir_path'] = source_dir
    end,
  },
  {
    'xvzc/chezmoi.nvim',
    init = function()
      -- run chezmoi edit on file enter
      vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
        pattern = { source_dir .. '/*' },
        callback = function()
          vim.schedule(require('chezmoi.commands.__edit').watch)
        end,
      })
    end,
  },
}
