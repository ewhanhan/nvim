-- Default options: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local g = vim.g
local opt = vim.opt

-- === LAZYVIM GLOBALS ===
g.root_spec = { 'cwd' } -- Disable smart root detection, always use cwd
g.trouble_lualine = false -- Custom lualine sections; don't inject symbols
g.snacks_animate = false -- Disable all snacks animations (scroll, indent, etc.)
g.lazyvim_ts_lsp = 'tsgo' -- https://github.com/microsoft/typescript-go

-- === EDITOR OPTIONS ===
opt.exrc = true -- Project-local .nvim.lua/.lazy.lua config files
opt.swapfile = false
opt.colorcolumn = '80'

-- === REMOTE CLIPBOARD (SSH) ===
-- Route yanks through OSC 52 so they reach the local machine's clipboard across
-- the ssh + nested-tmux hops. Gated to SSH so local nvim keeps native pbcopy.
-- LazyVim empties 'clipboard' under SSH to allow this, but inside tmux Neovim's
-- provider picks the tmux buffer before OSC 52 (provider/clipboard.vim resolves
-- $TMUX before the osc52 branch), so force the provider explicitly here.
-- Paste reads the local register to avoid the "Waiting for OSC 52 response"
-- freeze; use the terminal's own paste (Cmd+V) to paste the host clipboard.
-- https://github.com/neovim/neovim/discussions/28010
if vim.env.SSH_CONNECTION then
  opt.clipboard = 'unnamedplus'

  local function paste()
    return { vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('') }
  end

  g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
      ['+'] = paste,
      ['*'] = paste,
    },
  }
end
