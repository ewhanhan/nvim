-- Default options: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local g = vim.g
local opt = vim.opt

-- === LAZYVIM GLOBALS ===
g.snacks_animate = false
g.root_spec = { 'cwd' } -- Disable smart root detection, always use cwd

-- === EDITOR OPTIONS ===
opt.exrc = true -- Project-local .nvim.lua/.lazy.lua config files
opt.swapfile = false
opt.incsearch = true
opt.spell = false
opt.colorcolumn = '80'
