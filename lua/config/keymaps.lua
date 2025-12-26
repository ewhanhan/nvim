-- Custom keymaps
-- Default keymaps: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set

-- ════════════════════════════════════════════════════════════════════════════
-- Core Keymaps
-- ════════════════════════════════════════════════════════════════════════════
map('n', '<leader>fw', '<cmd>w<cr>', { desc = 'Write buffer / save file' })
map(
  'n',
  '<leader>fW',
  '<cmd>wall<cr>',
  { desc = 'Write all buffer(s) / save all file(s)' }
)

-- ════════════════════════════════════════════════════════════════════════════
-- Keymap Overrides
-- ════════════════════════════════════════════════════════════════════════════
-- root_spec = { 'cwd' } makes (cwd) variants redundant
-- Plugin keymaps disabled in lua/plugins/snacks.lua via keys = false
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  once = true,
  callback = function()
    pcall(vim.keymap.del, 'n', '<leader>gG') -- Lazygit (cwd)
    pcall(vim.keymap.del, 'n', '<leader>gL') -- Git Log (cwd)
  end,
})

-- ════════════════════════════════════════════════════════════════════════════
-- VSCode Integration
-- ════════════════════════════════════════════════════════════════════════════
if vim.g.vscode then
  require('config.vscode-keymaps')
end
