-- Custom keymaps
-- Default keymaps: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set

-- === CORE KEYMAPS ===
map('n', '<leader>fw', '<cmd>w<cr>', { desc = 'Write buffer' })
map('n', '<leader>fW', '<cmd>wall<cr>', { desc = 'Write all buffers' })

-- H → 0 (start of line); op-pending only (H = bufprev in normal)
map('o', 'H', '0', { desc = 'Start of line' })
-- L → $ (end of line); visual only (L = bufnext in normal)
map('x', 'L', '$', { desc = 'End of line' })

-- === KEYMAP OVERRIDES ===
-- root_spec = { 'cwd' } makes (cwd) variants redundant
-- Plugin keymaps disabled in lua/plugins/
-- Core keymaps deleted here (user config loads after LazyVim config)
pcall(vim.keymap.del, 'n', '<leader>fT') -- Terminal (cwd)
pcall(vim.keymap.del, 'n', '<leader>gG') -- Lazygit (cwd)
pcall(vim.keymap.del, 'n', '<leader>gL') -- Git Log (cwd)
