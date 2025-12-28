return {
  {
    'folke/snacks.nvim',
    -- Disable redundant (cwd) keymaps since root_spec = { 'cwd' }
    -- Note: <leader>fT is a core keymap, disabled in config/keymaps.lua
    keys = {
      { '<leader>E', false },
      { '<leader>fE', false },
      { '<leader>fF', false },
      { '<leader>sG', false },
      { '<leader>fR', false },
      { '<leader>sW', false, mode = { 'n', 'x' } },
    },
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true,
            ignored = false,
          },
          explorer = {
            hidden = true,
            ignored = false,
            auto_close = true,
          },
        },
      },
    },
  },
}
