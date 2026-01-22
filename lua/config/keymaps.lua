-- Custom keymaps
-- Default keymaps: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set

-- === CORE KEYMAPS ===
map({ 'n', 'v', 'o' }, 'H', '^', { desc = 'First non-blank' })
map({ 'n', 'v', 'o' }, 'L', '$', { desc = 'End of line' })
map('n', '<leader>fw', '<cmd>w<cr>', { desc = 'Write buffer' })
map('n', '<leader>fW', '<cmd>wall<cr>', { desc = 'Write all buffers' })

-- === KEYMAP OVERRIDES ===
-- root_spec = { 'cwd' } makes (cwd) variants redundant
-- Plugin keymaps disabled in lua/plugins/snacks.lua via keys = false
-- Core keymaps deleted here (user config loads after LazyVim config)
pcall(vim.keymap.del, 'n', '<leader>fT') -- Terminal (cwd)
pcall(vim.keymap.del, 'n', '<leader>gG') -- Lazygit (cwd)
pcall(vim.keymap.del, 'n', '<leader>gL') -- Git Log (cwd)

-- === VSCODE INTEGRATION ===
if vim.g.vscode then
  require('config.vscode-keymaps')
end
