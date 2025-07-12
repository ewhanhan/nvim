-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Python host using dedicated uv environment with neovim module
vim.g.python3_host_prog = vim.fn.expand("~/.config/nvim-python/bin/python")

vim.g.snacks_animate = false

local opt = vim.opt

opt.swapfile = false
opt.incsearch = true
opt.spell = false
