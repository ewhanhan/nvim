-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- ============================================================================
-- Global LazyVim Settings
-- ============================================================================
-- Python host using dedicated uv environment with neovim module
vim.g.python3_host_prog = vim.fn.expand('~/.config/nvim-python/bin/python')

-- Performance optimizations
vim.g.snacks_animate = false

-- Root directory specification
vim.g.root_spec = { 'cwd' }

-- ============================================================================
-- Editor Options
-- ============================================================================
local opt = vim.opt

-- Files and backup
opt.swapfile = false

-- Search behavior
opt.incsearch = true

-- Spell checking
opt.spell = false
