-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- ============================================================================
-- Global LazyVim Settings
-- ============================================================================
-- Performance optimizations
vim.g.snacks_animate = false

-- Root directory specification
vim.g.root_spec = { 'cwd' }

-- ============================================================================
-- Editor Options
-- ============================================================================
local opt = vim.opt

-- Enable project-local configuration files
-- .nvim.lua: General Neovim config (vim.g.dbs, options) - requires trust prompt
-- .lazy.lua: Plugin specs - handled by lazy.nvim's local_spec (enabled by default)
opt.exrc = true

-- Files and backup
opt.swapfile = false

-- Search behavior
opt.incsearch = true

-- Spell checking
opt.spell = false

opt.colorcolumn = '80'
