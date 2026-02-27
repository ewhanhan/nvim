-- Fix: LazyVim extra hardcodes chezmoi#source_dir_path, bypassing
-- .chezmoiroot. Resolve source directory via file read to avoid a
-- synchronous shell fork during startup.
local source_dir = (function()
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
